import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nanni_chat/src/models/chat.dart';
import 'package:nanni_chat/src/models/message.dart';
import 'package:path_provider/path_provider.dart';
import '/src/data/hive_storage.dart';
import '/src/models/user.dart';

class Global {
  static bool isOfflineLogin = false;
  static var userInfo;

  /// init
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarBrightness:
            Brightness.dark //or set color with: Color(0xFF0000FF)
        ));
    await Hive.initFlutter();
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDocDir.path)
      ..registerAdapter(UserAdapter())
      ..registerAdapter(MessageAdapter())
      ..registerAdapter(ChatAdapter());
    await HiveStorage.init();
    var userLogin = HiveStorage.getUserLogin();
    if (userLogin != null) {
      userInfo = userLogin;
      isOfflineLogin = true;
    } else {
      isOfflineLogin = false;
    }
  }
}
