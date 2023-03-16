import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nanni_chat/src/data/hive_storage.dart';
import 'package:nanni_chat/src/global.dart';
import 'package:nanni_chat/src/models/chat.dart';
import 'package:nanni_chat/src/models/message.dart';
import 'package:nanni_chat/src/pages/message/message_page.dart';

import '../../models/user.dart';
import '../../models/user_online.dart';
import '../../services/socket_service.dart';
import '../message/message_controller.dart';

class ChatController extends GetxController {
  SocketService socketService = SocketService();
  var userOnlines = <UserOnline>[].obs;

  final messages = <String, dynamic>{}.obs;
  final chats = Rxn();
  final current = 0.obs;

  final currentChatReady = Rxn<User>();

  final readyChatListener = 0.obs;
  @override
  void onInit() {
    socketService.initSocket();
    onUsersSession();
    onMessage();
    initChats();
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
  Future<void> initChats() async {
    chats.value = HiveStorage.chatsBox;

    for (var chat in HiveStorage.chatsBox.keys) {
      messages[chat] = await Hive.openBox<Message>(chat);
    }
    print(messages);
  }

  void onUsersSession() async {
    socketService.onUsers((users) async {
      var usersSession = <UserOnline>[];
      users.forEach((user) {
        if(user['user_id'] != Global.userInfo.userId)
        usersSession.add(
            UserOnline(user: User.fromJson(user), isOnline: user['connected']));
      });
      userOnlines.value = usersSession;
    });
  }

  void onMessage() async {
    socketService.onMessage((message) async {
      var newMessage = Message.fromJson(message);
      addNewMessage(newMessage);
    });
  }

  Future<void> addNewMessage(Message newMessage) async {
    var messageKey = newMessage.from == Global.userInfo!.userId
        ? newMessage.to
        : newMessage.from;

    if (messages.containsKey(messageKey)) {
      messages[messageKey]!.add(newMessage);
    } else {
      messages[messageKey!] = await Hive.openBox<Message>(messageKey);
      messages[messageKey]!.add(newMessage);
    }

    var updateChat = chats.value.get(messageKey);
    if (updateChat == null) {
      chats.value.put(
          messageKey,
          Chat(
              uid: messageKey,
              user: userOnlines
                  .where((p0) => p0.user.userId == messageKey)
                  .first
                  .user,
              latestMessage: newMessage));
    } else {
      updateChat.latestMessage = newMessage;
      updateChat.updateAt = newMessage.createdAt;
      updateChat.isRead = false;
      updateChat.save();
    }
    if (currentChatReady.value != null &&
        currentChatReady.value!.userId == messageKey) {
      readyChatListener.refresh();
    }
    chats.refresh();

    messages.refresh();
  }

  void goToMessage(User user) {
    Get.lazyPut(() => MessageController());
    currentChatReady.value = user;
    Get.to(() => MessagePage(), arguments: {'user': user})!.whenComplete(() {
      currentChatReady.value = null;
    });
  }
}
