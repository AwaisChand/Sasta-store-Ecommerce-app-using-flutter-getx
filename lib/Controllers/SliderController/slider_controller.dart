import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Helper/shared_pref.dart';

import '../../../URLS.dart';
import '../../Models/SliderModel/slider_model.dart';
import '../../Network/api_services.dart';
import '../../Widget/custom_snackbar.dart';

class SliderController extends GetxController {
  var isLoading = true.obs;
  var isListNull = false.obs;

  var sliderModel = SliderModel().obs;

  getSliderApi() async {
    isListNull(false);
    isLoading(true);
    Map<String, String>? headers = {
      'Authorization': 'Bearer ${SHAREDPREF.getToken()}'
    };

    var details = await APIService.getRequest(
        apiName: Urls.getSliderApi, headers: headers);

    if (details != null) {
      try {
        sliderModel.value = sliderModelFromMap(details);
        if (sliderModel.value.data!.isNotEmpty) {
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
}
