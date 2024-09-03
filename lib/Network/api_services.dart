import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../URLs.dart';
import '../Widget/custom_snackbar.dart';

class APIService {
  static var client = http.Client();

  static Future<String?> postRequest(
      {required String apiName,
      required bool isJson,
      var body,
      Map<String, dynamic>? mapData,
      Map<String, String>? headers,
      bool? isAuth}) async {
    /// check_internet
    bool result = await InternetConnectionChecker().hasConnection;
    // var connectivityResult = await (Connectivity().checkConnectivity());
    if (!result) {
      customSnack(
          isSuccess: false,
          message: "No internet connection, Please connect to internet.".tr);
      return null;
    }
    headers ??= {};
    // print('bbody---$body');
    // print('mapdata---${mapData}');
    // try {
    /// post Request
    var response = await client
        .post(Uri.parse(Urls.BASE_URL + apiName),
            body: isJson == true ? json.encode(mapData) : mapData,
            headers: headers)
        .timeout(const Duration(seconds: 30));

    /// print response
    if (kDebugMode) {
      debugPrint(
          "headers:$headers: body:$mapData:api:${Urls.BASE_URL + apiName} :response:${response.body}",
          wrapWidth: 1024);
    }
    var statusCode = response.statusCode;
    if (kDebugMode) {
      print('statusCode:$statusCode');
    }

    /// check response
    switch (statusCode) {
      case HttpStatus.ok:
        var jsonString = response.body;
        return jsonString;

      case HttpStatus.unauthorized:
        var jsonString = response.body;

        return jsonString;
      case HttpStatus.created:
        var jsonString = response.body;
        return jsonString;

      case HttpStatus.notFound:
        var jsonString = response.body;

        return jsonString;

      case HttpStatus.found:
        var jsonString = response.body;

        return jsonString;

      case HttpStatus.badRequest:
        var jsonString = response.body;

        return jsonString;

      case HttpStatus.gatewayTimeout:
        customSnack(
            isSuccess: false,
            message: "No response from the server, Please try again".tr);
        return null;

      default:
        customSnack(
            isSuccess: false,
            message: "No response from the server, Please try again".tr);
        return null;
    }
    // } catch (e) {
    //   if (kDebugMode) print("api error:$e");
    //   customSnack(
    //       isSuccess: false,
    //       message: "No response from the server, Please try again".tr);
    //
    //   return null;
    // }
  }

  static Future<String?> postRequestWithNoBaseUrl(
      {required String apiName,
      required bool isJson,
      required Map<String, dynamic> mapData,
      Map<String, String>? headers,
      bool? isAuth}) async {
    /// check_internet
    bool result = await InternetConnectionChecker().hasConnection;
    // var connectivityResult = await (Connectivity().checkConnectivity());
    if (!result) {
      customSnack(
          isSuccess: false,
          message: "No internet connection, Please connect to internet.".tr);
      return null;
    }
    headers ??= {};
    // try {
    /// post Request
    var response = await client
        .post(Uri.parse(apiName),
            body: isJson ? json.encode(mapData) : mapData, headers: headers)
        .timeout(const Duration(seconds: 30));

    /// print response
    if (kDebugMode) {
      debugPrint(
          "headers:$headers: body:$mapData:api:${Urls.BASE_URL + apiName} :response:${response.body}",
          wrapWidth: 1024);
    }
    var statusCode = response.statusCode;
    if (kDebugMode) {
      print('statusCode:$statusCode');
    }

    /// check response
    switch (statusCode) {
      case HttpStatus.ok:
        var jsonString = response.body;
        return jsonString;

      case HttpStatus.unauthorized:
        var jsonString = response.body;

        return jsonString;
      case HttpStatus.created:
        var jsonString = response.body;
        return jsonString;

      case HttpStatus.notFound:
        var jsonString = response.body;

        return jsonString;

      case HttpStatus.found:
        var jsonString = response.body;

        return jsonString;

      case HttpStatus.badRequest:
        var jsonString = response.body;

        return jsonString;

      case HttpStatus.gatewayTimeout:
        customSnack(
            isSuccess: false,
            message: "No response from the server, Please try again".tr);
        return null;

      default:
        customSnack(
            isSuccess: false,
            message: "No response from the server, Please try again".tr);
        return null;
    }
    // } catch (e) {
    //   if (kDebugMode) print("api error:$e");
    //   customSnack(
    //       isSuccess: false,
    //       message: "No response from the server, Please try again".tr);
    //
    //   return null;
    // }
  }

  static Future<String?> patchRequest(
      {required String apiName,
      required bool isJson,
      required Map<String, dynamic> mapData,
      Map<String, String>? headers,
      bool? isAuth}) async {
    /// check_internet
    bool result = await InternetConnectionChecker().hasConnection;
    // var connectivityResult = await (Connectivity().checkConnectivity());
    if (!result) {
      customSnack(
          isSuccess: false,
          message: "No internet connection, Please connect to internet.".tr);
      return null;
    }
    headers ??= {};
    try {
      /// post Request
      var response = await client
          .patch(Uri.parse(Urls.BASE_URL + apiName),
              body: isJson ? json.encode(mapData) : mapData, headers: headers)
          .timeout(const Duration(seconds: 30));

      /// print response
      if (kDebugMode) {
        debugPrint(
            "headers:$headers: body:$mapData:api:${Urls.BASE_URL + apiName} :response:${response.body}",
            wrapWidth: 1024);
      }
      var statusCode = response.statusCode;
      if (kDebugMode) {}

      /// check response
      switch (statusCode) {
        case HttpStatus.ok:
        case HttpStatus.unauthorized:
          var jsonString = response.body;

          return jsonString;

        case HttpStatus.notFound:
          var jsonString = response.body;

          return jsonString;

        case HttpStatus.found:
          var jsonString = response.body;
          return jsonString;

        case HttpStatus.badRequest:
          var jsonString = response.body;

          return jsonString;

        case HttpStatus.gatewayTimeout:
          customSnack(
              isSuccess: false,
              message: "No response from the server, Please try again".tr);

          return null;

        default:
          customSnack(
              isSuccess: false,
              message: "No response from the server, Please try again".tr);
          return null;
      }
    } catch (e) {
      if (kDebugMode) print("api error:$e");
      customSnack(
          isSuccess: false,
          message: "No response from the server, Please try again".tr);
      return null;
    }
  }

  static Future<String?> getRequest(
      {required String apiName,
      Map<String, String>? headers,
      bool? isAuth}) async {
    try {
      /// check_internet
      bool result = await InternetConnectionChecker().hasConnection;
      if (!result) {
        customSnack(
            isSuccess: false,
            message: "No internet connection, Please connect to internet.".tr);
        return null;
      }

      headers ??= {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      };

      /// get request
      var response = await http
          .get(Uri.parse(Urls.BASE_URL + apiName), headers: headers)
          .timeout(const Duration(seconds: 30));

      print("Api Url: ${Urls.BASE_URL + apiName}");

      /// print response
      if (kDebugMode) {
        debugPrint(
            "header:$headers:api:${Urls.BASE_URL + apiName}:response:${response.body}",
            wrapWidth: 1024);
      }
      var statusCode = response.statusCode;

      /// check response
      switch (statusCode) {
        case HttpStatus.ok:
          var jsonString = response.body;
          return jsonString;

        case HttpStatus.gatewayTimeout:
          customSnack(
              isSuccess: false,
              message: "No response from the server, Please try again".tr);
          return null;

        case HttpStatus.notFound:
          var jsonString = response.body;
          if (kDebugMode) debugPrint(jsonString, wrapWidth: 1024);
          return jsonString;

        case HttpStatus.unauthorized:
          var jsonString = response.body;
          if (kDebugMode) debugPrint(jsonString, wrapWidth: 1024);
          return jsonString;

        default:
          customSnack(
              isSuccess: false,
              message: "No response from the server, Please try again".tr);
          return null;
      }
    } catch (e) {
      if (kDebugMode)
        print('No response from the server, Please try again: $e');
      customSnack(
          isSuccess: false,
          message: "No response from the server, Please try again".tr);
      return null;
    }
  }

  static Future<bool> getImageRequest({required String imageUrl}) async {
    try {
      /// check_internet
      bool result = await InternetConnectionChecker().hasConnection;
      // var connectivityResult = await (Connectivity().checkConnectivity());
      if (!result) {
        customSnack(
            isSuccess: false,
            message: "No internet connection, Please connect to internet.".tr);
        return false;
      }

      /// get request
      var response = await client
          .get(Uri.parse(Urls.BASE_URL + imageUrl))
          .timeout(const Duration(seconds: 30));

      /// print response
      if (kDebugMode) {
        debugPrint(
            "api:${Urls.BASE_URL + imageUrl}:status code:${response.statusCode}",
            wrapWidth: 1024);
      }
      var statusCode = response.statusCode;

      /// check response
      switch (statusCode) {
        case HttpStatus.ok:
          return true;

        case HttpStatus.gatewayTimeout:
          return false;

        default:
          return false;
      }
    } catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }

  static Future<String?> uploadFiles(http.MultipartRequest request) async {
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      // var connectivityResult = await (Connectivity().checkConnectivity());
      if (!result) {
        customSnack(
            isSuccess: false,
            message: "No internet connection, Please connect to internet.".tr);
        return null;
      }
      http.Response response =
          await http.Response.fromStream(await request.send());
      if (kDebugMode) print("response:${response.statusCode}:");
      if (kDebugMode) print(response.body);
      var statusCode = response.statusCode;
      switch (statusCode) {
        case HttpStatus.ok:
          var jsonString = response.body;
          // (debugMode) debugPrint(jsonString, wrapWidth: 1024);
          return jsonString;

        case HttpStatus.gatewayTimeout:
          customSnack(
              isSuccess: false,
              message: "No response from the server, Please try again".tr);
          return null;

        default:
          customSnack(
              isSuccess: false,
              message: "No response from the server, Please try again".tr);
          return null;
      }
    } catch (e) {
      if (kDebugMode) print("error:$e}");
      customSnack(
          isSuccess: false,
          message: "No response from the server, Please try again".tr);
      return null;
    }
  }

  static Future<String?> getRequestWithNoBaseUrl(
      {required String apiName, required Map<String, String> headers}) async {
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      // var connectivityResult = await (Connectivity().checkConnectivity());
      if (!result) {
        customSnack(
            isSuccess: false,
            message: "No internet connection, Please connect to internet.".tr);
        return null;
      }
      if (kDebugMode) print("response:$apiName");
      var response = await client
          .get(Uri.parse(apiName), headers: headers)
          .timeout(const Duration(seconds: 30));

      var statusCode = response.statusCode;
      switch (statusCode) {
        case HttpStatus.ok:
          var jsonString = response.body;
          if (kDebugMode)
            debugPrint(":$apiName:response$jsonString", wrapWidth: 1024);
          return jsonString;

        case HttpStatus.gatewayTimeout:
          customSnack(
              isSuccess: false,
              message: "No response from the server, Please try again".tr);

          return null;

        default:
          customSnack(
              isSuccess: false,
              message: "No response from the server, Please try again".tr);
          return null;
      }
    } catch (e) {
      if (kDebugMode) print(e);
      customSnack(
          isSuccess: false,
          message: "No response from the server, Please try again".tr);
      return null;
    }
  }

  static Future<String?> PostRequestWithNoBaseUrl(
      {required String apiName,
      required Map<String, dynamic> mapData,
      Map<String, String>? headers}) async {
    /// check_internet
    bool result = await InternetConnectionChecker().hasConnection;
    // var connectivityResult = await (Connectivity().checkConnectivity());
    if (!result) {
      customSnack(
          isSuccess: false,
          message: "No internet connection, Please connect to internet.".tr);
      return null;
    }

    try {
      /// post Request
      var response = await client
          .post(Uri.parse(apiName),
              body: json.encode(mapData), headers: headers)
          .timeout(const Duration(seconds: 30));

      /// print response

      debugPrint(
          "headers:$headers: body:${json.encode(mapData)}:api:${Urls.BASE_URL + apiName} :response:${response.body}",
          wrapWidth: 1024);

      var statusCode = response.statusCode;

      /// check response
      switch (statusCode) {
        case HttpStatus.ok:
          var jsonString = response.body;
          return jsonString;

        case HttpStatus.gatewayTimeout:
          customSnack(
              isSuccess: false,
              message: "No response from the server, Please try again".tr);
          return null;

        default:
          customSnack(
              isSuccess: false,
              message: "No response from the server, Please try again".tr);
          return null;
      }
    } catch (e) {
      if (kDebugMode) print("api error:$e");
      customSnack(
          isSuccess: false,
          message: "No response from the server, Please try again".tr);
      return null;
    }
  }

  static Future<String?> putRequestWithNoBaseUrl(
      {required String apiName,
      required bool isJson,
      required Map<String, dynamic> mapData,
      Map<String, String>? headers,
      bool? isAuth}) async {
    /// check_internet
    bool result = await InternetConnectionChecker().hasConnection;
    // var connectivityResult = await (Connectivity().checkConnectivity());
    if (!result) {
      customSnack(
          isSuccess: false,
          message: "No internet connection, Please connect to internet.".tr);
      return null;
    }

    // if (headers == null) {
    //   String language = await SHAREDPREF.getLanguage();
    //   if (isAuth ?? false) {
    //     headers = {
    //       'Authorization': 'Bearer ${userLocalInfo!.token}',
    //       'Language': language
    //     };
    //   }else{
    //     headers = {'Language': language};
    //   }
    // }

    try {
      /// post Request
      var response = await client
          .put(Uri.parse(apiName),
              body: isJson ? json.encode(mapData) : mapData, headers: headers)
          .timeout(const Duration(seconds: 30));

      /// print response
      if (kDebugMode) {
        debugPrint(
            "headers:$headers: body:$mapData:api:$apiName :response:${response.body}",
            wrapWidth: 1024);
      }
      var statusCode = response.statusCode;
      var jsonString = response.body;

      /// check response
      switch (statusCode) {
        case HttpStatus.ok:
          // var jsonString = response.body;
          return jsonString;
        case HttpStatus.gatewayTimeout:
          customSnack(
              isSuccess: false,
              message: "No response from the server, Please try again".tr);
          return null;
        default:
          customSnack(isSuccess: false, message: jsonString);
          return null;
      }
    } catch (e) {
      if (kDebugMode) print("api error:$e");
      customSnack(
          isSuccess: false,
          message: "No response from the server, Please try again".tr);
      return null;
    }
  }

  static Future<String?> deleteRequest(
      {required String apiName,
      Map<String, String>? headers,
      bool? isAuth}) async {
    try {
      /// check_internet
      bool result = await InternetConnectionChecker().hasConnection;
      // var connectivityResult = await (Connectivity().checkConnectivity());
      if (!result) {
        customSnack(
            isSuccess: false,
            message: "No internet connection, Please connect to internet.".tr);
        return null;
      }
      //
      // headers ??= {
      //   'Content-Type': 'application/json',
      //   'accessToken': '$token',
      // };

      /// delete request
      var response = await client
          .delete(Uri.parse(Urls.BASE_URL + apiName), headers: headers)
          .timeout(const Duration(seconds: 30));

      /// print response
      if (kDebugMode) {
        debugPrint(
            "header:$headers:api:${Urls.BASE_URL + apiName}:response:${response.body}",
            wrapWidth: 1024);
      }
      var statusCode = response.statusCode;
      if (kDebugMode) print('statusCode:$statusCode}');

      /// check response
      switch (statusCode) {
        case HttpStatus.ok:
          var jsonString = response.body;
          if (kDebugMode) debugPrint(jsonString, wrapWidth: 1024);
          return jsonString;

        case HttpStatus.gatewayTimeout:
          customSnack(
              isSuccess: false,
              message: "No response from the server, Please try again".tr);
          return null;
        default:
          customSnack(
              isSuccess: false,
              message: "No response from the server, Please try again".tr);
          return null;
      }
    } catch (e) {
      if (kDebugMode) print(e);
      customSnack(
          isSuccess: false,
          message: "No response from the server, Please try again".tr);
      return null;
    }
  }
}
