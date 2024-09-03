// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Screens/HomeScreen/home_screen.dart';

import '../../Helper/constants.dart';
import '../../Helper/shared_pref.dart';
import '../../Models/LoginModel/login_model.dart';
import '../../Network/api_services.dart';
import '../../URLs.dart';
import '../../Widget/custom_snackbar.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var isListNull = false.obs;
  var passwordVisibility = false.obs;
  var confirmpasswordVisibility = false.obs;

  TextEditingController emailTextController =
      TextEditingController(text: 'developerwaqas386@gmail.com');
  TextEditingController passwordTextController =
      TextEditingController(text: '12345678');

  var loginResponseModel = LoginModel().obs;

  loginApi({required BuildContext context}) async {
    isLoading(true);
    isListNull(false);
    Map<String, String> mapData = {};

    mapData['email'] = emailTextController.text;
    mapData['password'] = passwordTextController.text;

    var details = await APIService.postRequest(
        apiName: Urls.loginApi, isJson: false, mapData: mapData);

    if (details != null) {
      try {
        Map<String, dynamic> response = jsonDecode(details);

        if (response['status'] == 200) {
          loginResponseModel.value = loginModelFromMap(details);
          await SHAREDPREF
              .setUserId(loginResponseModel.value.data?.id.toString() ?? '');
          await SHAREDPREF.setToken(loginResponseModel.value.data?.token ?? '');

          await SHAREDPREF.setLoggedInStatus(true);

          CONSTANTS.replaceAllScreen(context, const HomeScreen());
        } else if (response['status'] == 500) {
          customSnackBarWidget(
              msg: 'Incorrect Email or Password. Please try again!',
              context: context);
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
