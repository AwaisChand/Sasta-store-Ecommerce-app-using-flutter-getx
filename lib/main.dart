import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

import 'Helper/shared_pref.dart';
import 'Screens/SplashScreen/splash_screen.dart';
import 'Utils/color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SHAREDPREF().init();
  await PersistentShoppingCart().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sasta Store',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        dialogBackgroundColor: AppColors.whiteColor,
        useMaterial3: true,
        primaryColor: AppColors.whiteColor,
      ),
      home:  SplashScreen(),
    );
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';

  String get allInCaps => toUpperCase();

  String get capitalizeFirstofEach =>
      split(" ").map((str) => str.capitalize).join(" ");

  String get capitalizeEach =>
      split(" ").map((str) => str.capitalize).join(" ");
}
