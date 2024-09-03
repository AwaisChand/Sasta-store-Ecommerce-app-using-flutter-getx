import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Controllers/SubcategoryController/subcategory_controller.dart';
import 'package:sasta_store/Helper/constants.dart';
import 'package:sasta_store/Screens/SubcategoryScreen/product_subcategory.dart';
import 'package:sasta_store/Widget/custom_loader.dart';

import '../../Utils/color.dart';
import '../../Utils/text_style.dart';

class SubcategoryScreen extends StatefulWidget {
  final String id;
  final String category;

  const SubcategoryScreen({super.key, required this.category, required this.id});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  SubcategoryController subcategoryController =
  Get.put(SubcategoryController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      subcategoryController.getSubcategoryApi(widget.id);
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
          widget.category,
          style: CustomTextStyles.l18_SEMI_BOLD_WHITE
              .copyWith(color: AppColors.blackColor),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.blackColor,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(200),
            bottomLeft: Radius.circular(200),
          ),
        ),
      ),
      body: Obx(() {
        if (subcategoryController.isLoading.isTrue) {
          return CustomLoader();
        } else if (subcategoryController.isListNull.isTrue) {
          return const Center(child: Text('No Subcategory found'));
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .036),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * .02),
                  SizedBox(
                    height: height * .8,
                    width: width,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 200,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 6,
                      ),
                      itemCount:
                      subcategoryController.subcategoryModel.value.data?.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final subcategory = subcategoryController
                            .subcategoryModel.value.data?[index];
                        return InkWell(
                          onTap: () {
                            CONSTANTS.navigateToScreen(
                              context,
                              SubcategoryProduct(
                                subcategory: subcategory?.name ?? '',
                                id: subcategory?.id.toString() ?? '',
                              ),
                            );
                          },
                          child: Container(
                            height: height * .09,
                            width: width * .2,
                            margin: const EdgeInsets.only(left: 12, bottom: 6),
                            decoration: BoxDecoration(
                              color: AppColors.lightWhiteColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  blurStyle: BlurStyle.outer,
                                  color: AppColors.greyColor,
                                  spreadRadius: 0,
                                  blurRadius: 1,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: subcategory?.imageUrl ?? '',
                                    height: 100,
                                    placeholder: (context, url) => CustomLoader(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fadeInDuration: const Duration(milliseconds: 500),
                                    cacheKey: subcategory?.imageUrl,
                                  ),
                                  Text(
                                    subcategory?.name ?? '',
                                    style: CustomTextStyles.l12_Medium_PrimaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: height * .01),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
