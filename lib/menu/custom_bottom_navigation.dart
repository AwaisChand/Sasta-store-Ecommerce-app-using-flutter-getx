import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:sasta_store/Screens/ChatScreen/chat_screen.dart';

import '../Helper/constants.dart';
import '../Screens/AccountScreen/account_screen.dart';
import '../Screens/CartScreen/cart_screen.dart';
import '../Screens/FavoriteScreen/favorite_screen.dart';
import '../Screens/HomeScreen/home_screen.dart';
import '../Utils/color.dart';
import '../Utils/text_style.dart';

class CustomBottomNavBar extends StatefulWidget {
  var currentIndex = 0;

  CustomBottomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      color: AppColors.whiteColor,
      child: SafeArea(
        bottom: true,
        child: Container(
            width: width,
            height: height < 630 ? height * 0.14 : 75,
            padding: const EdgeInsets.only(bottom: 10),
            color: AppColors.whiteColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          rout(const HomeScreen());
                        },
                        icon: Icon(
                          Icons.home,
                          color: widget.currentIndex == 0
                              ? AppColors.secondryColor
                              : AppColors.midBlack,
                        )),
                    // SvgPicture.asset(
                    //     '${Images.localIconsPath}${widget.currentIndex == 0 ? Images.homeActive : Images.homeInactive}')),
                    Text(
                      'Home',
                      style: widget.currentIndex == 0
                          ? CustomTextStyles.l12_Medium_PrimaryColor
                          : CustomTextStyles.l12_Medium_slateGrey,
                    ),
                  ],
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // PersistentShoppingCart().showCartItemCountWidget(
                    //   cartItemCountWidgetBuilder: (itemCount) => IconButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(builder: (context) => const CartView()),
                    //       );
                    //     },
                    //     icon: Badge(
                    //       label:Text(itemCount.toString()) ,
                    //       child: const Icon(Icons.shopping_bag_outlined),
                    //     ),
                    //   ),
                    // ),
                    PersistentShoppingCart().showCartItemCountWidget(
                      cartItemCountWidgetBuilder: (itemCount) => IconButton(
                        onPressed: () {
                          rout(const CartScreen());
                        },
                        icon: Badge(
                          label: Text(itemCount.toString()),
                          child: Icon(
                            Icons.shopping_cart_sharp,
                            color: widget.currentIndex == 1
                                ? AppColors.secondryColor
                                : AppColors.midBlack,
                          ),
                        ),
                      ),
                    ),

                    // SvgPicture.asset(
                    //     '${Images.localIconsPath}${widget.currentIndex == 1 ? Images.searchActive : Images.searchInactive}')),
                    Text(
                      'Cart',
                      style: widget.currentIndex == 1
                          ? CustomTextStyles.l12_Medium_PrimaryColor
                          : CustomTextStyles.l12_Medium_slateGrey,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          rout(const FavouriteScreen());
                        },
                        icon: Icon(
                          Icons.favorite_border,
                          color: widget.currentIndex == 2
                              ? AppColors.secondryColor
                              : AppColors.midBlack,
                        )),
                    // SvgPicture.asset(
                    //     '${Images.localIconsPath}${widget.currentIndex == 2 ? Images.chatActive : Images.chatInActive}')),
                    Text(
                      'Favourite',
                      style: widget.currentIndex == 2
                          ? CustomTextStyles.l12_Medium_PrimaryColor
                          : CustomTextStyles.l12_Medium_slateGrey,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          rout(const ChatScreen());
                        },
                        icon: Icon(
                          Icons.chat,
                          color: widget.currentIndex == 3
                              ? AppColors.secondryColor
                              : AppColors.midBlack,
                        )),
                    // SvgPicture.asset(
                    //     '${Images.localIconsPath}${widget.currentIndex == 2 ? Images.chatActive : Images.chatInActive}')),
                    Text(
                      'Chat',
                      style: widget.currentIndex == 3
                          ? CustomTextStyles.l12_Medium_PrimaryColor
                          : CustomTextStyles.l12_Medium_slateGrey,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          rout(AccountScreen());
                        },
                        icon: Icon(
                          Icons.account_circle,
                          color: widget.currentIndex == 4
                              ? AppColors.secondryColor
                              : AppColors.midBlack,
                        )),
                    // SvgPicture.asset(
                    //     '${Images.localIconsPath}${widget.currentIndex == 3 ? Images.dashboardActive : Images.dashboardInActive}')),
                    Text(
                      'Account',
                      style: widget.currentIndex == 4
                          ? CustomTextStyles.l12_Medium_PrimaryColor
                          : CustomTextStyles.l12_Medium_slateGrey,
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  rout(screen) {
    CONSTANTS.navigateToScreen(context, screen);
  }
}
