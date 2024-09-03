import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Controllers/OrderController/order_history_controller.dart';
import 'package:sasta_store/Helper/constants.dart';
import 'package:sasta_store/Screens/Order/order_detail.dart';
import 'package:sasta_store/Screens/PaymentDetailScreen/payment_detail_screen.dart';
import 'package:sasta_store/Utils/color.dart';
import 'package:sasta_store/Widget/custom_cache_image.dart';
import 'package:sasta_store/Widget/custom_loader.dart';

import '../../Utils/text_style.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  OrderHistoryController orderHistoryController =
      Get.put(OrderHistoryController());

  @override
  void initState() {
    super.initState();
    orderHistoryController.getOrderHistoryApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Order History',
          style: CustomTextStyles.l16_MEDIUM_black,
        ),
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                color: AppColors.blackColor)),
      ),
      body: Obx(() {
        if (orderHistoryController.isLoading.value) {
          return CustomLoader();
        } else if (orderHistoryController.isListNull.value) {
          return const Center(child: Text('No Order found'));
        } else {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: orderHistoryController
                  .orderHistoryModel.value.data?.data?.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: () {
                        CONSTANTS.navigateToScreen(
                            context,
                            OrderDetailScreen(
                              id: orderHistoryController
                                  .orderHistoryModel.value.data!.data![index].id
                                  .toString(),
                            ));
                      },
                      child: Container(
                          child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: CustomCacheImage(
                                    url: orderHistoryController
                                            .orderHistoryModel
                                            .value
                                            .data
                                            ?.data![index]
                                            .paymentMethod!
                                            .imageUrl ??
                                        '',
                                    height: 200,
                                    width: 130,
                                  )),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.6),
                                    child: Text(
                                      'subtotal ${orderHistoryController.orderHistoryModel.value.data?.data?[index].subtotal ?? ''}',
                                      style: TextStyle(fontSize: 16.0),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.6),
                                    child: Text(
                                      'delivery ${orderHistoryController.orderHistoryModel.value.data?.data?[index].deliveryCharges ?? ''}',
                                      style: TextStyle(fontSize: 16.0),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.6),
                                    child: Text(
                                      'total ${orderHistoryController.orderHistoryModel.value.data?.data?[index].total ?? ''}',
                                      style: TextStyle(fontSize: 16.0),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.6),
                                    child: Text(
                                      'status ${orderHistoryController.orderHistoryModel.value.data?.data?[index].orderStatus ?? ''}',
                                      style: TextStyle(fontSize: 16.0),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                    ));
              });
        }
      }),
    );
  }
}
