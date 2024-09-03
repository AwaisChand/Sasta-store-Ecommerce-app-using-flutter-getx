import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Controllers/OrderController/order_detail_controller.dart';
import 'package:sasta_store/Screens/PaymentDetailScreen/payment_detail_screen.dart';
import 'package:sasta_store/Widget/custom_cache_image.dart';

import '../../Utils/color.dart';
import '../../Utils/text_style.dart';
import '../../Widget/custom_loader.dart';

class OrderDetailScreen extends StatefulWidget {
  final String id;

  const OrderDetailScreen({super.key, required this.id});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  OrderDetailController orderDetailController =
      Get.put(OrderDetailController());

  @override
  void initState() {
    orderDetailController.getOrderDetailApi(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Order Details",
            style: CustomTextStyles.l16_MEDIUM_black,
          ),
          backgroundColor: AppColors.whiteColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined,
                  color: AppColors.blackColor)),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.orange),
        ),
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
        body: Obx(() {
          if (orderDetailController.isLoading.value) {
            return CustomLoader();
          } else if (orderDetailController.isListNull.value) {
            return const Center(child: Text('No Order detail found'));
          } else {
            return SingleChildScrollView(
                child: Column(children: [
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orderDetailController
                      .orderDetailModel.value.data?.orderItems?.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = orderDetailController
                        .orderDetailModel.value.data?.orderItems?[index];
                    return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                            // color: Colors.white70,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 2.0,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          //  crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomCacheImage(
                                                url: data?.product
                                                        ?.thumbnailUrl ??
                                                    '',
                                                height: 100,
                                                width: 60),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.9,
                                                  child: Text(
                                                    data?.product?.title ?? '',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02),
                                                Text(
                                                    'price ${data?.product?.price ?? ''}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02),
                                          ]),
                                    ]))));
                  }),
              const SizedBox(height: 30),
              Container(
                  height: 220,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'length : ${orderDetailController.orderDetailModel.value.data?.orderItems?.length}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black)),
                          Text(
                              'subtotal : ${orderDetailController.orderDetailModel.value.data?.subtotal ?? ""}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14)),
                        ]),
                    const SizedBox(height: 10),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tax",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                          Text("does not apply",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        ]),
                    const SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Delivery charges",
                              style: TextStyle(fontSize: 14)),
                          Text(
                              orderDetailController.orderDetailModel.value.data
                                      ?.deliveryCharges ??
                                  '',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14)),
                        ]),
                    const SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Payment method",
                              style: TextStyle(
                                fontSize: 14,
                              )),
                          Text(
                              orderDetailController.orderDetailModel.value.data
                                      ?.paymentMethod?.name ??
                                  '',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14)),
                        ]),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Grand Total",
                              style: TextStyle(fontSize: 16)),
                          Text(
                              orderDetailController
                                      .orderDetailModel.value.data?.total ??
                                  '',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14)),
                        ]),
                  ]))
            ]));
          }
        }));
  }
}
