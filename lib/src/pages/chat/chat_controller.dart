import 'package:get/get.dart';
import 'package:nanni_chat/src/global.dart';
import 'package:nanni_chat/src/models/message.dart';
import 'package:nanni_chat/src/pages/message/message_page.dart';

import '../../models/user.dart';
import '../../models/user_online.dart';
import '../../services/socket_service.dart';
import '../message/message_controller.dart';

class ChatController extends GetxController {
  SocketService socketService = SocketService();
  var userOnlines = <UserOnline>[].obs;

  final messages = <String, List<Message>>{}.obs;
  final chats = 3.obs;
  @override
  void onInit() {
    socketService.initSocket();
    onUsersSession();
    onMessage();
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void onUsersSession() async {
    socketService.onUsers((users) async {
      var usersSession = <UserOnline>[];
      users.forEach((user) {
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

  void addNewMessage(Message newMessage) {
    var messageKey = newMessage.from == Global.userInfo!.userId
        ? newMessage.to
        : newMessage.from;

    if (messages.containsKey(messageKey)) {
      messages[messageKey]!.add(newMessage);
    } else {
      messages[messageKey!] = [];
      messages[messageKey]!.add(newMessage);
    }
    messages.refresh();
  }

  void goToMessage(int messageIndex) {
    Get.lazyPut(() => MessageController());
    Get.to(() => MessagePage(), arguments: {
      'index': messageIndex,
      'user': userOnlines[messageIndex].user
    });
  }
}
