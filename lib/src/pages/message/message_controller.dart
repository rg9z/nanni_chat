import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nanni_chat/src/common/constants.dart';
import 'package:nanni_chat/src/data/app_db.dart';
import 'package:nanni_chat/src/models/user.dart';
import 'package:nanni_chat/src/pages/chat/chat_controller.dart';

import '../../global.dart';
import '../../models/message.dart';
import '../../widgets/card_item.dart';
import '../../widgets/list_model.dart';

class MessageController extends GetxController {
  var socket = Get.find<ChatController>().socketService;
  TextEditingController contentController = TextEditingController();
  late FocusNode contentFocusNode;
  var messages = Get.find<ChatController>().messages;
  var readyChatListener = Get.find<ChatController>().readyChatListener;
  // var messages = [].obs;
  var messageUser = Rxn<User>();
  ScrollController scrollController = ScrollController();
  var currentUserMessagesBox = Rxn();
  var currentMessagesLength = 20.obs;
  var showtime = Rxn();

  final listMessage = <Message>[].obs;
  final showSticker = false.obs;
  final GlobalKey<SliverAnimatedListState> listKey =
      GlobalKey<SliverAnimatedListState>();
  late ListMessage list;
  var ls;
  final hasLoadMore = false.obs;
  final showOver = false.obs;
  get removedItemBuilder => Container();

  @override
  void onInit() {
    contentFocusNode = FocusNode();

    initMessage();
    super.onInit();
  }

  @override
  void onReady() {
    contentFocusNode.addListener(
      () {},
    );
  }

  @override
  void onClose() {
    ls?.cancel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ls?.cancel();
    contentFocusNode.dispose();
  }

  void initMessage() async {
    try {
      messageUser.value = Get.arguments['user']!;
      await openMessagesBox();
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   scrollController.jumpTo(0);
      // });
      ls = readyChatListener.listen((p0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController != null) {
            scrollController.animateTo(0,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut);
          }
        });
        var updateChat = Get.find<ChatController>()
            .chats
            .value
            .get(messageUser.value!.userId);
        if (updateChat != null) {
          updateChat.isRead = true;
          updateChat.save();
          Get.find<ChatController>().chats.refresh();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildRemovedItem(
      int item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      index: item,
      item: list[item],
    );
  }

  Future<void> openMessagesBox() async {
    // currentUserMessagesBox = await Hive.openBox<Message>(messageUser.value!.userId!);
    // messages.value = currentUserMessagesBox.values.toList();
    // print(messages);
    // print(currentUserMessagesBox);
    var listMsg = await AppDB.getMessage(messageUser.value!.userId!);
    // await currentUserMessagesBox.value.clear();
    var lm = <Message>[];
    for (var i = 0; i < listMsg.length; i++) {
      lm.add(Message(
          id: listMsg[i].id.toString(),
          messageBody: listMsg[i].messageBody,
          messageType: listMsg[i].messageType,
          createdAt: listMsg[i].createdAt.millisecondsSinceEpoch.toString(),
          from: listMsg[i].from,
          to: listMsg[i].to));
    }
    ;
    if (lm.length < maxMessage) {
      showOver.value = true;
    }
    list = ListMessage(
        listKey: listKey,
        removedItemBuilder: _buildRemovedItem,
        initialItems: lm);
    listMessage.value = lm;

    var updateChat =
        Get.find<ChatController>().chats.value.get(messageUser.value!.userId);
    if (updateChat != null) {
      updateChat.isRead = true;
      await updateChat.save();
      Get.find<ChatController>().chats.refresh();
    }
  }

  void onSendMessage() async {
    MessageType type = MessageType.text;
    Message message = Message(
        chatId: DateTime.now().millisecondsSinceEpoch.toString(),
        messageBody: contentController.text,
        messageType: type.valueAsString(),
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        from: Global.userInfo!.userId,
        to: messageUser.value!.userId.toString());

    contentController.text = '';

    AppDB.insertMessage({
      'userId': messageUser.value!.userId.toString(),
      'messageBody': message.messageBody,
      'messageType': message.messageType,
      'createdAt': message.createdAt,
      'from': message.from,
      'to': message.to,
    });
    list.insert(0, message);
    // send to socket.
    socket.sendMessageHandler(message.toJson());
  }

  void loadMore() async {
    print("Load More");
    hasLoadMore.value = true;
    var kl =
        await AppDB.getMessage(messageUser.value!.userId!, offset: list.length);
    var lm = <Message>[];
    for (var i = 0; i < kl.length - 1; i++) {
      lm.add(Message(
          id: kl[i].id.toString(),
          messageBody: kl[i].messageBody,
          messageType: kl[i].messageType,
          createdAt: kl[i].createdAt.millisecondsSinceEpoch.toString(),
          from: kl[i].from,
          to: kl[i].to));
    }
    ;
    list.insertAll(list.length, lm);
    if (kl.length < maxMessage) {
      showOver.value = true;
    }
    hasLoadMore.value = false;
  }

  void stickerToggle() {
    showSticker.value = !showSticker.value;
    if (showSticker.value) {
      contentFocusNode.unfocus();
    } else {
      contentFocusNode.requestFocus();
    }
  }
}
