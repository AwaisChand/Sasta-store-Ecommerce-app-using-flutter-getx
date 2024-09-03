// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'package:flutter/material.dart';

import '../Utils/color.dart';
import '../Utils/text_style.dart';

class CustomButton extends StatefulWidget {
  final String text;
  Function? onPressed;
  TextStyle? textStyle;
  Color? backgroundColor;
  var width;
  var height;
  var radius;

  CustomButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.textStyle,
      this.backgroundColor,
      this.width,
      this.height,
      this.radius})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      width: widget.width ?? width,
      height: widget.height ?? height * 0.06,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor:
                  widget.backgroundColor ?? AppColors.secondryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 80.0),
              )),
          onPressed: () {
            widget.onPressed!();
          },
          child: Text(widget.text,
              style: widget.textStyle ?? CustomTextStyles.l18_SEMI_BOLD_WHITE)),
    );
  }
}
