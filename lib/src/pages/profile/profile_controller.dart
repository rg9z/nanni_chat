import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nanni_chat/src/global.dart';
import 'package:nanni_chat/src/models/user.dart';
import 'package:nanni_chat/src/pages/home/home_page.dart';

import '../../data/hive_storage.dart';
import '../../services/repositories/user_repository.dart';

class ProfileController extends GetxController {
  final avatarSelected = 0.obs;
  TextEditingController usernameController = TextEditingController();
  UserRepository _userRepository = UserRepository();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
  void selectAvatar(int index) {
    avatarSelected.value = index;
  }

  Future<void> createNewProfile() async {
    try {
      if (usernameController.text != '') {
        var data = Get.arguments;
        var response = await _userRepository.createProfile(
            usernameController.text, data['userId'], avatarSelected.toString());
        if (response['success']) {
          //
          var user = response['user'];
          var userInfo = User.fromJson(response['user']);
          // go to home
          Global.userInfo = userInfo;
          //save user
          HiveStorage.saveUserLogin(userInfo);
          Get.offAll(() => HomePage());
        } else {}
      }
    } catch (e) {
      print(e);
    }
  }
}
