// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Screens/Authentication/LoginScreen/login_screen.dart';

import '../../Helper/constants.dart';
import '../../Network/api_services.dart';
import '../../URLs.dart';
import '../../Widget/custom_snackbar.dart';

class ResetPasswordController extends GetxController {
  var isLoading = false.obs;
  var isListNull = false.obs;
  var passwordVisibility = false.obs;
  var confirmpasswordVisibility = false.obs;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  resetPassApi({required BuildContext context, required String email}) async {
    isLoading(true);
    isListNull(false);
    Map<String, String> mapData = {};

    mapData['password'] = passwordController.text;
    mapData['email'] = email;
    mapData['password_confirmation'] = confirmPasswordController.text;
    var details = await APIService.postRequest(
        apiName: Urls.resetPasswordApi, isJson: false, mapData: mapData);

    if (details != null) {
      try {
        Map<String, dynamic> response = jsonDecode(details);

        if (response['status'] == 200) {
          customSnackBarWidget(msg: response['message'], context: context);
          CONSTANTS.replaceScreen(context, const LoginScreen());
        } else if (response['status'] == 422) {
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
