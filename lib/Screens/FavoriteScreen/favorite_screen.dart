import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Controllers/FavoriteController/favorite_controller.dart';
import 'package:sasta_store/Widget/custom_loader.dart';

import '../../Utils/color.dart';
import '../../Utils/text_style.dart';
import '../../Widget/custom_cache_image.dart';
import '../../menu/custom_bottom_navigation.dart';
import '../ProductDetail/product_detail.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  FavoriteController favoriteController = Get.put(FavoriteController());


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text('Favourites')),
        bottomNavigationBar: CustomBottomNavBar(currentIndex: 2),
        body: Obx(() {
          if (favoriteController.isLoading.value) {
            return CustomLoader();
          } else if (favoriteController.isListNull.value) {
            return const Center(child: Text('No Product Found'));
          } else {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .03),
                child: SingleChildScrollView(
                    child: Column(children: [
                  SizedBox(height: height * .01),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          favoriteController.favoriteModel.value.data?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 250,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 6),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(DetailScreen(
                              id: favoriteController
                                      .favoriteModel.value.data?[index].id
                                      .toString() ??
                                  '',
                              name: favoriteController
                                      .favoriteModel.value.data?[index].title ??
                                  '',
                              image: favoriteController.favoriteModel.value
                                      .data?[index].thumbnailUrl ??
                                  '',
                              price: favoriteController
                                      .favoriteModel.value.data?[index].price ??
                                  '',
                              discount: double.parse(favoriteController
                                      .favoriteModel
                                      .value
                                      .data?[index]
                                      .discount ??
                                  ""),
                            )
                            );
                          },
                          child: Container(
                              margin: const EdgeInsets.only(left: 2, right: 2),
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    blurStyle: BlurStyle.outer,
                                    color: AppColors.greyColor,
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    CustomCacheImage(
                                        url: favoriteController
                                                .favoriteModel
                                                .value
                                                .data?[index]
                                                .thumbnailUrl ??
                                            '',
                                        height: 80),
                                    SizedBox(height: height * .01),
                                    Text(
                                      favoriteController.favoriteModel.value
                                              .data?[index].title ??
                                          '',
                                      maxLines: 2,
                                      style: CustomTextStyles.l16_MEDIUM_black,
                                    ),
                                    Text(
                                      favoriteController.favoriteModel.value
                                              .data?[index].description ??
                                          '',
                                      maxLines: 2,
                                      style: CustomTextStyles
                                          .l12_Medium_slateGrey
                                          .copyWith(
                                              overflow: TextOverflow.ellipsis),
                                    ),
                                    SizedBox(height: height * .01),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${favoriteController.favoriteModel.value.data?[index].price!} \$' ??
                                                '',
                                            style: CustomTextStyles
                                                .l12_Medium_slateGrey,
                                          ),
                                          // IconButton(
                                          //   onPressed: () {
                                          //
                                          //     if (
                                          //     favoriteController
                                          //             .favoriteModel
                                          //             .value
                                          //             .data?[index]
                                          //             .isFavourite ==
                                          //         1) {
                                          //       favoriteController
                                          //           .favoriteModel
                                          //           .value
                                          //           .data?[index]
                                          //           .isFavourite = 0;
                                          //       favoriteController
                                          //           .removeFavoriteApi(
                                          //               context: context,
                                          //               productId:
                                          //                   favoriteController
                                          //                           .favoriteModel
                                          //                           .value
                                          //                           .data?[
                                          //                               index]
                                          //                           .id
                                          //                           .toString() ??
                                          //                       '');
                                          //       print('remove item');
                                          //     } else {
                                          //       favoriteController
                                          //           .favoriteModel
                                          //           .value
                                          //           .data?[index]
                                          //           .isFavourite = 1;
                                          //
                                          //       favoriteController.addFavoriteApi(
                                          //           context: context,
                                          //           productId:
                                          //               favoriteController
                                          //                       .favoriteModel
                                          //                       .value
                                          //                       .data?[index]
                                          //                       .id
                                          //                       .toString() ??
                                          //                   '');
                                          //       print('add item');
                                          //
                                          //     }
                                          //   },
                                          //   icon: Icon(
                                          //     favoriteController
                                          //                 .favoriteModel
                                          //                 .value
                                          //                 .data?[index]
                                          //                 .isFavourite ==
                                          //             1
                                          //         ? Icons.favorite
                                          //         : Icons.favorite_border,
                                          //     color: AppColors.redColor,
                                          //   ),
                                          // )
                                          IconButton(
                                            onPressed: () {
                                              if (favoriteController
                                                      .favoriteModel
                                                      .value
                                                      .data?[index]
                                                      .isFavourite ==
                                                  1) {
                                                favoriteController
                                                    .removeFromFavorite(index);
                                                setState(() {
                                                  favoriteController
                                                      .favoriteModel
                                                      .value
                                                      .data?[index]
                                                      .isFavourite ==0;
                                                });
                                              } else {
                                                favoriteController
                                                    .addToFavorite(index);
                                                setState(() {

                                                });
                                              }
                                            },
                                            icon: Icon(
                                              favoriteController
                                                          .favoriteModel
                                                          .value
                                                          .data?[index]
                                                          .isFavourite ==
                                                      1
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: AppColors.redColor,
                                            ),
                                          )
                                        ])
                                  ]))),
                        );
                      })
                ])));
          }
        }));
  }
}
