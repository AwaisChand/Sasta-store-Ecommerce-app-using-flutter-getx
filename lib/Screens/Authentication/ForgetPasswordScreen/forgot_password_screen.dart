import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../Controllers/ForgotPasswordController/forgot_password_controller.dart';
import '../../../Helper/constants.dart';
import '../../../Helper/validation.dart';
import '../../../Utils/color.dart';
import '../../../Utils/text_style.dart';
import '../../../Widget/custom_button.dart';
import '../../../Widget/custom_loader.dart';
import '../../../Widget/custom_outline_button.dart';
import '../../../Widget/custom_text_field.dart';
import '../LoginScreen/login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());

  final _validateKey = GlobalKey<FormState>();

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
                          "Forgot Password",
                          style: CustomTextStyles.l34_SEMI_BOLD_Primary,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: height * 0.04),
                        child: Text(
                          "Email",
                          style: CustomTextStyles.l16_MEDIUM_black,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: CustomTextField(
                            validation: VALIDATIONS.validateEmail,
                            isPass: false,
                            controller:
                                forgotPasswordController.emailTextController,
                            maxLines: 1,
                            hint: 'Enter your email',
                            passwordvisibility: false,
                          )),
                      Container(
                        margin: EdgeInsets.only(
                            top: height * 0.07, bottom: height * 0.045),
                        child: CustomButton(
                          height: height * 0.068,
                          onPressed: () {
                            if (_validateKey.currentState!.validate()) {
                              forgotPasswordController.forgotPassApi(
                                  context: context);
                            }
                          },
                          text: 'Forgot Password',
                        ),
                      ),
                      Row(children: <Widget>[
                        const Expanded(child: Divider()),
                        Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: const Text("Already know Password?")),
                        const Expanded(child: Divider()),
                      ]),
                      Container(
                        margin: EdgeInsets.only(
                            top: height * 0.024, bottom: height * 0.015),
                        child: CustomOutlineButton(
                          textStyle: CustomTextStyles.l18_SEMI_BOLD_WHITE
                              .copyWith(color: AppColors.pureBlack),
                          height: height * 0.068,
                          radius: 80.0,
                          onPressed: () {
                            CONSTANTS.replaceScreen(
                                context, const LoginScreen());
                          },
                          text: 'Login',
                        ),
                      )
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
