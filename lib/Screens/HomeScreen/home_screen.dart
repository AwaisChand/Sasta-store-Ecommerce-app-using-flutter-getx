import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Controllers/CategoryController/category_controller.dart';
import 'package:sasta_store/Controllers/ProductController/product_controller.dart';
import 'package:sasta_store/Controllers/SliderController/slider_controller.dart';
import 'package:sasta_store/Helper/constants.dart';
import 'package:sasta_store/Screens/HomeScreen/Widget/product_view_widget.dart';
import 'package:sasta_store/Utils/text_style.dart';
import 'package:sasta_store/Widget/custom_cache_image.dart';
import 'package:sasta_store/Widget/custom_loader.dart';
import 'package:sasta_store/Widget/custom_text_field.dart';

import '../../Utils/color.dart';
import '../../menu/custom_bottom_navigation.dart';
import '../SubcategoryScreen/subcategory_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryController categoryController = Get.put(CategoryController());
  ProductController productController = Get.put(ProductController());
  SliderController sliderController = Get.put(SliderController());
  TextEditingController searchController = TextEditingController();
  bool isSearch = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoryController.getCategoryApi();
      sliderController.getSliderApi();
      productController.getProductApi(true, '0');
    });
    super.initState();
  }

  Timer? _debounceTimer;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
        resizeToAvoidBottomInset: false,
        body: Obx(() {
          if (categoryController.isLoading.isTrue ||
              productController.isLoading.isTrue ||
              sliderController.isLoading.isTrue) {
            return CustomLoader();
          } else {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .036),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .02),
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.08,
                              ),
                              CustomTextField(
                                controller: searchController,
                                validation: (val) {
                                  return;
                                },
                                onChanged: (_) {
                                  if (_debounceTimer != null) {
                                    _debounceTimer!.cancel();
                                  }
                                  _debounceTimer =
                                      Timer(const Duration(seconds: 1), () {
                                    if (searchController.text.isEmpty) {
                                      productController.getProductApi(
                                          true, '0');
                                    } else {
                                      productController.getProductsSearchApi(
                                          searchController.text);
                                    }
                                  });
                                  return;
                                },
                                isPass: false,
                                passwordvisibility: false,
                                maxLines: 1,
                                hint: "Search Products...",
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              CarouselSlider.builder(
                                  itemCount: sliderController
                                      .sliderModel.value.data?.length,
                                  itemBuilder: (BuildContext context, int index,
                                      int realIndex) {
                                    return Container(
                                        height: height * .24,
                                        width: width,
                                        decoration: BoxDecoration(
                                            color: AppColors.blueColor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                        sliderController
                                                                .sliderModel
                                                                .value
                                                                .data?[index]
                                                                .imageUrl ??
                                                            ''),
                                                fit: BoxFit.cover)));
                                  },
                                  options: CarouselOptions(
                                      height: 120,
                                      enableInfiniteScroll: true,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 5),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.decelerate,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal)),
                              SizedBox(height: height * .02),
                              SizedBox(
                                  height: height * .14,
                                  width: width,
                                  child: ListView.builder(
                                      itemCount: categoryController
                                          .categoryModel.value.data?.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                            onTap: () {
                                              CONSTANTS.navigateToScreen(
                                                  context,
                                                  SubcategoryScreen(
                                                    category: categoryController
                                                        .categoryModel
                                                        .value
                                                        .data![index]
                                                        .name!,
                                                    id: categoryController
                                                        .categoryModel
                                                        .value
                                                        .data![index]
                                                        .id
                                                        .toString(),
                                                  ));
                                            },
                                            child: Container(
                                                height: height * .09,
                                                width: width * .2,
                                                margin: const EdgeInsets.only(
                                                    left: 12, bottom: 6),
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .lightWhiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          blurStyle:
                                                              BlurStyle.outer,
                                                          color: AppColors
                                                              .greyColor,
                                                          spreadRadius: 0,
                                                          blurRadius: 1,
                                                          offset: Offset(0, 3))
                                                    ]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child: CustomCacheImage(
                                                              url: categoryController
                                                                  .categoryModel
                                                                  .value
                                                                  .data![index]
                                                                  .imageUrl!,
                                                              height: 45),
                                                        ),
                                                        Text(
                                                            categoryController
                                                                .categoryModel
                                                                .value
                                                                .data![index]
                                                                .name!,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: CustomTextStyles
                                                                .l12_Medium_PrimaryColor)
                                                      ]),
                                                )));
                                      })),
                              SizedBox(height: height * .02),
                              GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: productController
                                      .productModel.value.data?.data?.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: 235,
                                          mainAxisSpacing: 20,
                                          crossAxisSpacing: 12),
                                  itemBuilder: (context, index) {
                                    return ProductViewWidget(
                                        data: productController.productModel
                                            .value.data?.data?[index]);
                                  }),
                              const SizedBox(height: 30),
                            ]))));
          }
        }));
  }
}
