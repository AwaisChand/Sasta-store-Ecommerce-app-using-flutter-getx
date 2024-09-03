import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Helper/shared_pref.dart';
import 'package:sasta_store/Models/CategoryModel/category_model.dart';

import '../../../URLS.dart';
import '../../Network/api_services.dart';
import '../../Widget/custom_snackbar.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var isListNull = false.obs;

  var categoryModel = CategoryModel().obs;

  getCategoryApi() async {
    isListNull(false);
    Map<String, String>? headers = {
      'Authorization': 'Bearer ${SHAREDPREF.getToken()}'
    };

    var details = await APIService.getRequest(
        apiName: Urls.getCategoriesApi, headers: headers);

    if (details != null) {
      try {
        Map<String, dynamic> response = jsonDecode(details);
        if (response['status'] == 200) {
          categoryModel.value = categoryModelFromMap(details);
          if (categoryModel.value.data != null) {
            isListNull(false);
          } else {
            isListNull(true);
          }
        } else {
          customSnackBarWidget(msg: response['message'].toString());
        }
        isLoading(false);
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
