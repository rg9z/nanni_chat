import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nanni_chat/src/pages/settings/settings_page.dart';
import '../chat/chat_page.dart';
import '../discover/discover_page.dart';

import '../../widgets/blur_bottom_navigation.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  List<BottomItem> listBottomMenu = [
    BottomItem(icon: Iconsax.message5, name: 'chat'),
    BottomItem(icon: Iconsax.discover5, name: 'discover'),
    BottomItem(icon: Iconsax.menu5, name: 'menu'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Obx(() => IndexedStack(
                index: controller.currentIndex.value,
                children: [ChatPage(), DiscoverPage(), SettingsPage()],
              )),
          Positioned(
            bottom: 0,
            child: Obx(() => BlurBottomNavigation(
                  items: [
                    for (var i = 0; i < listBottomMenu.length; i++)
                      BlurBottomNavagationItem(
                        icon: listBottomMenu[i].icon,
                        isSelected: controller.currentIndex.value == i,
                      ),
                  ],
                  onChange: controller.onPageChange,
                )),
          )
        ],
      ),
    );
  }
}
