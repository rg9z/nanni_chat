import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nanni_chat/src/data/hive_storage.dart';
import 'package:nanni_chat/src/models/chat.dart';
import 'package:nanni_chat/src/models/user.dart';
import 'package:nanni_chat/src/pages/chat/chat_controller.dart';

import '../../global.dart';
import '../../models/message.dart';

class MessageController extends GetxController {
  var socket = Get.find<ChatController>().socketService;
  TextEditingController contentController = TextEditingController();
  var messages = Get.find<ChatController>().messages;
  var readyChatListener = Get.find<ChatController>().readyChatListener;
  // var messages = [].obs;
  var messageUser = Rxn<User>();
  ScrollController scrollController = ScrollController();
  var currentUserMessagesBox = Rxn();
  var currentMessagesLength = 20.obs;
  var ls;
  @override
  void onInit() {
    
    initMessage();
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    ls?.cancel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ls?.cancel();
  }

  void initMessage() async{
    try {
      messageUser.value = Get.arguments['user']!;
      await openMessagesBox();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });

      ls = readyChatListener.listen((p0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController != null) {
            scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut);
          }
        });
      });
    } catch (e) {
      print(e);
    }
  }
  Future<void>  openMessagesBox() async{
    // currentUserMessagesBox = await Hive.openBox<Message>(messageUser.value!.userId!);
    // messages.value = currentUserMessagesBox.values.toList();
    // print(messages);
    // print(currentUserMessagesBox);
    currentUserMessagesBox.value = messages[messageUser.value!.userId];
  }
  void onSendMessage() {
    MessageType type = MessageType.text;
    Message message = Message(
        chatId: DateTime.now().millisecondsSinceEpoch.toString(),
        messageBody: contentController.text,
        messageType: type.valueAsString(),
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        from: Global.userInfo!.userId,
        to: messageUser.value!.userId.toString());

    // if (usersMap[chatUserInfo.userId] == null) {
    //   usersMap[chatUserInfo.userId] = {'info': chatUserInfo, 'message': []};
    // }
    // usersMap[chatUserInfo.userId]['message'].add(message);
    // usersMap.refresh();
    contentController.text = '';
    // chatKeysList.value.add(chatUserInfo.userId.toString());
    // await messagesBox.put(chatUserInfo.userId.toString(),
    //     [...usersMap[chatUserInfo.userId]['message'], message]);

    Get.find<ChatController>().addNewMessage(message);
    if(currentUserMessagesBox.value == null){
     currentUserMessagesBox.value = messages[messageUser.value!.userId];
     currentUserMessagesBox.refresh();
    }
    // send to socket.
    socket.sendMessageHandler(message.toJson());
  }
}
