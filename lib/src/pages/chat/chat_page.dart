import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nanni_chat/src/common/colors.dart';
import 'package:nanni_chat/src/global.dart';
import 'package:nanni_chat/src/pages/message/message_controller.dart';
import 'package:nanni_chat/src/pages/message/message_page.dart';
import 'package:nanni_chat/src/widgets/flex_tool_bar.dart';

import 'chat_controller.dart';

class ChatPage extends GetView<ChatController> {
  ChatPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlexToolBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 10),
                      decoration: ShapeDecoration(
                        color: AppColors.cyan,
                        shape: SmoothRectangleBorder(
                          borderRadius: SmoothBorderRadius(
                            cornerRadius: 10,
                            cornerSmoothing: 1,
                          ),
                        ),
                      ),
                      child: Text("YN")),
                  Text(Global.userInfo?.username ?? '')
                ],
              ),
              Icon(
                Iconsax.search_normal_1,
                color: Colors.white,
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: const Text(
            'Messages',
            style: TextStyle(
                color: AppColors.mint,
                fontSize: 24,
                fontWeight: FontWeight.w100),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Obx(() => Column(
                children: [
                  for (var i = 0; i < controller.chats.value; i++) ChatItem(),
                  for (var userOnlineIndex = 0;
                      userOnlineIndex < controller.userOnlines.length;
                      userOnlineIndex++)
                    InkWell(
                      onTap: () => controller.goToMessage(userOnlineIndex),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.blue,
                          margin: EdgeInsets.all(6),
                          child: Text(
                              "${controller.userOnlines[userOnlineIndex].user.username}")),
                    )
                ],
              )),
        ))
      ],
    );
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.lazyPut<MessageController>(() => MessageController());
        Get.to(() => const MessagePage());
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 48,
                width: 48,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 224, 157, 167),
                ),
              ),
              Expanded(
                child: Container(
                  height: 48,
                  // color: Colors.amber,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'hoainam',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            '04:00PM',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      Text(
                        "Last messages in here...",
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
