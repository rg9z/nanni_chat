import 'package:get/get.dart';
import '../pages/chat/chat_binding.dart';
import '../pages/chat/chat_page.dart';
import '../pages/home/home_binding.dart';
import '../pages/home/home_page.dart';
import '../pages/login/login_binding.dart';
import '../pages/login/login_page.dart';
import '../pages/message/message_binding.dart';
import '../pages/message/message_page.dart';

import '../pages/index/index_page.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.index;

  static final routes = [
    GetPage(
      name: AppRoutes.index,
      page: () => IndexPage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => ChatPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.message,
      page: () => MessagePage(),
      binding: MessageBinding(),
    ),
  ];
}
