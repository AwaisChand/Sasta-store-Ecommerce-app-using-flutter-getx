import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Helper/shared_pref.dart';
import 'package:sasta_store/Models/BalanceHistoryModel/balance_history_model.dart';
import 'package:sasta_store/Network/api_services.dart';
import 'package:sasta_store/URLS.dart';
import 'package:sasta_store/Widget/custom_snackbar.dart';

class BalanceHistoryController extends GetxController{

  var isLoading = true.obs;
  var isListNull = false.obs;

  var balanceHistoryModel = BalanceHistoryModel().obs;

  getBalanceHistory() async {
    isListNull(false);
    isLoading(true);
    Map<String, String>? headers = {
      'Authorization': 'Bearer ${SHAREDPREF.getToken()}'
    };

    var details =
    await APIService.getRequest(apiName: Urls.balanceHistoryApi, headers: headers);

    debugPrint("fetch details: $details");

    if (details != null) {
      try {
        balanceHistoryModel.value = balanceHistoryModelFromJson(details);
        if (balanceHistoryModel.value.data!.isNotEmpty) {
          isListNull(false);
          isLoading(false);
          debugPrint("chat data: get $details");
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
      balanceHistoryModel.value = BalanceHistoryModel();
      isLoading(false);
      isListNull(true);
    }
  }

}