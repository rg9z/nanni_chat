import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text("Username",
                          style: TextStyle(
                            color: AppColors.greySecond,
                          )),
                    ),
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: SimpleTextField(
                            margin: EdgeInsets.all(0),
                            backgroundColor: Color(0xFF4B5158).withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Wrap(
                  children: [
                    for(var i = 0; i < 20; i++)
                    Container(
                      width: (getDeviceWidth(context) - 104) / 4,
                      height: (getDeviceWidth(context) - 104) / 4,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 75, 74, 74), shape: BoxShape.circle),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              const SimpleButton(
                text: "Create",
                backgroundColor: AppColors.mint,
                textStyle: TextStyle(
                    color: AppColors.darkPrimary, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
