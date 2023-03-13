import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nanni_chat/src/common/colors.dart';
import 'package:nanni_chat/src/ultis/screen_device.dart';

class BlurBottomNavigation extends StatefulWidget {
  const BlurBottomNavigation({super.key, required this.items, this.onChange});
  final List<Widget> items;
  final Function(int index)? onChange;
  @override
  State<BlurBottomNavigation> createState() => _BlurBottomNavigationState();
}

class _BlurBottomNavigationState extends State<BlurBottomNavigation> {
  int currentPosition = 0;
  @override
  Widget build(BuildContext context) {
    var height =
        getDeviceBottomHeight(context) + kBottomNavigationBarHeight + 12;
    var kWidth = getDeviceWidth(context) * 0.7;
    return Container(
      height: height,
      // color: Colors.amber,
      padding: EdgeInsets.only(bottom: getDeviceBottomHeight(context)),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(kBottomNavigationBarHeight / 2),
            child: Material(
              color: Colors.transparent,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  height: kBottomNavigationBarHeight,
                  width: getDeviceWidth(context) * 0.7,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                          kBottomNavigationBarHeight / 2)),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var i = 0; i < widget.items.length; i++)
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    currentPosition = i;
                                  });
                                  widget.onChange!(i);
                                },
                                child: Container(
                                  height: double.infinity,
                                  child: widget.items[i],
                                ),
                              ),
                            )
                        ],
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 100),
                        bottom: 0,
                        left: kWidth / (widget.items.length / currentPosition) +
                            (kWidth / widget.items.length / 2) -
                            ((kWidth / widget.items.length) * 0.3 / 2),
                        child: Container(
                          height: 6,
                          width: (kWidth / widget.items.length) * 0.3,
                          decoration: const BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BlurBottomNavagationItem extends StatelessWidget {
  BlurBottomNavagationItem(
      {super.key, required this.icon, this.isSelected = false});
  final IconData icon;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: isSelected ? AppColors.blue : AppColors.grey,
    );
  }
}

class BottomItem {
  BottomItem({required this.icon, required this.name});
  final IconData icon;
  final String name;
}
