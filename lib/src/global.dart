import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
    Hive.registerAdapter(UserAdapter());
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
