import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nanni_chat/src/ultis/screen_device.dart';
import 'package:nanni_chat/src/widgets/simple_button.dart';
import 'package:nanni_chat/src/widgets/simple_textfield.dart';

import '../../common/colors.dart';
import 'profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      // alignment: Alignment.center,
      children: [
        Positioned(
            top: 0,
            bottom: 0,
            left: getDeviceWidth(context) * 0.8,
            child: Container(
              width: 1,
              height: 300,
              color: Color(0xFF171F26),
            )),
        Container(
          width: getDeviceHeight(context),
          height: getDeviceHeight(context),
        ),
        Positioned(
            top: 0,
            bottom: 0,
            left: getDeviceWidth(context) * 0.45,
            child: Container(
              width: 1,
              height: 300,
              color: Color(0xFF171F26),
            )),
        Container(
          width: getDeviceHeight(context),
          height: getDeviceHeight(context),
        ),
        Positioned(
            top: 0,
            bottom: 0,
            left: getDeviceWidth(context) * 0.1,
            child: Container(
              width: 1,
              height: 300,
              color: Color(0xFF171F26),
            )),
        Container(
          width: getDeviceHeight(context),
          height: getDeviceHeight(context),
        ),
        Positioned(
            left: 0,
            right: 0,
            top: getDeviceHeight(context) * 0.1,
            child: Container(
              height: 1,
              color: Color(0xFF171F26),
            )),
        Container(
          width: getDeviceHeight(context),
          height: getDeviceHeight(context),
        ),
        Positioned(
            left: 0,
            right: 0,
            top: getDeviceHeight(context) * 0.25,
            child: Container(
              height: 1,
              color: Color(0xFF171F26),
            )),
        Container(
          width: getDeviceHeight(context),
          height: getDeviceHeight(context),
        ),
        Positioned(
            left: 0,
            right: 0,
            top: getDeviceHeight(context) * 0.4,
            child: Container(
              height: 1,
              color: Color(0xFF171F26),
            )),
        Container(
          width: getDeviceHeight(context),
          height: getDeviceHeight(context),
        ),
        Positioned(
            left: 0,
            right: 0,
            top: getDeviceHeight(context) * 0.55,
            child: Container(
              height: 1,
              color: Color(0xFF171F26),
            )),
        Container(
          width: getDeviceHeight(context),
          height: getDeviceHeight(context),
        ),
        Positioned(
            left: 0,
            right: 0,
            top: getDeviceHeight(context) * 0.7,
            child: Container(
              height: 1,
              color: Color(0xFF171F26),
            )),
        Container(
          width: getDeviceHeight(context),
          height: getDeviceHeight(context),
        ),
        Positioned(
            left: 0,
            right: 0,
            top: getDeviceHeight(context) * 0.85,
            child: Container(
              height: 1,
              color: Color(0xFF171F26),
            )),
        Container(
          width: getDeviceHeight(context),
          height: getDeviceHeight(context),
        ),
        SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: getDeviceTopHeight(context) + kToolbarHeight,
              ),
              const Text("Create new profile",
                  style: TextStyle(
                      color: AppColors.greySecond,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                      child: Text("Username",
                          style: TextStyle(
                            color: AppColors.greySecond,
                          )),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: SimpleTextField(
                          margin: EdgeInsets.all(0),
                          hintText: 'Your name',
                          controller: controller.usernameController,
                          backgroundColor: Color(0xFF4B5158).withOpacity(0.2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text("Select an avatar",
                      style: TextStyle(
                        color: AppColors.greySecond,
                      )),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Obx(() => Wrap(
                    children: [
                      for (var i = 0; i < 20; i++)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: GestureDetector(
                                  onTap: () => controller.selectAvatar(i),
                                  child: Container(
                                    width: (getDeviceWidth(context) - 104) / 4,
                                    height: (getDeviceWidth(context) - 104) / 4,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 75, 74, 74),
                                        shape: BoxShape.circle,
                                        border: null,
                                        boxShadow:
                                            i == controller.avatarSelected.value
                                                ? [
                                                    BoxShadow(
                                                        color: AppColors.mint
                                                            .withOpacity(0.5),
                                                        spreadRadius: 2,
                                                        blurRadius: 10,
                                                        offset: Offset.zero)
                                                  ]
                                                : null),
                                    child: Image.asset(
                                        "assets/images/avatars/${i + 1}.png"),
                                  ),
                                ),
                              ),
                              if (i == controller.avatarSelected.value)
                                Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.blue),
                                      padding: EdgeInsets.all(2),
                                      child: Icon(
                                        Icons.check_rounded,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ))
                            ],
                          ),
                        ),
                    ],
                  )),
              const SizedBox(
                height: 32,
              ),
              SimpleButton(
                text: "Create",
                backgroundColor: AppColors.mint,
                onTap: () => controller.createNewProfile(),
                textStyle: const TextStyle(
                    color: AppColors.darkPrimary, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
