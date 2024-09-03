import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customProgressIndicator() {
  return Center(
    child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation<Color>(Get.theme.primaryColor)),
  );
}
