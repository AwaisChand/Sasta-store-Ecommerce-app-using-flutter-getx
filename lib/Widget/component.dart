import 'package:flutter/material.dart';
import 'package:sasta_store/Utils/text_style.dart';

class MyWidget {
  static roundButton(BuildContext context, String title, VoidCallback onTap,
      {double? height,
      double? width,
      Color? color,
      Color? containerColor,
      Widget? child}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: containerColor, borderRadius: BorderRadius.circular(50)),
        child: Center(
            child: Text(title, style: CustomTextStyles.l16_MEDIUM_black)),
      ),
    );
  }

  static container(
    double height,
    double width,
    Color color, {
    Widget? child,
    String? image,
    String? text,
    VoidCallback? onTap,
    Color? textColor,
    EdgeInsetsGeometry? margin,
    BoxShadow? boxShadow,
    BorderRadius? borderRadius,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        height: height,
        width: width,
        decoration: BoxDecoration(
            boxShadow: boxShadow != null ? [boxShadow] : null,
            color: color,
            image: DecorationImage(
                image: AssetImage(image ?? ''), fit: BoxFit.cover),
            borderRadius: borderRadius),
        child: child,
      ),
    );
  }
}
