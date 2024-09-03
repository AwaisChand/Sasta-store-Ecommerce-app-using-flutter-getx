import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sasta_store/main.dart';

import '../Utils/color.dart';
import 'custom_toast.dart';

final FToast fToast = FToast();

showCustomToast({required String msg, required BuildContext context}) {
  fToast.init(context);
  fToast.showToast(
    child: CustomToast(
      msg: msg,
    ),
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 3),
  );
}

customSnackBarWidget({required String msg, BuildContext? context}) {
  var snack = SnackBar(
    content: Text(msg.inCaps.toString()),
    backgroundColor: AppColors.primaryColor,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(5),
  );
  ScaffoldMessenger.of(Get.context!)
    ..removeCurrentSnackBar()
    ..showSnackBar(snack);
}

customRawSnackBarWidget({required String msg, BuildContext? context}) {
  Get.closeAllSnackbars();
  Get.rawSnackbar(
    message: (msg.inCaps.toString()),
    backgroundColor: AppColors.primaryColor,
    duration: const Duration(milliseconds: 1500),
    margin: const EdgeInsets.all(5),
  );
}

errorSnackbar(String successMsg) {
  Get.closeAllSnackbars();
  return Get.snackbar(
    "error".tr,
    successMsg.inCaps.toString(),
    icon: const Icon(
      Icons.error_outline,
      color: Colors.white,
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    duration: const Duration(milliseconds: 1100),
    snackbarStatus: (status) {
      if (status == SnackbarStatus.CLOSED) {}
    },
  );
}

bottomSheetSnackBar({required String msg}) {
  Get.closeAllSnackbars();
  Get.rawSnackbar(
    // snackPosition: SnackPosition.TOP,
    duration: const Duration(milliseconds: 1500),
    backgroundColor: AppColors.primaryColor,

    message: msg,
  );
}

successSnackbar(String successMsg) {
  Get.closeAllSnackbars();

  return Get.snackbar(
    "notification".tr,
    successMsg.inCaps.toString(),
    icon: const Icon(
      Icons.check,
      color: Colors.white,
    ),
    duration: const Duration(milliseconds: 1100),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Get.theme.primaryColor,
    colorText: Colors.white,
    snackbarStatus: (status) {
      if (status == SnackbarStatus.CLOSED) {}
    },
  );
}

successSnackbarWithBack(String successMsg) {
  Get.closeAllSnackbars();

  return Get.snackbar(
    "notification".tr,
    successMsg.inCaps.toString(),
    icon: const Icon(
      Icons.check,
      color: Colors.white,
    ),
    duration: const Duration(milliseconds: 1100),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Get.theme.primaryColor,
    colorText: Colors.white,
    snackbarStatus: (status) {
      if (status == SnackbarStatus.CLOSED) {
        Navigator.pop(Get.context!);
      }
    },
  );
}

customSnack({required bool isSuccess, required String message}) {
  var snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      color: isSuccess ? AppColors.primaryColor : AppColors.redColor,
      title: isSuccess ? 'notification'.tr : 'error'.tr,
      message: message.tr.inCaps.toString(),

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: isSuccess ? ContentType.success : ContentType.failure,
    ),
  );

  ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
}
