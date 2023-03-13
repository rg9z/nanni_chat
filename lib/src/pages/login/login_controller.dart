import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:nanni_chat/src/data/hive_storage.dart';
import 'package:nanni_chat/src/global.dart';
import 'package:nanni_chat/src/models/user.dart';
import 'package:nanni_chat/src/pages/home/home_page.dart';
import 'package:nanni_chat/src/pages/profile/profile_page.dart';

import '../../services/repositories/user_repository.dart';

class LoginController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        "740476578502-gg9u6eul97tihtqp9levk8b9hbstg073.apps.googleusercontent.com",
  );
  UserRepository _loginRepository = UserRepository();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future<void> handleSignIn() async {
    try {
      var _sign = await _googleSignIn.signIn();
      var user = await _loginRepository.getUser(_sign?.id);
      if (user == null) {
        // go to create profile
        Get.to(ProfilePage(), arguments: {"userId": _sign?.id});
      } else {
        Global.userInfo = user;
        //save user
        HiveStorage.saveUserLogin(user);
        // go to home
        Get.offAll(() => HomePage());
      }
    } catch (error) {
      print(error);
    }
  }
}
