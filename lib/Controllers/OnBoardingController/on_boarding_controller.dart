import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Helper/constants.dart';
import '../../Models/OnBoardingModel/on_boarding_model.dart';
import '../../Screens/Authentication/LoginScreen/login_screen.dart';
import '../../Utils/images.dart';

class OnBoardingController extends GetxController {
  var selectedIndex = 0.obs;

  bool get isLastPage => selectedIndex.value == onBoardingPages.length - 1;
  PageController pageController = PageController();

  forwardAction(BuildContext context) {
    if (isLastPage) {
      // CONSTANTS.clearUserData();
      CONSTANTS.replaceAllScreen(context, const LoginScreen());
    } else {
      pageController.nextPage(
          duration: const Duration(microseconds: 1), curve: Curves.ease);
    }
  }

  List<OnBoardingInfo> onBoardingPages = [
    OnBoardingInfo(
        "Hi, nice to meet you!",
        "Freshness Delivered to Your Door: Welcome to Sasta Store",
        '${Images.localImagesPath}${Images.on_boarding_1}'),
    OnBoardingInfo(
        "Hi, nice to meet you!",
        "Effortless Shopping, Endless Choices: Discover Sasta Store",
        '${Images.localImagesPath}${Images.on_boarding_2}'),
    OnBoardingInfo(
        "Hi, nice to meet you!",
        "The Best online store to buy products",
        '${Images.localImagesPath}${Images.on_boarding_3}'),
  ];
}
