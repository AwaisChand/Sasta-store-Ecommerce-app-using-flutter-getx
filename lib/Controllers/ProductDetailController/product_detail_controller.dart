import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:sasta_store/Helper/shared_pref.dart';
import 'package:sasta_store/Models/ProductDetailModel/product_detail_model.dart';

import '../../../URLS.dart';
import '../../Network/api_services.dart';
import '../../Widget/custom_snackbar.dart';

class ProductDetailController extends GetxController {
  var isLoading = true.obs;
  var isListNull = false.obs;
  var addedToCart = false.obs;

  var productDetailModel = ProductDetailModel().obs;

  getProductApi(String id) async {
    isLoading(true);
    addedToCart(false);
    isListNull(false);

    Map<String, String>? headers = {
      'Authorization': 'Bearer ${SHAREDPREF.getToken()}'
    };

    var details = await APIService.getRequest(
        apiName: Urls.getProductDetailApi + id, headers: headers);

    if (details != null) {
      try {
        productDetailModel.value = productDetailModelFromMap(details);
        if (productDetailModel.value.data != null) {
          Map<String, dynamic> cartData =
              PersistentShoppingCart().getCartData();
          List<PersistentShoppingCartItem> cartItems = cartData['cartItems'];
          if (cartItems.isNotEmpty) {
            var product = cartItems.firstWhere(
                (product) => product.productId == id.toString(),
                orElse: () => cartItems[0]);
            print(product.quantity);
            if (product.productId == id) {
              addedToCart(true);
            }
          }

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
