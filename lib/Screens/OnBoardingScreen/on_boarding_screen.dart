import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/OnBoardingController/on_boarding_controller.dart';
import '../../Helper/constants.dart';
import '../../Utils/color.dart';
import '../../Utils/images.dart';
import '../../Utils/text_style.dart';
import '../../Widget/custom_button.dart';
import '../Authentication/LoginScreen/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = OnBoardingController();

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
//    selectNotification2();
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: PageView.builder(
            controller: controller.pageController,
            physics: const ClampingScrollPhysics(),
            onPageChanged: (index) {
              if (index == 3) {
                CONSTANTS.navigateToScreen(context, const LoginScreen());
                return;
              }
              controller.selectedIndex.value = index;
            },
            itemCount: controller.onBoardingPages.length + 1,
            itemBuilder: (_, index) {
              return index == 3
                  ? Container()
                  : SizedBox(
                      width: width,
                      height: height,
                      child: Stack(
                        children: [
                          Image.asset(
                            "${Images.localImagesPath}background.png",
                            height: height * 0.5,
                            fit: BoxFit.fill,
                            width: width,
                          ),
                          Positioned(
                            top: height * 0.1,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: Image.asset(
                                  controller.onBoardingPages[index].image ?? "",
                                  height: height * 0.26,
                                  fit: BoxFit.scaleDown,
                                  width: width,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: height * 0.55,
                            child: SingleChildScrollView(
                                child: Center(
                              child: Container(
                                width: width,
                                padding: EdgeInsets.only(
                                  left: 22,
                                  right: 22,
                                  bottom: height * 0.011,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.onBoardingPages[index].title ??
                                          '',
                                      style: CustomTextStyles
                                          .l34_SEMI_BOLD_Primary,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: height * 0.025,
                                          bottom: height * 0.042),
                                      child: Text(
                                        controller.onBoardingPages[index]
                                                .description ??
                                            '',
                                        style: CustomTextStyles.l18_MEDIUM_grey,
                                      ),
                                    ),
                                    CustomButton(
                                      onPressed: () {
                                        CONSTANTS.navigateToScreen(
                                            context, const LoginScreen());
                                      },
                                      text: 'Get Started',
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 25, bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                            controller.onBoardingPages.length,
                                            (index) => Obx(() {
                                                  return Container(
                                                    height: 8,
                                                    width: 8,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 4.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .primaryColor),
                                                        color: controller
                                                                    .selectedIndex
                                                                    .value ==
                                                                index
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors
                                                                .whiteColor),
                                                  );
                                                })),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          ),
                          Positioned(
                              top: 40,
                              right: 1,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 24, right: 24, top: 15),
                                child: InkWell(
                                    onTap: () {
                                      CONSTANTS.navigateToScreen(
                                          context, const LoginScreen());
                                    },
                                    child: Text(
                                      'Skip',
                                      style: CustomTextStyles.l17_MEDIUM_WHITE,
                                    )),
                              )),
                        ],
                      ),
                    );
            }),
      ),
    );
  }
}
