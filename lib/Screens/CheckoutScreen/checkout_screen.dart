import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:sasta_store/Screens/Order/order_history.dart';
import 'package:sasta_store/Screens/PaymentDetailScreen/payment_detail_screen.dart';
import 'package:sasta_store/Widget/custom_loader.dart';
import 'package:sasta_store/Widget/custom_snackbar.dart';
import 'package:sasta_store/Controllers/CheckOutController/checkout_controller.dart';
import 'package:sasta_store/Helper/validation.dart';
import 'package:sasta_store/Utils/color.dart';
import 'package:sasta_store/Utils/text_style.dart';
import 'package:sasta_store/Widget/custom_button.dart';
import 'package:sasta_store/Widget/custom_text_field.dart';

class CheckOutScreen extends StatefulWidget {
  final String itemCount;

  const CheckOutScreen({super.key, required this.itemCount});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final _validateKey = GlobalKey<FormState>();
  CheckoutControllerController checkoutControllerController =
      Get.put(CheckoutControllerController());
  int selectedIndex = -1;
  String selectedPaymentMethod = '';
  LatLng? _currentPosition;
  String _currentAddress = '';
  final Set<Marker> _markers = {};

  final Completer<GoogleMapController> _controller = Completer();
  LatLng _selectedLocation =
      const LatLng(30.186048999520963, 71.52702642082903);

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(30.186048999520963, 71.52702642082903),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkoutControllerController.getPaymentMethodApi();
    });
    _determinePosition();
    _showDisclosureDialog();
  }

  Future<void> _showDisclosureDialog() async {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Ensure the dialog is not dismissible by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Required'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'This app collects location data to enable features such as navigation, ride-sharing, and delivery tracking, even when the app is closed or not in use.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Decline'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Accept'),
              onPressed: () {
                Navigator.of(context).pop();
                _determinePosition();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            '${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
        _markers.add(
          Marker(
            markerId: const MarkerId('currentLocation'),
            position: _currentPosition!,
            infoWindow:
                InfoWindow(title: 'Current Location', snippet: _currentAddress),
          ),
        );
        checkoutControllerController.addressController.text = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    PermissionStatus permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions using permission_handler
    permission = await Permission.location.status;
    if (permission.isDenied) {
      permission = await Permission.location.request();
      if (permission.isDenied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission.isPermanentlyDenied) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // If everything is granted, get the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (kDebugMode) {
      print("Position obtained: ${position.latitude}, ${position.longitude}");
    }
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    await _getAddressFromLatLng(position.latitude, position.longitude);

    if (_controller.isCompleted) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentPosition!, zoom: 12.0),
      ));
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    if (_currentPosition != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentPosition!, zoom: 14.0),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        onPressed: () {
          Get.to(() => const PaymentDetailScreen());
        },
        label: Text(
          "Upload Receipt",
          style: CustomTextStyles.l16_SemiBold_PrimaryColor,
        ),
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Checkout',
          style: CustomTextStyles.l18_SEMI_BOLD_WHITE
              .copyWith(color: AppColors.blackColor),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined,
              color: AppColors.blackColor),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(200),
            bottomLeft: Radius.circular(200),
          ),
        ),
      ),
      body: Obx(() {
        if (checkoutControllerController.isLoading.value) {
          return CustomLoader();
        } else {
          return LoadingOverlay(
            isLoading: checkoutControllerController.isSubLoader.value,
            progressIndicator: CustomLoader(),
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                child: SingleChildScrollView(
                  child: Form(
                    key: _validateKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: height * 0.04),
                          child: Text("Select Payment Method",
                              style: CustomTextStyles.l16_MEDIUM_black),
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: checkoutControllerController
                                .paymentMethodModel.value.data?.length,
                            itemBuilder: (context, index) {
                              final paymentMethod = checkoutControllerController
                                  .paymentMethodModel.value.data?[index];
                              return GestureDetector(
                                onTap: () {
                                  checkoutControllerController
                                          .paymentMethodId.value =
                                      paymentMethod?.id.toString() ?? '';
                                  checkoutControllerController
                                          .isSelectedMethod.value =
                                      !checkoutControllerController
                                          .isSelectedMethod.value;
                                  setState(() {
                                    selectedIndex = index;
                                    selectedPaymentMethod =
                                        paymentMethod?.name ?? '';
                                  });
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? AppColors.secondryColor
                                        : AppColors.lightGreyColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              paymentMethod?.imageUrl ?? ''),
                                    ),
                                    title: Text(paymentMethod?.name ?? ''),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height * 0.04),
                          child: Text("Address",
                              style: CustomTextStyles.l16_MEDIUM_black),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: CustomTextField(
                            validation: VALIDATIONS.validateAddress,
                            isPass: false,
                            controller:
                                checkoutControllerController.addressController,
                            maxLines: 1,
                            hint: 'Enter your address',
                            passwordvisibility: false,
                            textStyle: TextStyle(
                                fontSize: 13, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height * 0.04),
                          child: Text("Address(Optional)",
                              style: CustomTextStyles.l16_MEDIUM_black),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: CustomTextField(
                            validation: VALIDATIONS.validateOptional,
                            isPass: false,
                            controller: checkoutControllerController
                                .optionalAddressController,
                            maxLines: 1,
                            hint: 'Enter your address',
                            passwordvisibility: false,
                            textStyle: TextStyle(
                                fontSize: 13, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height * 0.04),
                          child: Text("Add Comments",
                              style: CustomTextStyles.l16_MEDIUM_black),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: CustomTextField(
                            validation: VALIDATIONS.validateOptional,
                            isPass: false,
                            controller:
                                checkoutControllerController.commentController,
                            maxLines: 6,
                            hint: 'Enter your comments',
                            passwordvisibility: false,
                            textStyle: const TextStyle(
                                fontSize: 14, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Items',
                                style: CustomTextStyles.l16_MEDIUM_textgrey),
                            Text(widget.itemCount.toString(),
                                style: CustomTextStyles.l12_Medium_slateGrey),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery Charges:',
                                style: CustomTextStyles.l16_MEDIUM_textgrey),
                            Text(
                                '\$${checkoutControllerController.paymentMethodModel.value.deliveryCharges}',
                                style: CustomTextStyles.l12_Medium_slateGrey),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('SubTotal:',
                                style: CustomTextStyles.l16_MEDIUM_textgrey),
                            PersistentShoppingCart().showTotalAmountWidget(
                              cartTotalAmountWidgetBuilder:
                                  (double totalAmount) {
                                checkoutControllerController.subTotalAmount
                                    .value = totalAmount.toString();
                                return Text(
                                    '${checkoutControllerController.subTotalAmount.value}\$',
                                    style:
                                        CustomTextStyles.l12_Medium_slateGrey);
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total:',
                                style: CustomTextStyles.l16_MEDIUM_textgrey),
                            PersistentShoppingCart().showTotalAmountWidget(
                              cartTotalAmountWidgetBuilder:
                                  (double totalAmount) {
                                checkoutControllerController
                                    .totalOrderAmount.value = (totalAmount +
                                        double.parse(
                                            checkoutControllerController
                                                .paymentMethodModel
                                                .value
                                                .deliveryCharges
                                                .toString()))
                                    .toString();
                                return Text(
                                    '${checkoutControllerController.totalOrderAmount.value}\$',
                                    style:
                                        CustomTextStyles.l12_Medium_slateGrey);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: height * .04),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            height: 180,
                            child: GoogleMap(
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: _initialCameraPosition,
                              markers: _markers,
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                              compassEnabled: true,
                              zoomControlsEnabled: true,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: height * 0.04, bottom: height * 0.018),
                          child: CustomButton(
                            height: height * 0.075,
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (_validateKey.currentState!.validate()) {
                                if (selectedPaymentMethod ==
                                    'Cash On Delivery') {
                                  await checkoutControllerController
                                      .makeOrderApi(context);
                                  Get.to(() => const OrderHistoryScreen());
                                  checkoutControllerController.addressController
                                      .clear();
                                  checkoutControllerController.commentController
                                      .clear();
                                } else {
                                  await checkoutControllerController
                                      .makeOrderApi(context);
                                  errorSnackbar(
                                      "Please upload receipt to complete your order");
                                  checkoutControllerController.addressController
                                      .clear();
                                  checkoutControllerController.commentController
                                      .clear();
                                }
                              }
                            },
                            text: 'Place Order',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
