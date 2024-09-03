import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:sasta_store/Helper/shared_pref.dart';
import 'package:sasta_store/Models/CheckoutModel/checkout_model.dart';
import 'package:sasta_store/Models/UploadReceiptModel/upload_reeceipt_model.dart';
import 'package:sasta_store/Network/api_services.dart';
import 'package:sasta_store/Screens/CheckoutScreen/checkout_screen.dart';
import 'package:sasta_store/Screens/HomeScreen/home_screen.dart';
import 'package:sasta_store/URLS.dart';
import 'package:http/http.dart' as http;
import 'package:sasta_store/Widget/custom_snackbar.dart';

class CheckoutControllerController extends GetxController {
  var isLoading = true.obs;
  var isSubLoader = false.obs;
  var isListNull = false.obs;
  var isSelectedMethod = false.obs;
  var paymentMethodId = ''.obs;
  var totalOrderAmount = ''.obs;
  var subTotalAmount = ''.obs;
  var addressController = TextEditingController();
  var optionalAddressController = TextEditingController();
  var commentController = TextEditingController();
  String orderId = '';

  XFile? pickedFile;
  File? profileImage;
  var isFromPath = false.obs;
  final picker = ImagePicker();

  var paymentMethodModel = PaymentMethodModel().obs;
  List<OrderItem>? orderData;
  List<OrderItem> orderData2 = [];
  CheckOutModel checkOutModel = CheckOutModel();
  var uploadReceiptModel = UploadReceiptModel().obs;

  getPaymentMethodApi() async {
    isListNull(false);
    isLoading(true);
    Map<String, String>? headers = {
      'Authorization': 'Bearer ${SHAREDPREF.getToken()}'
    };

    var details = await APIService.getRequest(
        apiName: Urls.getPaymentMethodApi, headers: headers);

    if (details != null) {
      try {
        paymentMethodModel.value = paymentMethodModelFromMap(details);
        if (paymentMethodModel.value.data!.isNotEmpty) {
          Map<String, dynamic> cartData =
              PersistentShoppingCart().getCartData();
          List<PersistentShoppingCartItem>? cartItems = cartData['cartItems'];

          for (int i = 0; i < cartItems!.length; i++) {
            orderData2.add(OrderItem(
                productId: int.tryParse(cartItems[i].productId.toString()),
                price: double.tryParse(cartItems[i].unitPrice.toString()),
                qty: int.tryParse(cartItems[i].quantity.toString())));
          }
          checkOutModel.orderItems = orderData2;

          isListNull(false);
          isLoading(false);
        } else {
          isLoading(false);
          isListNull(true);
        }
      } catch (e) {
        if (kDebugMode) print(e);
        isLoading(false);
        isListNull(true);
      }
    } else {
      isLoading(false);
      isListNull(true);
    }
  }

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

  makeOrderApi(BuildContext context) async {
    isSubLoader(true);
    isListNull(false);

    try {
      // Get cart data from persistent storage
      Map<String, dynamic> cartData = PersistentShoppingCart().getCartData();
      List<PersistentShoppingCartItem>? cartItems = cartData['cartItems'];

      // Create CheckOutModel
      checkOutModel = CheckOutModel(
        orderItems: orderData2,
      );

      // Prepare request body as JSON
      Map<String, dynamic> mapData = {
        "type": "postman",
        "subtotal": subTotalAmount.value,
        "delivery_charges": paymentMethodModel.value.deliveryCharges,
        "discount": 0,
        "total": totalOrderAmount.value,
        "address": addressController.text,
        "comment": commentController.text,
        "payment_method_id": paymentMethodId.value,
        // Convert order items to list of maps
        "order_items": orderData2.map((item) => item.toMap()).toList(),
      };

      // Prepare headers
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SHAREDPREF.getToken()}'
      };

      // Make API request
      var details = await APIService.postRequest(
        apiName: Urls.checkOutApi,
        isJson: true,
        mapData: mapData,
        headers: headers,
      );

      debugPrint("details: $details");

      if (details != null && details.toString() != '[]') {
        Map<String, dynamic> response = jsonDecode(details);

        if (response['status'] == 200) {
          PersistentShoppingCart().clearCart();
          cartItems?.clear();
          customSnack(isSuccess: true, message: response['message']);
          orderId = response['order_id'].toString();
          debugPrint("order id: $orderId");

          // return orderId;
        } else {
          Get.snackbar("Error", response['message']);
        }
      } else {
        customSnackBarWidget(msg: 'Failed to place order');
      }
    } catch (e) {
      if (kDebugMode) print(e);
      customSnackBarWidget(msg: 'Failed to place order');
    } finally {
      isSubLoader(false);
      isListNull(false);
    }
  }



  Future uploadReceipt({
    required BuildContext context,
    required String image,
    required String transaction,
  }) async {
    isLoading(true);
    isListNull(false);
    try {
      Map<String, dynamic> cartData = PersistentShoppingCart().getCartData();
      List<PersistentShoppingCartItem>? cartItems = cartData['cartItems'];
      var postUri =
          Uri.parse("${Urls.BASE_URL}${Urls.uploadReceiptApi}/$orderId");
      var request = http.MultipartRequest("POST", postUri);

      debugPrint("url: $postUri");
      debugPrint("order id get: $orderId");

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
          PersistentShoppingCart().clearCart();
          cartItems?.clear();
          customSnack(isSuccess: true, message: result['message']);
          Get.to(()=> const HomeScreen());
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
