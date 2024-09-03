import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../Controllers/LoginController/login_controller.dart';
import '../../../Helper/constants.dart';
import '../../../Helper/validation.dart';
import '../../../Utils/color.dart';
import '../../../Utils/text_style.dart';
import '../../../Widget/custom_button.dart';
import '../../../Widget/custom_loader.dart';
import '../../../Widget/custom_outline_button.dart';
import '../../../Widget/custom_text_field.dart';
import '../ForgetPasswordScreen/forgot_password_screen.dart';
import '../SignUpScreen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());

  final _validateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Obx(() {
      return LoadingOverlay(
        isLoading: loginController.isLoading.value,
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
                          "Login",
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
                            controller: loginController.emailTextController,
                            maxLines: 1,
                            hint: 'Enter your email',
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
                            controller: loginController.passwordTextController,
                            hint: 'Enter password',
                            passwordvisibility:
                                loginController.passwordVisibility.value,
                          )),
                      Container(
                          margin: EdgeInsets.only(
                              top: height * 0.04, bottom: height * 0.018),
                          child: CustomButton(
                              height: height * 0.075,
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (_validateKey.currentState!.validate()) {
                                  loginController.loginApi(context: context);
                                }
                              },
                              text: 'Login')),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            bottom: height * 0.023,
                          ),
                          child: InkWell(
                              onTap: () {
                                CONSTANTS.navigateToScreen(
                                    context, const ForgotPasswordScreen());
                              },
                              child: const Text("Forgot Password?"))),
                      Row(children: [
                        const Expanded(child: Divider()),
                        Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: const Text("New to The Sasta Store?")),
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
                                context, const SignUpScreen());
                          },
                          text: 'Signup',
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
