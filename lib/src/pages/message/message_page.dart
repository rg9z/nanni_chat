import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nanni_chat/src/global.dart';
import 'package:nanni_chat/src/models/message.dart';
import 'package:nanni_chat/src/widgets/flex_tool_bar.dart';

import '../../common/colors.dart';
import '../../ultis/screen_device.dart';
import '../../widgets/card_item.dart';
import '../../widgets/patched_sliver_animated_list.dart';
import 'message_controller.dart';

class MessagePage extends GetView<MessageController> {
  MessagePage({Key? key}) : super(key: key);
  late List<Object> _oldData =
      List.from(controller.currentUserMessagesBox as Iterable);
  _buildMessageComposer(context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      height: 56,
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
                          onPressed: () {
                            controller.stickerToggle();
                          },
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            minLines: 1,
                            focusNode: controller.contentFocusNode,
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
                            icon: SvgPicture.asset(
                              "assets/images/svgs/send.svg",
                              height: 32,
                              color: AppColors.mint,
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
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                    Obx(() =>
                        Text(controller.messageUser.value?.username ?? '')),
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.amberAccent),
                      child: controller.messageUser.value!.avatar != null
                          ? Image.asset(
                              "assets/images/avatars/${controller.messageUser.value!.avatar}.png")
                          : Container(),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 8,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      //     child: SingleChildScrollView(
                      //       controller: controller.scrollController,
                      //       reverse: true,
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           if (controller.currentUserMessagesBox.value != null)
                      //             for (var messageIndex = 0;
                      //                 messageIndex <
                      //                     controller
                      //                         .messages
                      //                         .value[controller
                      //                             .messageUser.value?.userId]!
                      //                         .length;
                      //                 messageIndex++)
                      //               _messageItem(messageIndex),
                      //           const SizedBox(
                      //             height: 56,
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification.metrics.pixels <
                                  notification.metrics.maxScrollExtent &&
                              controller.hasLoadMore.isFalse &&
                              controller.showOver.isFalse) {
                            controller.loadMore();
                          }
                          return false;
                        },
                        child: CustomScrollView(
                          controller: controller.scrollController,
                          reverse: true,
                          slivers: [
                            SliverPadding(
                              padding: EdgeInsets.only(bottom: 56),
                              sliver: Obx(() => controller
                                      .listMessage.isNotEmpty
                                  ? SliverAnimatedList(
                                      initialItemCount:
                                          controller.listMessage.length ?? 0,
                                      key: controller.listKey,
                                      itemBuilder: _buildItem)
                                  : SliverAnimatedList(
                                      initialItemCount: 0,
                                      itemBuilder: _buildItem,
                                    )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildMessageComposer(context),
                        ],
                      )),
                ],
              )),
              Obx(() => AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    height: (controller.showSticker.isTrue
                        ? getDeviceBottomHeight(context) + 300
                        : getDeviceBottomHeight(context) + keyboardHeight),
                    color: AppColors.darkPrimary,
                  )),
            ],
          ),
        ));
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      index: index,
      item: controller.list[index],
      selected: true,
      onTap: () {
        // setState(() {
        //   _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        // });
      },
    );
  }

  Widget _messageItem(int index) {
    var mType = MessageItemType.full;
    var isReply = false;
    if (controller.currentUserMessagesBox!.value.length > 1) {
      var userMessages = controller.currentUserMessagesBox.value;

      var currentMessage = userMessages.get(index);

      if (index < userMessages.length - 1 && index > 0) {
        var previousMessage = userMessages.get(index - 1);
        var nextMessage = userMessages.get(index + 1);
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
                    currentMessage.from != userMessages.get(index - 1).from ||
                (index == 0 &&
                    currentMessage.from != userMessages.get(index + 1).from))) {
          mType = MessageItemType.full;
        } else if (index == 0 &&
            currentMessage.from == userMessages.get(index + 1).from) {
          mType = MessageItemType.first;
        } else {
          mType = MessageItemType.last;
        }
      }
    }
    Message current = controller.currentUserMessagesBox.value.get(index);
    return MessageItem(
      isMe: current.from == Global.userInfo!.userId,
      content: current.messageBody,
      type: mType,
      at: current.createdAt,
      isShowTime: index == controller.showtime.value,
      onTap: () => controller.showtime.value =
          controller.showtime.value != index ? index : null,
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
      this.type = MessageItemType.full,
      this.isShowTime = false,
      this.isNewReply = false,
      this.onTap});
  final bool isMe;
  final bool isNewReply;
  final bool isShowTime;
  final String? content;
  final String? at;
  final MessageItemType type;
  final Function()? onTap;

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  bool showTime = false;
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
    return Container(
      margin: EdgeInsets.only(
          bottom: 2,
          top: widget.type == MessageItemType.first ||
                  widget.type == MessageItemType.full
              ? 10
              : 0),
      // color: Colors.amber,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: double.infinity,
            curve: Curves.linear,
            // color: Colors.amber,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              vertical: 4,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: widget.isShowTime ? 1 : 0,
              child: Text(
                DateFormat('hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(int.parse(widget.at!))),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: EdgeInsets.only(
                top: widget.isShowTime ? 32 : 0, left: 6, right: 6),
            alignment:
                widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Column(
                children: [
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 50),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      constraints: BoxConstraints(
                          maxWidth: getDeviceWidth(context) * 0.7),
                      decoration: BoxDecoration(
                        color:
                            widget.isMe ? AppColors.blue : AppColors.darkSecond,
                        borderRadius: borderRadius,
                      ),
                      child: Text("${widget.content}")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
