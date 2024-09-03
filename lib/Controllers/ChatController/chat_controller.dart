import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Helper/shared_pref.dart';
import 'package:sasta_store/Models/ChatModel/get_all_message_model.dart';
import 'package:sasta_store/Models/ChatModel/send_message_model.dart';
import 'package:sasta_store/Network/api_services.dart';
import 'package:sasta_store/URLS.dart';
import 'package:sasta_store/Widget/custom_snackbar.dart';

class ChatController extends GetxController {
  var isLoading = true.obs;
  var isListNull = false.obs;

  var getAllMessageModel = GetAllMessageModel().obs;
  var sendMessageModel = SendMessageModel().obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getChatApi();
    });
  }

  getChatApi() async {
    isListNull(false);
    isLoading(true);
    Map<String, String>? headers = {
      'Authorization': 'Bearer ${SHAREDPREF.getToken()}'
    };

    var details =
        await APIService.getRequest(apiName: Urls.getChatApi, headers: headers);
    debugPrint("fetch details: $details");

    if (details != null) {
      try {
        getAllMessageModel.value = getAllMessageModelFromJson(details);
        if (getAllMessageModel.value.data!.isNotEmpty) {
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
      getAllMessageModel.value = GetAllMessageModel();
      isLoading(false);
      isListNull(true);
    }
  }

  sendMessageApi(String message) async {
    isListNull(false);
    isLoading(true);
    Map<String, String>? headers = {
      'Authorization': 'Bearer ${SHAREDPREF.getToken()}',
      'Accept': 'application/json'
    };
    Map<String, String> mapData = {};

    mapData['message'] = message;

    var details = await APIService.postRequest(
        apiName: Urls.sendMessageApi,
        headers: headers,
        mapData: mapData,
        isJson: false);

    debugPrint("send msg details: $details");
    debugPrint("body message: $mapData");

    if (details != null) {
      try {
        sendMessageModel.value = sendMessageModelFromJson(details);
        if (sendMessageModel.value.message == "Message sent successfully") {
          await getChatApi();
          customSnackBarWidget(msg: "${sendMessageModel.value.message}");
          debugPrint("Api works perfectly");
        } else {
          errorSnackbar(sendMessageModel.value.message ?? 'Unknown error');
        }
      } catch (e) {
        if (kDebugMode) print(e);
        errorSnackbar('Something went wrong. Please try again. $e');
      }
    } else {
      errorSnackbar('Failed to send message');
    }

    isLoading(false);
  }
}
