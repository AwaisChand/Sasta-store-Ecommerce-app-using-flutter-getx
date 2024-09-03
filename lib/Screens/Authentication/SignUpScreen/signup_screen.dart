import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sasta_store/Controllers/SignUpController/signup_controller.dart';
import 'package:sasta_store/Screens/Authentication/LoginScreen/login_screen.dart';

import '../../../Helper/constants.dart';
import '../../../Helper/validation.dart';
import '../../../Utils/color.dart';
import '../../../Utils/text_style.dart';
import '../../../Widget/custom_button.dart';
import '../../../Widget/custom_loader.dart';
import '../../../Widget/custom_outline_button.dart';
import '../../../Widget/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpController signUpController = Get.put(SignUpController());

  final _validateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Obx(() {
      return LoadingOverlay(
        isLoading: signUpController.isLoading.value,
        progressIndicator: CustomLoader(),
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          resizeToAvoidBottomInset: false,
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
                        margin: EdgeInsets.only(top: height * 0.07),
                        child: Text(
                          "Signup",
                          style: CustomTextStyles.l34_SEMI_BOLD_Primary,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: height * 0.04),
                        child: Text(
                          "Name",
                          style: CustomTextStyles.l16_MEDIUM_black,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: CustomTextField(
                            validation: VALIDATIONS.validateName,
                            isPass: false,
                            controller: signUpController.nameTextController,
                            maxLines: 1,
                            hint: 'Enter your name',
                            passwordvisibility: false,
                          )),
                      Container(
                        margin: EdgeInsets.only(top: height * 0.019),
                        child: Text(
                          "Phone",
                          style: CustomTextStyles.l16_MEDIUM_black,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: CustomTextField(
                            validation: VALIDATIONS.validateMobilePhone,
                            isPass: false,
                            controller: signUpController.phoneTextController,
                            maxLines: 1,
                            hint: 'Enter your phone number',
                            passwordvisibility: false,
                          )),
                      Container(
                        margin: EdgeInsets.only(top: height * 0.019),
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
                            controller: signUpController.emailTextController,
                            maxLines: 1,
                            hint: 'Enter your email',
                            passwordvisibility: false,
                          )),
                      Container(
                        margin: EdgeInsets.only(top: height * 0.019),
                        child: Text(
                          "Reference Code",
                          style: CustomTextStyles.l16_MEDIUM_black,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: CustomTextField(
                            validation: VALIDATIONS.validateOptional,
                            isPass: false,
                            controller: signUpController.referTextController,
                            maxLines: 1,
                            hint: 'Reference code (options)',
                            passwordvisibility: false,
                          )),
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
                            controller: signUpController.passwordTextController,
                            hint: 'Enter password',
                            passwordvisibility:
                                signUpController.passwordVisibility.value,
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
                            controller:
                                signUpController.confirmpasswordTextController,
                            hint: 'Confirm password',
                            passwordvisibility: signUpController
                                .confirmpasswordVisibility.value,
                          )),
                      Container(
                        margin: EdgeInsets.only(
                            top: height * 0.04, bottom: height * 0.018),
                        child: CustomButton(
                          height: height * 0.075,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_validateKey.currentState!.validate()) {
                              signUpController.signupApi(context: context);
                            }
                          },
                          text: 'SignUp',
                        ),
                      ),
                      Row(children: [
                        const Expanded(child: Divider()),
                        Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: const Text("Already have an account?")),
                        const Expanded(child: Divider()),
                      ]),
                      Container(
                        margin: EdgeInsets.only(
                            top: height * 0.024, bottom: height * 0.015),
                        child: CustomOutlineButton(
                          textStyle: CustomTextStyles.l18_SEMI_BOLD_WHITE
                              .copyWith(color: AppColors.pureBlack),
                          height: height * 0.075,
                          radius: 80.0,
                          onPressed: () {
                            CONSTANTS.navigateToScreen(
                                context, const LoginScreen());
                          },
                          text: 'Login',
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
