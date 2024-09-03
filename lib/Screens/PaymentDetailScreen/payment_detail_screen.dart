import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Controllers/CheckOutController/checkout_controller.dart';
import 'package:sasta_store/Controllers/PaymentDetailController/payment_detail_controller.dart';
import 'package:sasta_store/Utils/color.dart';
import 'package:sasta_store/Utils/images.dart';
import 'package:sasta_store/Utils/text_style.dart';
import 'package:sasta_store/Widget/custom_snackbar.dart';
import 'package:sasta_store/Widget/custom_text_field.dart';

class PaymentDetailScreen extends StatefulWidget {
  // final Function(File, String) onVerify;

  const PaymentDetailScreen({
    Key? key,
    // required this.onVerify,
  }) : super(key: key);

  @override
  _PaymentDetailScreenState createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  final TextEditingController transactionController = TextEditingController();

  CheckoutControllerController checkoutControllerController =
      Get.put(CheckoutControllerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Upload Receipt"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Account Details",
                    style: CustomTextStyles.l16_MEDIUM_black.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                accountInfoWidget("Account Title: ", "MaxCore Technologies"),
                const SizedBox(height: 20),
                accountInfoWidget("IBAN: ", "PK18UNIL0109000268435549"),
                const SizedBox(height: 20),
                accountInfoWidget("Account Number: ", "012345678912345"),
                const SizedBox(height: 20),
                accountInfoWidget("Account Name: ", "UBL Bank"),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: transactionController,
                  validation: (_) {},
                  isPass: false,
                  passwordvisibility: false,
                  maxLines: 1,
                  hint: "Type Transaction Number",
                ),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    Obx(() {
                      return checkoutControllerController.isFromPath.value == true
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                checkoutControllerController.profileImage!,
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                Images.localImagesPath +
                                    Images.default_profile_image,
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                            );
                    }),
                    Positioned(
                      right: 0,
                      top: 5,
                      child: Container(
                        height: 30,
                        width: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.2),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            checkoutControllerController.pickImage();
                          },
                          child: const Center(
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      color: Colors.black,
                      height: 60,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        if (transactionController.text.isEmpty) {
                          errorSnackbar("Please type your transaction number");
                        } else if (checkoutControllerController.profileImage ==
                            null) {
                          errorSnackbar("Please upload your receipt");
                        } else {
                          checkoutControllerController.uploadReceipt(
                            context: context,
                            image: checkoutControllerController.profileImage!.path,
                            transaction: transactionController.text,
                          );
                        }
                      },
                      child: Text(
                        "Verify Now",
                        style: CustomTextStyles.l16_MEDIUM_black.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

Widget accountInfoWidget(String title, String text) {
  return Row(
    children: [
      Text(
        title,
        style: CustomTextStyles.l16_MEDIUM_black.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(width: 20),
      Text(
        text,
        style: CustomTextStyles.l16_MEDIUM_black.copyWith(fontSize: 15),
      ),
    ],
  );
}
