import 'package:animated_pin_input_text_field/animated_pin_input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../Controllers/VerifyOTPControler/verify_otp_controller.dart';
import '../../../Utils/color.dart';
import '../../../Utils/text_style.dart';
import '../../../Widget/custom_button.dart';
import '../../../Widget/custom_loader.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;

  const VerifyOtpScreen({super.key, required this.email});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  VerifyOtpController forgotPasswordController = Get.put(VerifyOtpController());

  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    forgotPasswordController.otpController();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Obx(() {
      return LoadingOverlay(
        progressIndicator: CustomLoader(),
        isLoading: forgotPasswordController.isLoading.value,
        color: AppColors.pureBlack,
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: AppColors.primaryColor,
                )),
          ),
          body: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: height * 0.02),
                  child: Text(
                    "Verification",
                    style: CustomTextStyles.l34_SEMI_BOLD_Primary,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: height * 0.1),
                  child: Text(
                    "Enter verification code sent to\n ${widget.email} ",
                    style: CustomTextStyles.l18_SEMI_BOLD_MIDBLACK,
                  ),
                ),
                SizedBox(height: height * 0.1),
                Directionality(
                    textDirection: TextDirection.ltr,
                    child: PinInputTextField(
                      pinLength: 6,
                      fillColor: AppColors.whiteColor,
                      focusBorder: Border.all(color: AppColors.primaryColor),
                      onChanged: (String value) {
                        forgotPasswordController.otpController.value = value;
                        debugPrint(value);
                      },
                    )),
                Container(
                  margin: EdgeInsets.only(
                      top: height * 0.1,
                      bottom: height * 0.045,
                      left: 20,
                      right: 20),
                  child: CustomButton(
                    height: height * 0.068,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        forgotPasswordController.otpVerifyApi(
                            context: context, email: widget.email);
                      }
                    },
                    text: 'Validate',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
