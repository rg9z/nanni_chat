import 'package:flutter/material.dart';

class SimpleButton extends StatefulWidget {
  final Function()? onTap;
  final String text;
  final Color backgroundColor;
  final double borderRadius;
  final bool fitWidth;
  final EdgeInsets? margin;
  final TextStyle? textStyle;
  const SimpleButton(
      {super.key,
      this.onTap,
      this.text = '',
      this.backgroundColor = Colors.black,
      this.borderRadius = 16.0,
      this.fitWidth = true,
      this.textStyle,
      this.margin});

  @override
  State<SimpleButton> createState() => _SimpleButtonState();
}

class _SimpleButtonState extends State<SimpleButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: widget.fitWidth == true ? 1 : 0,
            child: Container(
              height: 48,
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
              decoration: BoxDecoration(
                // gradient: AppColors.buttonGradient,
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.onTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Text(
                          widget.text,
                          style: widget.textStyle,
                        ),
                      ),
                    ),
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
