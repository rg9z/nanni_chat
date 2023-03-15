import 'package:get/get.dart';
import 'package:nanni_chat/src/pages/profile/profile_controller.dart';
import 'package:nanni_chat/src/pages/settings/settings_controller.dart';
import '../chat/chat_controller.dart';
import '../discover/discover_controller.dart';
import '../home/home_controller.dart';
import '../login/login_controller.dart';
import 'index_controller.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndexController>(() => IndexController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ChatController>(() => ChatController());
    Get.lazyPut<DiscoverController>(() => DiscoverController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
