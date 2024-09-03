// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../Helper/constants.dart';
import '../../Network/api_services.dart';
import '../../Screens/Authentication/ResetPasswordScreen/reset_password_screen.dart';
import '../../URLs.dart';
import '../../Widget/custom_snackbar.dart';

class VerifyOtpController extends GetxController {
  var isLoading = false.obs;
  var isListNull = false.obs;

  var otpController = ''.obs;

  otpVerifyApi({required BuildContext context, required String email}) async {
    isLoading(true);
    isListNull(false);
    Map<String, String> mapData = {};

    mapData['email'] = email;
    mapData['otp'] = otpController.value;
    mapData['type'] = 'forget';
    var details = await APIService.postRequest(
        apiName: Urls.otpVerifyApi, isJson: false, mapData: mapData);

    if (details != null) {
      try {
        Map<String, dynamic> response = jsonDecode(details);

        if (response['status'] == 200) {
          customSnackBarWidget(msg: response['message'], context: context);
          CONSTANTS.replaceScreen(context, ResetPasswordScreen(email: email));
        } else if (response['status'] == 500) {
          customSnackBarWidget(msg: response['message'], context: context);
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
