import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:sasta_store/Helper/constants.dart';
import 'package:sasta_store/Utils/text_style.dart';
import 'package:sasta_store/Widget/custom_cache_image.dart';
import 'package:sasta_store/Widget/custom_loader.dart';

// import 'package:share_plus/share_plus.dart';

import '../../Controllers/ProductDetailController/product_detail_controller.dart';
import '../../Utils/color.dart';
import '../../Widget/component.dart';
import '../CartScreen/cart_screen.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String id;
  final String image;
  String price;
  double discount;

  DetailScreen({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.discount,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ProductDetailController productDetailController =
      Get.put(ProductDetailController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productDetailController.getProductApi(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Product Details',
              style: CustomTextStyles.l18_SEMI_BOLD_WHITE,
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined,
                    color: Colors.white)),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(200),
                    bottomLeft: Radius.circular(200))),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(200),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CustomCacheImage(url: widget.image, height: 220)),
            ),
            actions: [
              PersistentShoppingCart().showCartItemCountWidget(
                cartItemCountWidgetBuilder: (itemCount) => IconButton(
                    onPressed: () {
                      CONSTANTS.navigateToScreen(context, const CartScreen());
                    },
                    icon: Badge(
                        label: Text(itemCount.toString()),
                        child: Icon(Icons.shopping_cart_sharp,
                            color: AppColors.whiteColor))),
              ),
              // InkWell(
              //     onTap: () {
              //       // Share.share(productDetailController
              //       //         .productDetailModel.value.referalLink ??
              //       //     '');
              //     },
              //     child:
              //         const Icon(Icons.share, color: Colors.white, size: 22)),
              const SizedBox(width: 16)
            ],
            backgroundColor: AppColors.primaryColor),
        body: Obx(() {
          if (productDetailController.isLoading.value) {
            return CustomLoader();
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .036),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * .02),
                    Text(
                        productDetailController
                                .productDetailModel.value.data?.title ??
                            '',
                        style: CustomTextStyles.l18_SEMI_BOLD_MIDBLACK),
                    SizedBox(height: height * .014),
                    Text(
                        productDetailController
                                .productDetailModel.value.data?.description ??
                            '',
                        style: CustomTextStyles.l12_Medium_slateGrey),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    // widget.discount > 0
                    //     ? Wrap(
                    //         children: [
                    //           Text(
                    //             "Discount Price: ",
                    //             style:
                    //                 CustomTextStyles.l16_SemiBold_PrimaryColor,
                    //           ),
                    //           Text(
                    //             "\$${widget.discount}",
                    //             style:
                    //                 CustomTextStyles.l16_SemiBold_PrimaryColor,
                    //           ),
                    //         ],
                    //       )
                    //     : Wrap(
                    //         children: [
                    //           Text(
                    //             "Price: ",
                    //             style:
                    //                 CustomTextStyles.l16_SemiBold_PrimaryColor,
                    //           ),
                    //           Text(
                    //             "\$${widget.price}",
                    //             style:
                    //                 CustomTextStyles.l16_SemiBold_PrimaryColor,
                    //           ),
                    //         ],
                    //       ),
                    widget.discount > 0
                        ? RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        "Discount Price: ${widget.discount.toString()}",
                                    style: CustomTextStyles
                                        .l16_SemiBold_PrimaryColor),
                                TextSpan(
                                  text: "\nPrice: ${widget.price}",
                                  style: CustomTextStyles.l12_Medium_slateGrey
                                      .copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 15,
                                          height: 1.5),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            "Price: ${widget.price}",
                            style: CustomTextStyles.l12_Medium_slateGrey,
                          ),

                    // Flexible(
                    //   child: ListView.builder(
                    //       itemCount: productDetailController.productDetailModel
                    //           .value.data?.productImages?.length,
                    //       scrollDirection: Axis.horizontal,
                    //       shrinkWrap: true,
                    //       itemBuilder: (context, index) {
                    //         return CustomCacheImage(
                    //           url: productDetailController.productDetailModel
                    //               .value.data!.productImages![index],
                    //           height: 200,
                    //           width: 80,
                    //         );
                    //       }),
                    // ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CarouselSlider.builder(
                        itemCount: productDetailController.productDetailModel
                            .value.data?.productImages?.length,
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return Container(
                              width: width,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          productDetailController
                                              .productDetailModel
                                              .value
                                              .data!
                                              .productImages![index],
                                          maxHeight: 10),
                                      fit: BoxFit.fitHeight)));
                        },
                        options: CarouselOptions(
                          height: 120,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.decelerate,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal)),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Referral Link:",
                          style: CustomTextStyles.l18_SEMI_BOLD_MIDBLACK,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              productDetailController
                                  .productDetailModel.value.referalLink!,
                              style: CustomTextStyles.l16_MEDIUM_black
                                  .copyWith(fontSize: 12),
                            ),
                            InkWell(
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(
                                          text: productDetailController
                                              .productDetailModel
                                              .value
                                              .referalLink!))
                                      .then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Referral Link copied to clipboard")));
                                  });
                                },
                                child: const Icon(Icons.copy)),
                          ],
                        )
                      ],
                    ),
                    Flexible(
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: MyWidget.roundButton(
                              context,
                              productDetailController.addedToCart.value
                                  ? 'ADDED TO CART'
                                  : 'ADD TO CART',
                              color: productDetailController.addedToCart.value
                                  ? AppColors.lightGreyColor
                                  : AppColors.whiteColor, () async {
                            if (productDetailController.addedToCart.value) {
                            } else {
                              await PersistentShoppingCart().addToCart(
                                  PersistentShoppingCartItem(
                                      productId: productDetailController
                                              .productDetailModel.value.data?.id
                                              .toString() ??
                                          '',
                                      productName: productDetailController
                                              .productDetailModel
                                              .value
                                              .data
                                              ?.title ??
                                          '',
                                      unitPrice: double.tryParse(
                                          productDetailController
                                              .productDetailModel
                                              .value
                                              .data!
                                              .price
                                              .toString())!,
                                      quantity: 1,
                                      productThumbnail: productDetailController
                                          .productDetailModel
                                          .value
                                          .data!
                                          .thumbnailUrl));
                            }

                            productDetailController.addedToCart(true);
                          },
                              height: height * .076,
                              width: width * .6,
                              containerColor: AppColors.secondryColor)),
                    ),
                    SizedBox(height: height * .02),
                  ]),
            );
          }
        }));
  }
}
