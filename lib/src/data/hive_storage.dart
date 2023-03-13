import 'dart:ffi';

import 'package:hive/hive.dart';
import 'package:nanni_chat/src/common/storage.dart';

import '../models/user.dart';

class HiveStorage {
  static var globalBox;
  static Future<void> init() async {
    globalBox = (await Hive.openBox('global'));
  }

  static void saveUserLogin(User user) {
    globalBox.put(STORAGE_USER_PROFILE_KEY, user);
  }

  static User? getUserLogin() {
    return globalBox.get(STORAGE_USER_PROFILE_KEY);
  }

  static void saveSession(String sessionId) {
    globalBox.put(STORAGE_SESSION_ID_KEY, sessionId);
  }

  static String? getSession() {
    return globalBox.get(STORAGE_SESSION_ID_KEY);
  }

  static void remove(String key) {
    globalBox.delete(key);
  }
}
