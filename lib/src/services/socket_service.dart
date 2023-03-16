import 'package:nanni_chat/src/data/hive_storage.dart';
import 'package:nanni_chat/src/global.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../config.dart';
import '../models/user.dart';

class SocketService {
  Socket socket = io(
      SERVER_URL,
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build());

  initSocket() {
    onSession();
    onConnectError();
    onSocketError();
    onConnect();
    // connect socket
    connectSocket(Global.userInfo!);
  }

  void connectSocket(User user) async {
    var sessionId = HiveStorage.getSession();
    socket.auth = {
      'username': user.username,
      'userId': user.userId,
      'sessionID': sessionId,
      'avatar': user.avatar,
    };
    socket.connect();
  }

  void onSession() {
    socket.on('session', (data) {
      socket.auth = {'sessionID': data['sessionID']};
      HiveStorage.saveSession(data['sessionID']);
      print('session OK');
    });
  }

  void onConnectError() {
    socket.on("connect_error", (users) {
      print('connect_error');
    });
  }

  void onSocketError() {
    socket.on("error", (data) {
      // reconnect session.
      if (data['message'] == 'invalid username') {
        // var profileJSON = LoacalStorage().getJSON(STORAGE_USER_PROFILE_KEY);
        // var profile = User.fromJsonLocal(profileJSON);
        // connectSocket(profile);
      }
    });
  }

  void onConnect() {
    socket.onConnect((_) {
      print("Socket Connected!");
    });
  }

  void onUsers(Function callback) {
    socket.on('users', (data) => {callback(data)});
  }

  void onMessage(Function receiveMessageHandler) {
    socket.on("private message", (data) => {receiveMessageHandler(data)});
  }

  /// Actions
  void sendMessageHandler(data) {
    socket.emit('private message', data);
    //ignore:avoid_print
    // print(data);
  }
}
