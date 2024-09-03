import 'package:flutter/material.dart';

import '../Utils/color.dart';

class CustomLoader extends StatelessWidget {
  Color? color;

  CustomLoader({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColors.primaryColor,
      ),
    );
  }
}
