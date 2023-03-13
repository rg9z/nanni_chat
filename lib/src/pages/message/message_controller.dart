import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nanni_chat/src/models/user.dart';
import 'package:nanni_chat/src/pages/chat/chat_controller.dart';

import '../../global.dart';
import '../../models/message.dart';

class MessageController extends GetxController {
  var socket = Get.find<ChatController>().socketService;
  TextEditingController contentController = TextEditingController();
  var messages = Get.find<ChatController>().messages;
  var messageUser = Rxn<User>();
  ScrollController scrollController = ScrollController();
  var ls;
  @override
  void onInit() {
    print("hiii");
    try {
      messageUser.value = Get.arguments['user']!;
      print("${Get.arguments}");

      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });

      ls = messages.listen((p0) {
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

    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    ls.cancel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ls.cancel();
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
    socket.sendMessageHandler(message.toJson());
  }
}
