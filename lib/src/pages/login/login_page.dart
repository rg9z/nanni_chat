import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nanni_chat/src/ultis/screen_device.dart';

import '../../common/colors.dart';
import '../../widgets/flex_tool_bar.dart';
import '../../widgets/simple_button.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/svgs/nani_logo.svg",
                  width: getDeviceWidth(context) * 0.1,
                ),
                SizedBox(
                  height: 56,
                ),
                Text(
                  "App messages app\nfor Nam's",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.greySecond,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                SizedBox(
                  height: 48,
                ),
                Text(
                  "Choose a option to login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.greySecond,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                _loginForm(),
              ],
            ),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(
                          color: AppColors.greySecond.withOpacity(0.5),
                          fontSize: 12,
                        ),
                        children: const [
                          TextSpan(
                              text:
                                  "By clicking options login button,\nyou agree to our "),
                          TextSpan(
                              text: "Privacy",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: " and "),
                          TextSpan(
                              text: "Terms of Use",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ])),
              ),
              SizedBox(
                height: getDeviceBottomHeight(context) + 16,
              )
            ],
          )
        ],
      ),
    ));
  }

  // login form
  Widget _loginForm() {
    return Container(
      child: Column(
        children: [
          SimpleButton(
            margin: EdgeInsets.only(top: 0),
            text: 'Sign with Google',
            backgroundColor: AppColors.darkSecond,
            borderRadius: 24,
            onTap: () {
              // Get.offNamed(AppRoutes.Intro);
              // Get.offAll(() => HomePage());
              controller.handleSignIn();
            },
          ),
          SimpleButton(
            margin: EdgeInsets.only(top: 16),
            text: 'Sign with Apple',
            backgroundColor: AppColors.darkSecond,
            borderRadius: 24,
            onTap: () {
              // Get.offNamed(AppRoutes.Intro);
              // Get.offAll(() => HomePage());
              controller.handleSignIn();
            },
          ),
        ],
      ),
    );
  }
}
