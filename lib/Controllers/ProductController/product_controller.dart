import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Helper/shared_pref.dart';
import 'package:sasta_store/Models/ProductsFilterModel/products_filter_model.dart';

import '../../../URLS.dart';
import '../../Models/ProductModel/product_model.dart';
import '../../Network/api_services.dart';
import '../../Widget/custom_snackbar.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var isListNull = false.obs;

  var productModel = ProductModel().obs;
  var productsFilterModel = ProductsFilterModel().obs;

  // get products api

  getProductApi(bool fromHome, String id) async {
    isLoading(true);
    isListNull(false);

    Map<String, String>? headers = {
      'Authorization': 'Bearer ${SHAREDPREF.getToken()}'
    };

    var details = await APIService.getRequest(
        apiName: fromHome == true
            ? Urls.getHomeProductApi
            : Urls.getSubcategoryProductApi + id,
        headers: headers);

    if (details != null) {
      try {
        productModel.value = productModelFromMap(details);
        if (productModel.value.data!.data!.isNotEmpty) {
          isListNull(false);
          isLoading(false);
        } else {
          isLoading(false);
          isListNull(true);
        }
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

  // search products method

  getProductsSearchApi(String query) async {
    isListNull(false);
    isLoading(true);
    Map<String, String>? headers = {
      'Authorization': 'Bearer ${SHAREDPREF.getToken()}'
    };

    var details = await APIService.getRequest(
        apiName: '${Urls.getProductsFilterApi}?keyword=$query',
        headers: headers);

    debugPrint("fetch details: $details");

    if (details != null) {
      try {
        productModel.value = productModelFromMap(details);
        if (productModel.value.data!.data!.isNotEmpty) {
          isListNull(false);
          isLoading(false);
          debugPrint("filter data: $details");
        } else {
          isLoading(false);
          isListNull(true);
        }
      } catch (e) {
        if (kDebugMode) print(e);
        errorSnackbar('Something went wrong. Please try again. $e');
        isLoading(false);
        isListNull(true);
      }
    } else {
      isLoading(false);
      isListNull(true);
    }
  }
}
