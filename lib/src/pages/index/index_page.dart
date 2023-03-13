import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';
import '../splash/splash_page.dart';
import 'index_controller.dart';

class IndexPage extends GetView<IndexController> {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: controller.isloadWelcomePage.isTrue
              ? SplashPage()
              : Global.isOfflineLogin
                  ? HomePage()
                  : const LoginPage(),
        ));
  }
}
