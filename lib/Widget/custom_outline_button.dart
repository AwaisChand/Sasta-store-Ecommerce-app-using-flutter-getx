// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'package:flutter/material.dart';

import '../Utils/color.dart';
import '../Utils/text_style.dart';

class CustomOutlineButton extends StatefulWidget {
  final String text;
  Function? onPressed;
  TextStyle? textStyle;
  Color? borderColor;
  var width;
  var height;
  var radius;

  CustomOutlineButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.textStyle,
      this.borderColor,
      this.width,
      this.height,
      this.radius})
      : super(key: key);

  @override
  State<CustomOutlineButton> createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      width: widget.width ?? width,
      height: widget.height ?? height * 0.06,
      child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(widget.radius ?? 30.0))
                  .copyWith(
                      side: BorderSide(
                color: widget.borderColor ?? AppColors.primaryColor,
              )),
            ),
          ),
          onPressed: () {
            widget.onPressed!();
          },
          child: Text(widget.text,
              style:
                  widget.textStyle ?? CustomTextStyles.l18_SEMI_BOLD_MIDBLACK)),
    );
  }
}
