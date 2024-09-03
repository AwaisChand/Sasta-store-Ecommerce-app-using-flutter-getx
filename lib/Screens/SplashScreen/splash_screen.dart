import 'package:flutter/material.dart';
import 'package:sasta_store/Screens/HomeScreen/home_screen.dart';

import '../../Helper/constants.dart';
import '../../Helper/shared_pref.dart';
import '../../Utils/images.dart';
import '../OnBoardingScreen/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (SHAREDPREF.getLoggedInStatus() == true) {
        CONSTANTS.replaceAllScreen(context, const HomeScreen());
      } else {
        Future.delayed(const Duration(seconds: 3)).then((value) {
          return CONSTANTS.replaceAllScreen(context, const OnBoardingScreen());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                '${Images.localImagesPath}${Images.splash_image}',
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
