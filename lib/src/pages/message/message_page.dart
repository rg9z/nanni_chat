import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nanni_chat/src/global.dart';
import 'package:nanni_chat/src/models/message.dart';
import 'package:nanni_chat/src/widgets/flex_tool_bar.dart';

import '../../common/colors.dart';
import '../../ultis/screen_device.dart';
import 'message_controller.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({Key? key}) : super(key: key);
  _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      // height: 70.0,
      // color: Colors.white,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(24)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            "assets/images/svgs/emoticon.svg",
                            height: 24,
                            color: Colors.white,
                          ),
                          iconSize: 24.0,
                          color: AppColors.cyan,
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            minLines: 1,
                            textCapitalization: TextCapitalization.sentences,
                            controller: controller.contentController,
                            onChanged: (String value) {},
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Send a message...',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 6),
                          child: IconButton(
                            icon: Transform.rotate(
                              angle: pi,
                              child: SvgPicture.asset(
                                "assets/images/svgs/send.svg",
                                height: 32,
                                color: AppColors.mint,
                              ),
                            ),
                            iconSize: 32.0,
                            onPressed: () => controller.onSendMessage(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 8,
            color: AppColors.darkPrimary,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          FlexToolBar(
            hasBack: true,
            lightMode: true,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(controller.messageUser.value?.username ?? '')),
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.amberAccent),
                )
              ],
            ),
          ),
          Expanded(
              child: Stack(
            children: [
              Container(
                margin:
                    EdgeInsets.only(bottom: 8 + getDeviceBottomHeight(context)),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Obx(() => ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      child: SingleChildScrollView(
                        controller: controller.scrollController,
                        child: Container(
                          child: Column(
                            children: [
                              if (controller.messageUser.value != null &&
                                  controller.messages.value.containsKey(
                                      controller.messageUser.value!.userId))
                                for (var messageIndex = 0;
                                    messageIndex <
                                        controller
                                            .messages
                                            .value[controller
                                                .messageUser.value?.userId]!
                                            .length;
                                    messageIndex++)
                                  _messageItem(messageIndex),
                              SizedBox(
                                height: kBottomNavigationBarHeight,
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildMessageComposer(),
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        height: getDeviceBottomHeight(context),
                      )
                    ],
                  )),
            ],
          )),
        ],
      ),
    ));
  }

  Widget _messageItem(int index) {
    var mType = MessageItemType.full;
    if (controller
            .messages.value[controller.messageUser.value?.userId]!.length >
        1) {
      var userMessages =
          controller.messages.value[controller.messageUser.value?.userId];

      var currentMessage = userMessages![index];

      if (index < userMessages.length - 1 && index > 0) {
        var previousMessage = userMessages[index - 1];
        var nextMessage = userMessages[index + 1];
        if (currentMessage.from != previousMessage.from &&
            (currentMessage.from != nextMessage.from ||
                index == userMessages.length)) {
          mType = MessageItemType.full;
        } else if (currentMessage.from != previousMessage.from &&
            currentMessage.from == nextMessage.from) {
          mType = MessageItemType.first;
        } else if (currentMessage.from == previousMessage.from &&
            (currentMessage.from != nextMessage.from ||
                index == userMessages.length)) {
          mType = MessageItemType.last;
        } else {
          mType = MessageItemType.mid;
        }
      } else {
        if (userMessages.length == 1 ||
            (index == userMessages.length - 1 &&
                    currentMessage.from != userMessages[index - 1].from ||
                (index == 0 &&
                    currentMessage.from != userMessages[index + 1].from))) {
          mType = MessageItemType.full;
        } else if (index == 0 &&
            currentMessage.from == userMessages[index + 1].from) {
          mType = MessageItemType.first;
        } else {
          mType = MessageItemType.last;
        }
      }
    }

    return MessageItem(
      isMe: controller.messages
              .value[controller.messageUser.value?.userId]![index].from ==
          Global.userInfo!.userId,
      content: controller.messages
          .value[controller.messageUser.value?.userId]![index].messageBody,
      type: mType,
    );
  }
}

enum MessageItemType { first, mid, last, full }

class MessageItem extends StatefulWidget {
  const MessageItem(
      {super.key,
      this.isMe = true,
      this.content = "this is content",
      this.at = '04:00PM',
      this.type = MessageItemType.full});
  final bool isMe;
  final String? content;
  final String? at;
  final MessageItemType type;

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  BorderRadius _meFirst() {
    return const BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
      bottomLeft: Radius.circular(24),
      bottomRight: Radius.circular(6),
    );
  }

  BorderRadius _meMid() {
    return const BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(6),
      bottomLeft: Radius.circular(24),
      bottomRight: Radius.circular(6),
    );
  }

  BorderRadius _meLast() {
    return const BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(6),
      bottomLeft: Radius.circular(24),
      bottomRight: Radius.circular(24),
    );
  }

  BorderRadius _userFirst() {
    return const BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
      bottomLeft: Radius.circular(6),
      bottomRight: Radius.circular(24),
    );
  }

  BorderRadius _userMid() {
    return const BorderRadius.only(
      topLeft: Radius.circular(6),
      topRight: Radius.circular(24),
      bottomLeft: Radius.circular(6),
      bottomRight: Radius.circular(24),
    );
  }

  BorderRadius _userLast() {
    return const BorderRadius.only(
      topLeft: Radius.circular(6),
      topRight: Radius.circular(24),
      bottomLeft: Radius.circular(24),
      bottomRight: Radius.circular(24),
    );
  }

  BorderRadius _radiusFull() {
    return const BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
      bottomLeft: Radius.circular(24),
      bottomRight: Radius.circular(24),
    );
  }

  BorderRadius _radius4() {
    return const BorderRadius.only(
      topLeft: Radius.circular(6),
      topRight: Radius.circular(24),
      bottomLeft: Radius.circular(6),
      bottomRight: Radius.circular(24),
    );
  }

  @override
  Widget build(BuildContext context) {
    var borderRadius = _radiusFull();
    if (widget.type != MessageItemType.full) {
      if (widget.isMe) {
        switch (widget.type) {
          case MessageItemType.first:
            borderRadius = _meFirst();
            break;
          case MessageItemType.mid:
            borderRadius = _meMid();
            break;
          case MessageItemType.last:
            borderRadius = _meLast();
            break;
          case MessageItemType.full:
            // TODO: Handle this case.
            break;
        }
      } else {
        switch (widget.type) {
          case MessageItemType.first:
            borderRadius = _userFirst();
            break;
          case MessageItemType.mid:
            borderRadius = _userMid();
            break;
          case MessageItemType.last:
            borderRadius = _userLast();
            break;
          case MessageItemType.full:
            // TODO: Handle this case.
            break;
        }
      }
    }
    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: 6),
      duration: Duration(milliseconds: 250),
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        children: [
          AnimatedContainer(
              duration: Duration(milliseconds: 50),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              constraints:
                  BoxConstraints(maxWidth: getDeviceWidth(context) * 0.7),
              decoration: BoxDecoration(
                color: widget.isMe ? AppColors.cyan : AppColors.darkSecond,
                borderRadius: borderRadius,
              ),
              child: Text("${widget.content}"))
        ],
      ),
    );
  }
}