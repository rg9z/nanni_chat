import 'package:flutter/material.dart';
import '../common/colors.dart';

class SimpleTextField extends StatefulWidget {
  final Function(String value)? onChanged;
  final Color backgroundColor;
  final String? hintText;
  final double borderRadius;
  final bool obscureText;
  final bool fitWidth;
  final Widget? icon;
  final EdgeInsets? margin;
  final double? horizontalMargin;
  final TextEditingController? controller;
  const SimpleTextField(
      {super.key,
      this.onChanged,
      this.backgroundColor = Colors.white,
      this.borderRadius = 16.0,
      this.fitWidth = true,
      this.icon,
      this.obscureText = false,
      this.margin,
      this.horizontalMargin,
      this.hintText,
      this.controller});

  @override
  State<SimpleTextField> createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {
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
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              margin: EdgeInsets.symmetric(
                  horizontal: (widget.horizontalMargin != null
                      ? widget.horizontalMargin as double
                      : 32),
                  vertical: 0),
              decoration: BoxDecoration(
                // gradient: AppColors.buttonGradient,
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: widget.icon != null
                        ? (widget.icon as Widget)
                        : Container(),
                    margin: EdgeInsets.only(
                      right: 12,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      controller: widget.controller,
                      maxLines: 1,
                      onChanged: widget.onChanged,
                      obscureText: widget.obscureText,
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        // prefixIcon: widget.icon,
                        isCollapsed: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
