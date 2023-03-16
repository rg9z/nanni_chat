import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nanni_chat/src/common/colors.dart';

import 'src/global.dart';
import 'src/pages/index/index_binding.dart';
import 'src/pages/index/index_page.dart';
import 'src/router/app_pages.dart';

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Nanni",
      debugShowCheckedModeBanner: false,
      enableLog: true,
      theme: ThemeData(
        fontFamily: 'Gilroy',
      ),
      home: const IndexPage(),
      initialBinding: IndexBinding(),
      getPages: AppPages.routes,
      darkTheme: ThemeData(
          primaryColor: AppColors.cyan,
          scaffoldBackgroundColor: AppColors.darkPrimary,
          textTheme: const TextTheme(
            displaySmall: TextStyle(color: Colors.white),
            displayMedium: TextStyle(color: Colors.white),
            displayLarge: TextStyle(color: Colors.white),
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(
              color: Colors.white,
              fontSize: 16
            ),
            bodySmall: TextStyle(color: AppColors.grey),
            titleLarge: TextStyle(color: Colors.white),
            titleMedium: TextStyle(color: Colors.white),
            titleSmall: TextStyle(color: Colors.white),
          )),
      themeMode: ThemeMode.dark,
    );
  }
}
