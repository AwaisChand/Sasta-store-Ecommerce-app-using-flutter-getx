import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Controllers/ProfileController/profile_controller.dart';
import 'package:sasta_store/Helper/constants.dart';
import 'package:sasta_store/Helper/shared_pref.dart';
import 'package:sasta_store/Screens/Authentication/LoginScreen/login_screen.dart';
import 'package:sasta_store/Screens/BalanceHistoryScreen/balance_history_screen.dart';
import 'package:sasta_store/Screens/Order/order_history.dart';
import 'package:sasta_store/Utils/text_style.dart';
import 'package:sasta_store/menu/custom_bottom_navigation.dart';

import '../../Utils/color.dart';
import '../../Widget/component.dart';
import '../../Widget/custom_loader.dart';
import '../EditProfileScreen/edit_profile_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getProfileApi();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Profile'),
        ),
        bottomNavigationBar: CustomBottomNavBar(currentIndex: 4),
        body: Obx(() {
          if (profileController.isLoading.isTrue) {
            return CustomLoader();
          } else if (profileController.isListNull.isTrue) {
            return const Center(child: Text('No Profile found'));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CachedNetworkImageProvider(
                          profileController
                                  .profileModel.value.data?.profileImageUrl ??
                              ''),
                    ),
                  ),
                  SizedBox(height: height * .01),
                  Center(
                      child: MyWidget.roundButton(
                    context,
                    'Edit Profile',
                    () {
                      Get.to(EditProfileScreen(
                        image: profileController
                                .profileModel.value.data?.profileImageUrl ??
                            '',
                        name: profileController.profileModel.value.data?.name ??
                            '',
                        phone:
                            profileController.profileModel.value.data?.phone ??
                                '',
                        email:
                            profileController.profileModel.value.data?.email ??
                                '',
                      ))!
                          .then((value) {
                        profileController.profileModel.refresh();
                      });
                    },
                    height: height * .04,
                    width: width * .4,
                    containerColor: AppColors.lightOrangeColor,
                  )),
                  SizedBox(height: height * .03),
                  rowWidget(width, 'Name:',
                      profileController.profileModel.value.data?.name ?? ''),
                  SizedBox(height: height * .02),
                  rowWidget(width, 'Email:',
                      profileController.profileModel.value.data?.email ?? ''),
                  SizedBox(height: height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      rowWidget(
                          width,
                          'Balance:',
                          profileController.profileModel.value.data?.balance
                                  .toString() ??
                              ''),
                      InkWell(
                          onTap: () {
                            Get.to(() => const BalanceHistoryScreen());
                          },
                          child: Text(
                            "History",
                            style: CustomTextStyles.l16_MEDIUM_black.copyWith(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.w500),
                          ))
                    ],
                  ),
                  SizedBox(height: height * .02),
                  rowWidget(width, 'Phone:',
                      profileController.profileModel.value.data?.phone ?? ''),
                  SizedBox(height: height * .02),
                  Row(
                    children: [
                      Text('Reference Code:',
                          style: CustomTextStyles.l16_MEDIUM_black),
                      SizedBox(width: width * 0.03),
                      Text(
                          profileController.profileModel.value.data
                                  ?.personal_referral_code ??
                              '',
                          style: CustomTextStyles.l16_MEDIUM_black),
                      SizedBox(width: width * 0.03),
                      InkWell(
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(
                                    text: profileController.profileModel.value
                                        .data?.personal_referral_code))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Reference code copied to clipboard")));
                            });
                          },
                          child: const Icon(Icons.copy)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                      child: MyWidget.roundButton(
                    context,
                    'Order History',
                    () {
                      CONSTANTS.navigateToScreen(context, OrderHistoryScreen());
                    },
                    height: height * .05,
                    width: width * .6,
                    containerColor: AppColors.lightOrangeColor,
                  )),
                  const SizedBox(height: 20),
                  Center(
                      child: MyWidget.roundButton(
                    context,
                    'Logout',
                    () {
                      SHAREDPREF.setLoggedInStatus(false);
                      CONSTANTS.replaceAllScreen(context, const LoginScreen());
                    },
                    height: height * .05,
                    width: width * .6,
                    containerColor: AppColors.lightOrangeColor,
                  )),
                ],
              ),
            );
          }
        }));
  }

  Widget rowWidget(double width, String title, String subtitle) {
    return Row(
      children: [
        Text(
          title,
          style: CustomTextStyles.l16_MEDIUM_black,
        ),
        SizedBox(width: width * 0.03),
        Text(subtitle, style: CustomTextStyles.l16_MEDIUM_black),
      ],
    );
  }
}
