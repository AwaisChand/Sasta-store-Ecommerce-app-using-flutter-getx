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

class SignUpController extends GetxController {
  var isLoading = false.obs;
  var isListNull = false.obs;
  var passwordVisibility = false.obs;
  var confirmpasswordVisibility = false.obs;

  TextEditingController emailTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmpasswordTextController = TextEditingController();
  TextEditingController referTextController = TextEditingController();

  var loginResponseModel = LoginModel().obs;

  signupApi({required BuildContext context}) async {
    isLoading(true);
    isListNull(false);
    Map<String, String> mapData = {};

    mapData['email'] = emailTextController.text;
    mapData['password'] = passwordTextController.text;
    mapData['phone'] = phoneTextController.text;
    mapData['name'] = nameTextController.text;
    mapData['password_confirmation'] = confirmpasswordTextController.text;
    mapData['referral_code'] = referTextController.text;

    var details = await APIService.postRequest(
        apiName: Urls.signupApi, isJson: false, mapData: mapData);

    if (details != null) {
      try {
        Map<String, dynamic> response = jsonDecode(details);

        if (response['status'] == 200) {
          loginResponseModel.value = loginModelFromMap(details);

          await SHAREDPREF.setToken(loginResponseModel.value.data?.token ?? '');

          await SHAREDPREF.setLoggedInStatus(true);

          CONSTANTS.replaceAllScreen(context, const HomeScreen());
        } else if (response['status'] == 422) {
          customSnackBarWidget(
              msg: 'email or phone number already taken!', context: context);
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
