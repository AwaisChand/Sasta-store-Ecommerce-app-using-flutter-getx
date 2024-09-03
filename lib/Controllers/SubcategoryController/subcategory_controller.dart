import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Helper/shared_pref.dart';

import '../../../URLS.dart';
import '../../Models/SubcategoryModel/subcategory_model.dart';
import '../../Network/api_services.dart';
import '../../Widget/custom_snackbar.dart';

class SubcategoryController extends GetxController {
  var isLoading = true.obs;
  var isListNull = false.obs;
  var subcategoryModel = SubcategoryModel().obs;

  getSubcategoryApi(String id) async {
    isListNull(false);
    isLoading(true);

    try {
      Map<String, String>? headers = {
        'Authorization': 'Bearer ${SHAREDPREF.getToken()}'
      };

      var details = await APIService.getRequest(
          apiName: Urls.getSubcategoriesApi + id, headers: headers);

      if (details != null) {
        subcategoryModel.value = subcategoryModelFromMap(details);
        isListNull(subcategoryModel.value.data!.isEmpty);
      } else {
        isListNull(true);
      }
    } catch (e) {
      if (kDebugMode) print(e);
      errorSnackbar('Something went wrong. Please try again.');
      isListNull(true);
    } finally {
      isLoading(false);
    }
  }
}
