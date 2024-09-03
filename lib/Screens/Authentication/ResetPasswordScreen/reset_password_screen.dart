import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../Controllers/ResetPasswordController/reset_password_controller.dart';
import '../../../Helper/validation.dart';
import '../../../Utils/color.dart';
import '../../../Utils/text_style.dart';
import '../../../Widget/custom_button.dart';
import '../../../Widget/custom_loader.dart';
import '../../../Widget/custom_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  ResetPasswordController resetPasswordController =
      Get.put(ResetPasswordController());

  final _validateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Obx(() {
      return LoadingOverlay(
        progressIndicator: CustomLoader(),
        isLoading: resetPasswordController.isLoading.value,
        color: AppColors.pureBlack,
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: AppColors.primaryColor,
                )),
          ),
          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(left: 25, right: 25),
              child: SingleChildScrollView(
                child: Form(
                  key: _validateKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: Text(
                          "Reset Password",
                          style: CustomTextStyles.l34_SEMI_BOLD_Primary,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: height * 0.019),
                        child: Text(
                          "Password",
                          style: CustomTextStyles.l16_MEDIUM_black,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: CustomTextField(
                            validation: VALIDATIONS.validatePassword,
                            isPass: true,
                            maxLines: 1,
                            controller:
                                resetPasswordController.passwordController,
                            hint: 'Enter password',
                            passwordvisibility: resetPasswordController
                                .passwordVisibility.value,
                          )),
                      Container(
                        margin: EdgeInsets.only(top: height * 0.019),
                        child: Text(
                          "Confirm Password",
                          style: CustomTextStyles.l16_MEDIUM_black,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: CustomTextField(
                            validation: VALIDATIONS.validateConfirmPassword,
                            isPass: true,
                            maxLines: 1,
                            controller: resetPasswordController
                                .confirmPasswordController,
                            hint: 'Confirm password',
                            passwordvisibility: resetPasswordController
                                .confirmpasswordVisibility.value,
                          )),
                      Container(
                        margin: EdgeInsets.only(
                            top: height * 0.07, bottom: height * 0.045),
                        child: CustomButton(
                          height: height * 0.068,
                          onPressed: () {
                            if (_validateKey.currentState!.validate()) {
                              resetPasswordController.resetPassApi(
                                  context: context, email: widget.email);
                            }
                          },
                          text: 'Reset Password',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
