import 'package:get/get.dart';
import 'package:nanni_chat/src/common/storage.dart';
import 'package:nanni_chat/src/data/hive_storage.dart';

import '../login/login_controller.dart';
import '../login/login_page.dart';

class SettingsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
  void logout() {
    HiveStorage.remove(STORAGE_USER_PROFILE_KEY);
    Get.lazyPut<LoginController>(() => LoginController());

    Get.offAll(() => LoginPage());
  }
}
