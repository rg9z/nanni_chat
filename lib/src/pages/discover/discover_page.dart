import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'discover_controller.dart';

class DiscoverPage extends GetView<DiscoverController> {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Wrap(
        children: [ for (var userOnlineIndex = 0;
                      userOnlineIndex < controller.userOnlines.length;
                      userOnlineIndex++)
                    InkWell(
                      onTap: () => controller.goToMessage(
                          controller.userOnlines[userOnlineIndex].user),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.blue,
                          margin: EdgeInsets.all(6),
                          child: Text(
                              "${controller.userOnlines[userOnlineIndex].user.username}")),
                    )],)),
    );
  }
}
