import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/simple_button.dart';
import 'settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Settings"),
          SimpleButton(
            text: "Logout",
            onTap: () => controller.logout(),
          ),
        ],
      ),
    );
  }
}
