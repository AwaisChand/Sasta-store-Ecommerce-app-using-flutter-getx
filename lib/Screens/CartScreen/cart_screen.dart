import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:sasta_store/Helper/constants.dart';
import 'package:sasta_store/Screens/CheckoutScreen/checkout_screen.dart';
import 'package:sasta_store/Utils/text_style.dart';
import 'package:sasta_store/Widget/custom_cache_image.dart';
import 'package:sasta_store/menu/custom_bottom_navigation.dart';

import '../../Models/CheckoutModel/checkout_model.dart';
import '../../Utils/color.dart';
import '../../Widget/component.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int totalItems = 0;
  double deliveryCharges = 5.0;
  double subTotal = 0.0;
  List<PersistentShoppingCartItem>? cartItems;
  List<CheckOutModel> checkout = [];

  @override
  void initState() {
    Map<String, dynamic> cartData = PersistentShoppingCart().getCartData();
    cartItems = cartData['cartItems'];
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
        title: const Text('My Cart'),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
      body: cartItems?.length == 0
          ? const Center(child: Text('No Product found'))
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: height * .02),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * .02),
                      ListView.builder(
                          itemCount: cartItems?.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return MyWidget.container(
                                height * .14, width, AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                margin: const EdgeInsets.only(bottom: 10),
                                boxShadow: const BoxShadow(
                                  color: AppColors.greyColor,
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        MyWidget.container(
                                            height * .12,
                                            width * .2,
                                            AppColors.transparentColor,
                                            child: CustomCacheImage(
                                                url: cartItems?[index]
                                                        .productThumbnail ??
                                                    '',
                                                height: 50)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: SizedBox(
                                            height: height * .12,
                                            width: width * .6,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: width * 0.4,
                                                      child: Text(
                                                        cartItems?[index]
                                                                .productName ??
                                                            '',
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () async {
                                                        await PersistentShoppingCart()
                                                            .incrementCartItemQuantity(
                                                                cartItems?[index]
                                                                        .productId
                                                                        .toString() ??
                                                                    '');

                                                        setState(() {});
                                                      },
                                                      icon: Icon(Icons.add,
                                                          color: AppColors
                                                              .redColor),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('${cartItems?[index]
                                                                .unitPrice}\$' ??
                                                        ''),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: width * .05),
                                                      child: Text(
                                                          cartItems?[index]
                                                                  .quantity
                                                                  .toString() ??
                                                              ''),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: height * .03,
                                                      width: width * .1,
                                                      child: const Center(
                                                        child: Text(''),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: width * .03),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          print(
                                                              '000---${cartItems?[index].quantity}');
                                                          print(cartItems
                                                              ?.length);
                                                          if ((cartItems?[index]
                                                                          .quantity
                                                                          .toString() ==
                                                                      '1' ||
                                                                  cartItems?[index]
                                                                          .quantity
                                                                          .toString() ==
                                                                      1) &&
                                                              cartItems
                                                                      ?.length ==
                                                                  1) {
                                                            print('999');
                                                            cartItems?.removeAt(
                                                                index);
                                                            PersistentShoppingCart()
                                                                .clearCart();

                                                            setState(() {});
                                                          } else if (cartItems?[
                                                                          index]
                                                                      .quantity
                                                                      .toString() ==
                                                                  '1' ||
                                                              cartItems?[index]
                                                                      .quantity
                                                                      .toString() ==
                                                                  1) {
                                                            print('22');
                                                            await PersistentShoppingCart()
                                                                .removeFromCart(
                                                                    cartItems?[index]
                                                                            .productId ??
                                                                        '');
                                                            cartItems?.removeAt(
                                                                index);
                                                            setState(() {});
                                                          } else {
                                                            await PersistentShoppingCart()
                                                                .decrementCartItemQuantity(
                                                                    cartItems?[index]
                                                                            .productId ??
                                                                        '');
                                                            setState(() {});
                                                          }
                                                        },
                                                        child: Icon(
                                                            Icons.minimize,
                                                            color: AppColors
                                                                .redColor),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )));
                          }),
                      SizedBox(height: height * 0.02),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Items',
                              style: CustomTextStyles.l16_MEDIUM_textgrey,
                            ),
                            Text(cartItems?.length.toString() ?? '',
                                style: CustomTextStyles.l12_Medium_slateGrey),
                          ]),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'Delivery Charges:',
                      //       style: CustomTextStyles.l16_MEDIUM_textgrey,
                      //     ),
                      //     Text(
                      //       '\$5.0',
                      //       style: CustomTextStyles.l12_Medium_slateGrey,
                      //     ),
                      //     // MyText.mediumTextWidget('Delivery Charges:',
                      //     //     color: AppColors.greyColor),
                      //     // MyText.smallTextWidget('\$5.0', color: AppColors.greyColor),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SubTotal:',
                            style: CustomTextStyles.l16_MEDIUM_textgrey,
                          ),
                          PersistentShoppingCart().showTotalAmountWidget(
                            cartTotalAmountWidgetBuilder: (double totalAmount) {
                              return Text(
                                '$totalAmount\$',
                                style: CustomTextStyles.l12_Medium_slateGrey,
                              );
                            },
                          ),

                          // MyText.mediumTextWidget('SubTotal:',
                          //     color: AppColors.greyColor),
                          // MyText.smallTextWidget('60.7', color: AppColors.greyColor),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: CustomTextStyles.l16_MEDIUM_textgrey,
                          ),
                          PersistentShoppingCart().showTotalAmountWidget(
                            cartTotalAmountWidgetBuilder: (double totalAmount) {
                              return Text(
                                '$totalAmount\$',
                                style: CustomTextStyles.l12_Medium_slateGrey,
                              );
                            },
                          ),

                          // MyText.mediumTextWidget('SubTotal:',
                          //     color: AppColors.greyColor),
                          // MyText.smallTextWidget('60.7', color: AppColors.greyColor),
                        ],
                      ),
                      SizedBox(
                        height: height * .04,
                      ),
                      Center(
                          child: MyWidget.roundButton(context, 'Checkout', () {
                        CONSTANTS.navigateToScreen(
                            context,
                            CheckOutScreen(
                              itemCount: cartItems?.length.toString() ?? '',
                            ));
                        // showModalBottomSheet(
                        //     context: context,
                        //     builder: (context) {
                        //       return MyWidget.container(height * .3, width,
                        //           AppColors.transparentColor,
                        //           borderRadius: const BorderRadius.only(
                        //               topRight: Radius.circular(40),
                        //               topLeft: Radius.circular(40)),
                        //           child: Padding(
                        //             padding: const EdgeInsets.only(top: 20),
                        //             child: Column(
                        //               children: [
                        //                 const Text('Select Payment Method!'),
                        //                 SizedBox(height: height * .02),
                        //                 // MyWidget.container(
                        //                 //   height * .06,
                        //                 //   width * .7,
                        //                 //   AppColors.primaryColor,
                        //                 //   onTap: () {},
                        //                 //   borderRadius: BorderRadius.circular(40),
                        //                 //   child: Row(
                        //                 //     mainAxisAlignment:
                        //                 //         MainAxisAlignment.spaceEvenly,
                        //                 //     children: [
                        //                 //       Icon(
                        //                 //         Icons.credit_card,
                        //                 //         color: AppColors.whiteColor,
                        //                 //       ),
                        //                 //       Text('Credit Card/Debit Card',
                        //                 //           style: CustomTextStyles
                        //                 //               .l16_MEDIUM_black
                        //                 //               .copyWith(
                        //                 //                   color:
                        //                 //                       AppColors.whiteColor)),
                        //                 //       Icon(
                        //                 //         Icons.arrow_forward_ios,
                        //                 //         color: AppColors.whiteColor,
                        //                 //       )
                        //                 //     ],
                        //                 //   ),
                        //                 // ),
                        //                 // SizedBox(height: height * .02),
                        //                 MyWidget.container(
                        //                     height * .06,
                        //                     width * .7,
                        //                     AppColors.primaryColor, onTap: () {
                        //                   print('0000');
                        //                   const CustomToast(
                        //                       msg: 'Order Placed Successfully');
                        //                 },
                        //                     borderRadius:
                        //                         BorderRadius.circular(40),
                        //                     child: Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment.spaceEvenly,
                        //                       children: [
                        //                         Icon(
                        //                           Icons.credit_card,
                        //                           color: AppColors.whiteColor,
                        //                         ),
                        //                         Text('Cash on delivery',
                        //                             style: CustomTextStyles
                        //                                 .l16_MEDIUM_black
                        //                                 .copyWith(
                        //                                     color: AppColors
                        //                                         .whiteColor)),
                        //                         Icon(
                        //                           Icons.arrow_forward_ios,
                        //                           color: AppColors.whiteColor,
                        //                         )
                        //                       ],
                        //                     )),
                        //               ],
                        //             ),
                        //           ));
                        //     });
                      },
                              color: AppColors.whiteColor,
                              containerColor: AppColors.secondryColor,
                              height: height * .06,
                              width: width * .6)),
                      SizedBox(height: height * .14),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
