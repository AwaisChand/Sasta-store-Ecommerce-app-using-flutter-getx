import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:sasta_store/Helper/shared_pref.dart';
import 'package:sasta_store/Screens/Order/order_history.dart';
import 'package:sasta_store/URLs.dart';
import 'package:sasta_store/Widget/custom_snackbar.dart';

class PaymentDetailController extends GetxController{
  var isListNull = false.obs;
  var isLoading = true.obs;
  XFile? pickedFile;
  File? profileImage;
  var isFromPath = false.obs;
  final picker = ImagePicker();


  pickImage() async {
    try {
      pickedFile =
      await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
      profileImage = File(pickedFile!.path);
      isFromPath(true);
      isFromPath.refresh();
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }
  Future uploadReceipt({
    required BuildContext context,
    required String image,
    required String transaction,
    required String orderId,
  }) async {
    isLoading(true);
    isListNull(false);
    try {
      var postUri =
      Uri.parse("${Urls.BASE_URL}${Urls.uploadReceiptApi}/$orderId");
      var request = http.MultipartRequest("POST", postUri);

      debugPrint("url: $postUri");
      // debugPrint("order id get: $orderId");

      if (image.isNotEmpty) {
        var profileImage = File(image);
        var multipartFile = await http.MultipartFile.fromPath(
          'payment_receipt',
          profileImage.path,
        );
        request.files.add(multipartFile);
      }

      request.fields['transaction_no'] = transaction;

      var token = SHAREDPREF.getToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['status'] == 200) {
          customSnack(isSuccess: true, message: result['message']);
          Get.to(()=> const OrderHistoryScreen());
        } else if (result['status'] == 422) {
          customSnackBarWidget(msg: result['message'].toString());
        } else {
          customSnackBarWidget(msg: result['message'].toString());
        }
      } else {
        customSnackBarWidget(msg: 'Failed to upload receipt');
      }
    } catch (e) {
      if (kDebugMode) print(e);
      errorSnackbar('Something went wrong. Please try again.');
    } finally {
      isLoading(false);
      isListNull(false);
    }
  }
}