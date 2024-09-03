import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Controllers/BalanceHistoryController/balance_history_controller.dart';
import 'package:sasta_store/Utils/text_style.dart';
import 'package:sasta_store/Widget/custom_loader.dart';

class BalanceHistoryScreen extends StatefulWidget {
  const BalanceHistoryScreen({super.key});

  @override
  State<BalanceHistoryScreen> createState() => _BalanceHistoryScreenState();
}

class _BalanceHistoryScreenState extends State<BalanceHistoryScreen> {
  final BalanceHistoryController balanceHistoryController =
      Get.put(BalanceHistoryController());

  @override
  void initState() {
    balanceHistoryController.getBalanceHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Balance History"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (balanceHistoryController.isLoading.value) {
          return CustomLoader();
        } else if (balanceHistoryController.isListNull.isTrue) {
          return const Center(child: Text("You have no balance history"));
        } else {
          return ListView.builder(
              itemCount: balanceHistoryController
                  .balanceHistoryModel.value.data?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //  user profile photo
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "User Profile: ",
                                style: CustomTextStyles.l16_MEDIUM_black
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image(
                                  image: NetworkImage(
                                      "${balanceHistoryController.balanceHistoryModel.value.data?[index].toUser?.profileImageUrl}"),
                                  fit: BoxFit.cover,
                                  height: 50,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "User Name: ",
                                style: CustomTextStyles.l16_MEDIUM_black
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${balanceHistoryController.balanceHistoryModel.value.data?[index].toUser?.name}",
                                style: CustomTextStyles.l16_MEDIUM_black
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Balance Hisory: ",
                                style: CustomTextStyles.l16_MEDIUM_black
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${balanceHistoryController.balanceHistoryModel.value.data?[index].toUser?.balance}",
                                style: CustomTextStyles.l16_MEDIUM_black
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      }),
    );
  }
}
