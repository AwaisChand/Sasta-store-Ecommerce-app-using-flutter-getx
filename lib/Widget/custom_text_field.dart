// ignore_for_file: sized_box_for_whitespace, prefer_typing_uninitialized_variables, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Utils/color.dart';
import '../Utils/text_style.dart';

class CustomTextField extends StatefulWidget {
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hint;
  bool isPass;
  bool passwordvisibility;
  final TextEditingController? controller;
  final String? Function(String?) validation;
  final Future<String>? Function(String?)? onSubmitted;
  final Future<String>? Function(String?)? onChanged;
  final List<TextInputFormatter>? customInputFormatter;
  final int? maxLines;
  final Color? fillcolor;

  final int? maxLength;
  final bool? isReadOnly;
  final Function? onTap;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  var borderRadius;
  bool? isNoBorder;
  Color? fillColor;
  TextStyle? hintStyle;
  TextStyle? textStyle;
  bool? isTextArea;
  int? maxxlines;

  CustomTextField(
      {Key? key,
      this.prefixIcon,
      this.textInputAction,
      this.hint,
      this.fillColor,
      this.hintStyle,
      this.textStyle,
      this.controller,
      this.focusNode,
      this.maxxlines,
      required this.validation,
      required this.isPass,
      required this.passwordvisibility,
      this.customInputFormatter,
      this.suffixIcon,
      required this.maxLines,
      this.onSubmitted,
      this.isReadOnly,
      this.onTap,
      this.onChanged,
      this.maxLength,
      this.borderRadius,
      this.isNoBorder,
      this.textInputType,
      this.isTextArea,
      this.fillcolor})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode focusNode = FocusNode();

  get validation => widget.validation;

  get ontap => widget.onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        keyboardType: widget.textInputType ?? TextInputType.text,
        maxLength: widget.maxLength,
        readOnly: widget.isReadOnly ?? false,
        onTap: ontap ?? () {},
        onChanged: widget.onChanged ?? (text) {},
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onSubmitted ?? (text) {},
        inputFormatters: widget.customInputFormatter ?? [],
        minLines: widget.isTextArea == true ? null : 1,
        maxLines: widget.maxLines,
        validator: validation,
        focusNode: widget.focusNode,
        controller: widget.controller,
        obscureText: widget.isPass ? !widget.passwordvisibility : false,
        style: widget.textStyle ?? CustomTextStyles.l16_SemiBold_PrimaryColor,
        cursorColor: AppColors.pureBlack,
        decoration: InputDecoration(
            suffixIcon: widget.suffixIcon ??
                (widget.isPass
                    ? IconButton(
                        icon: Icon(
                          widget.passwordvisibility
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.greylight,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.passwordvisibility =
                                !widget.passwordvisibility;
                          });
                        },
                      )
                    : null),
            prefixIcon: widget.prefixIcon,
            counterText: '',
            filled: true,
            fillColor:
                widget.fillColor ?? AppColors.lotionColor.withOpacity(0.4),
            enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 80.0),
                borderSide: BorderSide(
                    color: widget.isNoBorder == true
                        ? Colors.transparent
                        : AppColors.nickelColor.withOpacity(0.5))),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 80.0),
              borderSide: BorderSide(
                  width: 1,
                  color: widget.isNoBorder == true
                      ? Colors.transparent
                      : AppColors.nickelColor.withOpacity(0.5)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 80.0),
              borderSide: BorderSide(
                  width: 1,
                  color: widget.isNoBorder == true
                      ? Colors.transparent
                      : Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1,
                  color: widget.isNoBorder == true
                      ? Colors.transparent
                      : Colors.redAccent),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 80.0),
            ),
            hintText: widget.hint ?? ''.tr,
            hintStyle: widget.hintStyle ?? CustomTextStyles.l16_MEDIUM_textgrey,
            contentPadding: EdgeInsets.only(
                left: 17,
                right: 17,
                top: MediaQuery.of(context).size.height * 0.020,
                bottom: MediaQuery.of(context).size.height * 0.020)),
      ),
    );
  }
}
