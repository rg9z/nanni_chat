import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../common/colors.dart';
import '../../global.dart';
import '../../models/chat.dart';
import '../../widgets/flex_tool_bar.dart';

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
                      decoration: BoxDecoration(
                        color: AppColors.cyan,
                        shape: BoxShape.circle,
                      ),
                      child: Global.userInfo.avatar != null ? Image.asset(
                          "assets/images/avatars/${Global.userInfo.avatar}.png") : Container()),
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
                  for (Chat i in controller.chats.value.values)
                    ChatItem(
                      chat: i,
                      onTap: () => controller.goToMessage(i.user),
                    ),
                ],
              )),
        ))
      ],
    );
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.chat, this.onTap});
  final Chat chat;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    print("${chat.user}");
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
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
                child: chat.user.avatar != null ? Image.asset(
                    "assets/images/avatars/${chat.user.avatar}.png") : Container(),
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
                            "${chat.user.username}",
                            style: chat.isRead == true ?  Theme.of(context).textTheme.bodyMedium : TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          if(chat.updateAt != null)
                          Text(
                            DateFormat('hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(int.parse(chat.updateAt!))),
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              
                              "${chat.latestMessage.messageBody}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodySmall ,
                            ),
                          ),
                          if(chat.isRead == false)
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.blue
                            ),
                          )
                        ],
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
