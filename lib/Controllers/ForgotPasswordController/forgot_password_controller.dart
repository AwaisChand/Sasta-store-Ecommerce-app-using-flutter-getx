// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../Helper/constants.dart';
import '../../Network/api_services.dart';
import '../../Screens/Authentication/VerifyOTP/verify_otp.dart';
import '../../URLs.dart';
import '../../Widget/custom_snackbar.dart';

class ForgotPasswordController extends GetxController {
  var isLoading = false.obs;
  var isListNull = false.obs;

  TextEditingController emailTextController = TextEditingController();

  forgotPassApi({required BuildContext context}) async {
    isLoading(true);
    isListNull(false);
    Map<String, String> mapData = {};

    mapData['email'] = emailTextController.text;
    var details = await APIService.postRequest(
        apiName: Urls.forgotApi, isJson: false, mapData: mapData);

    if (details != null) {
      try {
        Map<String, dynamic> response = jsonDecode(details);

        if (response['status'] == 200) {
          customSnackBarWidget(
              msg: 'Email is sent to you. Please check your email.',
              context: context);
          CONSTANTS.replaceScreen(
              context, VerifyOtpScreen(email: emailTextController.text));
        } else if (response['status'] == 422) {
          customSnackBarWidget(
              msg: 'Incorrect Email. Please try again!', context: context);
        }
        isLoading(false);
        isListNull(false);
      } catch (e) {
        if (kDebugMode) print(e);
        errorSnackbar('Something went wrong. Please try again.');
        isLoading(false);
        isListNull(true);
      }
    } else {
      isLoading(false);
      isListNull(true);
    }
  }
}
