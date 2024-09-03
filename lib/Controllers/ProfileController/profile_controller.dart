import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sasta_store/Helper/shared_pref.dart';
import 'package:sasta_store/Models/ProfileModel/profile_model.dart';

import '../../../URLS.dart';
import '../../Network/api_services.dart';
import '../../Widget/custom_snackbar.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var isListNull = false.obs;
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

  var profileModel = ProfileModel().obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  getProfileApi() async {
    isListNull(false);
    Map<String, String>? headers = {
      'Authorization': 'Bearer ${SHAREDPREF.getToken()}'
    };

    var details = await APIService.getRequest(
        apiName: Urls.getProfileApi, headers: headers);

    if (details != null) {
      try {
        Map<String, dynamic> response = jsonDecode(details);
        if (response['status'] == 200) {
          profileModel.value = profileModelFromMap(details);
          if (profileModel.value.data != null) {
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

  Future updateProfileData(
      {required BuildContext context,
      required String image,
      required String email}) async {
    isLoading(true);
    isListNull(false);
    Map<String, String>? headers = {
      'Authorization': 'Bearer ${SHAREDPREF.getToken()}'
    };

    try {
      var postUri = Uri.parse("${Urls.BASE_URL}${Urls.updateProfileApi}");
      var request = http.MultipartRequest(
        "POST",
        postUri,
      );
      if (profileImage != null) {
        var multipartFile = http.MultipartFile(
          'profile_image',
          profileImage!.readAsBytes().asStream(),
          profileImage!.lengthSync(),
          filename: profileImage!.isAbsolute
              ? profileImage!.path.split('/').last
              : image,
        );

        request.files.add(multipartFile);
      }

      request.fields['name'] = nameController.text;
      request.headers.addAll(headers);
      request.fields['email'] = email;
      request.fields['phone'] = phoneController.text;

      var details = await APIService.uploadFiles(request);

      Map<String, dynamic> result = jsonDecode(details.toString());

      if (result['status'] == 200) {
        customSnackBarWidget(msg: result['message'].toString());

        await getProfileApi();
      } else if (result['status'] == 404) {
        customSnackBarWidget(msg: result['message'].toString());
      } else {
        customSnackBarWidget(msg: result['message'].toString());
      }

      isLoading(false);
      isListNull(false);
    } catch (e) {
      if (kDebugMode) print(e);
      errorSnackbar('Something went wrong. Please try again.');

      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
