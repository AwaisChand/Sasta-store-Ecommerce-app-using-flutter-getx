import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Helper/shared_pref.dart';

import '../Utils/color.dart';

class CONSTANTS {
  static const googleApiKey = 'AIzaSyANBqWI2CUP7_6o0Gqm1kPeDl1YzXvD6ZY';

  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static navigateToScreen(BuildContext context, screen) {
    Get.to(screen, duration: const Duration(seconds: 0));
  }

  static navigateToScreenNavigator(BuildContext context, screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen()));
  }

  static replaceScreenNavigator(BuildContext context, screen) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  static replaceScreen(BuildContext context, screen) {
    Get.off(screen, duration: const Duration(seconds: 0));
  }

  static void replaceAllScreen(BuildContext context, screen) {
    Get.offAll(screen, duration: const Duration(seconds: 0));
  }

  static void clearUserInfo() async {
    await SHAREDPREF.setLoggedInStatus(false);
  }

  static showBottomSheet(
      {required Widget widget, required BuildContext context}) {
    showModalBottomSheet<void>(
      backgroundColor: AppColors.lotionColor,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      useSafeArea: true,
      builder: (BuildContext context) {
        return widget;
      },
    );
  }
}
