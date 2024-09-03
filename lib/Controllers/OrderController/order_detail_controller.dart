// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Models/Order/order_detail_model.dart';

import '../../Helper/shared_pref.dart';
import '../../Network/api_services.dart';
import '../../URLs.dart';
import '../../Widget/custom_snackbar.dart';

class OrderDetailController extends GetxController {
  var isLoading = false.obs;
  var isListNull = false.obs;
  var orderDetailModel = OrderDetailModel().obs;

  getOrderDetailApi(String id) async {
    isLoading(true);
    isListNull(false);

    Map<String, String>? headers = {
      'Authorization': 'Bearer ${SHAREDPREF.getToken()}'
    };

    var details = await APIService.getRequest(
        apiName: Urls.getOrderDetailApi + id, headers: headers);

    if (details != null) {
      try {
        orderDetailModel.value = orderDetailModelFromMap(details);
        if (orderDetailModel.value.data != null) {
          isListNull(false);
          isLoading(false);
        } else {
          isLoading(false);
          isListNull(true);
        }
      } catch (e) {
        if (kDebugMode) print('e---${e.toString()}');
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
