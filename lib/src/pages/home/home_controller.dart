import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void onPageChange(int index) {
    currentIndex.value = index;
  }
}
