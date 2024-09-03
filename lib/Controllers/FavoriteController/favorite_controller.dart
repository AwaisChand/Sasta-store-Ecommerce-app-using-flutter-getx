// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:sasta_store/Models/FavoriteModel/favorite_model.dart'
    as favModel;

import '../../Helper/shared_pref.dart';
import '../../Network/api_services.dart';
import '../../URLs.dart';
import '../../Widget/custom_snackbar.dart';

class FavoriteController extends GetxController {
  RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;
  RxBool _isListNull = false.obs;
  RxBool get isListNull => _isListNull;
  var favoriteModel = favModel.FavoriteModel().obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getFavoriteApi();
    });
  }

  Future getFavoriteApi() async {
    _isLoading(true);
    _isListNull(false);

    Map<String, String>? headers = {
      'Authorization': 'Bearer ${SHAREDPREF.getToken()}'
    };

    var details = await APIService.getRequest(
        apiName: Urls.getFavoriteApi, headers: headers);

    if (details != null) {
      try {
        favoriteModel.value = favModel.favoriteModelFromMap(details);
        if (favoriteModel.value.data!.isNotEmpty) {
          _isListNull(false);
          _isLoading(false);
          print("data is coming");
        } else {
          _isLoading(false);
          _isListNull(true);
          print("data is not coming");
        }
      } catch (e) {
        if (kDebugMode) print('e---${e.toString()}');
        errorSnackbar('Something went wrong. Please try again.');
        _isLoading(false);
        _isListNull(true);
        print("wrong");
      }
    } else {
      _isLoading(false);
      _isListNull(true);
    }
  }

  addFavoriteApi(
      {required BuildContext context, required String productId}) async {
    Map<String, String> mapData = {};
    Map<String, String>? headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SHAREDPREF.getToken()}'
    };

    mapData['product_id'] = productId;

    var details = await APIService.postRequest(
        apiName: Urls.addFavoriteApi,
        isJson: false,
        mapData: mapData,
        headers: headers);

    if (details != null) {
      try {
        Map<String, dynamic> response = jsonDecode(details);
        debugPrint(details);
        await getFavoriteApi();  // Refresh favorites list
      } catch (e) {
        if (kDebugMode) print(e);
        errorSnackbar('Something went wrong. Please try again.');
        _isLoading(false);
        _isListNull(false);
      }
    } else {
      _isLoading(false);
      _isListNull(false);
    }
  }

  removeFavoriteApi(
      {required BuildContext context, required String productId}) async {
    _isListNull(false);
    Map<String, String> mapData = {};
    Map<String, String>? headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SHAREDPREF.getToken()}'
    };
    mapData['product_id'] = productId;

    var details = await APIService.postRequest(
        apiName: Urls.removeFavoriteApi,
        isJson: false,
        mapData: mapData,
        headers: headers);

    if (details != null) {
      try {
        Map<String, dynamic> response = jsonDecode(details);

        debugPrint(details);
        await getFavoriteApi();  // Refresh favorites list
        _isLoading(false);
        _isListNull(false);
      } catch (e) {
        if (kDebugMode) print(e);
        errorSnackbar('Something went wrong. Please try again.');
        _isLoading(false);
        _isListNull(false);
      }
    } else {
      _isLoading(false);
      _isListNull(false);
    }
  }

  void removeFromFavorite(int index) {
    favoriteModel.value.data?[index].isFavourite = 0;
    removeFavoriteApi(
      context: Get.context!,
      productId: favoriteModel.value.data![index].id.toString(),
    );
  }

  void addToFavorite(int index) {
    favoriteModel.value.data?[index].isFavourite = 1;
    addFavoriteApi(
      context: Get.context!,
      productId: favoriteModel.value.data![index].id.toString(),
    );
  }
}
