import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../common/colors.dart';
import '../ultis/screen_device.dart';

class FlexToolBar extends StatefulWidget {
  FlexToolBar(
      {super.key,
      this.content,
      this.hasBack = false,
      this.onlyStatusBar = false,
      this.lightMode = false});
  Widget? content;
  bool? hasBack;
  bool? onlyStatusBar;
  bool? lightMode;
  @override
  State<FlexToolBar> createState() => _FlexToolBarState();
}

class _FlexToolBarState extends State<FlexToolBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget.onlyStatusBar == true ? 0 : getDeviceTopHeight(context)) +
          kToolbarHeight,
      padding: EdgeInsets.only(
          top: getDeviceTopHeight(context),
          left: widget.hasBack == true ? 0 : 16,
          right: 16),
      // color: Colors.amber,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        widget.hasBack == true
            ? Container(
                margin: EdgeInsets.only(right: 12),
                height: kToolbarHeight,
                width: kToolbarHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Iconsax.arrow_left_2,
                          color: widget.lightMode == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
        Expanded(
            child:
                widget.content != null ? widget.content as Widget : Container())
      ]),
    );
  }
}
