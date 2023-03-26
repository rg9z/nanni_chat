import 'package:flutter/material.dart';
import 'package:nanni_chat/src/models/message.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    this.onTap,
    this.selected = false,
    required this.animation,
    required this.item,
    required this.index,
  });

  final Animation<double> animation;
  final VoidCallback? onTap;
  final Message item;
  final bool selected;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 2.0,
        right: 2.0,
        top: 2.0,
      ),
      child: SizeTransition(
        sizeFactor: animation.drive(CurveTween(curve: Curves.easeOutQuad)),
        axisAlignment: -1,
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: 80.0,
            child: Card(
              color: Colors.black,
              child: Center(
                child: Text(
                  'Item ${item.messageBody}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
