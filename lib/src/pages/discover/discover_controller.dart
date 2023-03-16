import 'package:get/get.dart';

import '../../models/user.dart';
import '../../models/user_online.dart';
import '../chat/chat_controller.dart';

class DiscoverController extends GetxController {
    var userOnlines = Get.find<ChatController>().userOnlines;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
    void goToMessage(User user) {
   Get.find<ChatController>().goToMessage(user);
  }
}
