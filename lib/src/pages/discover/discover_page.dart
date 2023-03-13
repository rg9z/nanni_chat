import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'discover_controller.dart';

class DiscoverPage extends GetView<DiscoverController> {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('disvover')),
    );
  }
}
