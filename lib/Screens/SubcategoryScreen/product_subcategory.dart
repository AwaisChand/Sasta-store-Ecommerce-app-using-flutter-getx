import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Screens/HomeScreen/Widget/product_view_widget.dart';

import '../../Controllers/ProductController/product_controller.dart';
import '../../Utils/color.dart';
import '../../Widget/custom_loader.dart';
import '../HomeScreen/Widget/product_widget.dart';

class SubcategoryProduct extends StatefulWidget {
  final String subcategory;
  final String? id;

  const SubcategoryProduct(
      {super.key, required this.subcategory, required this.id});

  @override
  State<SubcategoryProduct> createState() => _SubcategoryProductState();
}

class _SubcategoryProductState extends State<SubcategoryProduct> {
  ProductController productController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.getProductApi(false, widget.id.toString());
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
          title: Text(widget.subcategory),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: AppColors.blackColor,
            ),
          ),
        ),
        body: Obx(() {
          if (productController.isLoading.isTrue) {
            return CustomLoader();
          } else if (productController.isListNull.isTrue) {
            return const Center(child: Text('No Subcategory found'));
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .03),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * .01,
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: productController
                            .productModel.value.data?.data?.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 250,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 6),
                        itemBuilder: (context, index) {
                          return ProductViewWidget(
                            data: productController
                                .productModel.value.data!.data![index],
                          );
                        }),
                    const SizedBox(height: 30)
                  ],
                ),
              ),
            );
          }
        }));
  }
}
