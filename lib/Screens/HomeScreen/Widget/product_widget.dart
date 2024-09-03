import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Utils/text_style.dart';
import 'package:sasta_store/Widget/custom_cache_image.dart';

import '../../../Controllers/FavoriteController/favorite_controller.dart';
import '../../../Models/ProductsFilterModel/products_filter_model.dart';
import '../../../Utils/color.dart';
import '../../ProductDetail/product_detail.dart';

class ProductViewFilterWidget extends StatefulWidget {
  final FilterProducts? data;

  ProductViewFilterWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<ProductViewFilterWidget> createState() => _ProductViewFilterWidgetState();
}

class _ProductViewFilterWidgetState extends State<ProductViewFilterWidget> {
  FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        Get.to(DetailScreen(
          name: widget.data?.title ?? '',
          image: widget.data?.thumbnailUrl ?? '',
          price: widget.data?.price ?? '',
          id: widget.data?.id.toString() ?? '',
          discount: double.parse(widget.data?.discount ?? '0'),
        ));
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
          child: Column(
            children: [
              CustomCacheImage(
                url: widget.data?.thumbnailUrl ?? '',
                height: 80,
              ),
              SizedBox(height: height * .01),
              Text(
                widget.data?.title ?? '',
                maxLines: 2,
                style: CustomTextStyles.l16_MEDIUM_black,
              ),
              Text(
                widget.data?.description ?? '',
                maxLines: 2,
                style: CustomTextStyles.l12_Medium_slateGrey
                    .copyWith(overflow: TextOverflow.ellipsis),
              ),
              SizedBox(height: height * .01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.data?.price!} \$' ?? '',
                    style: CustomTextStyles.l12_Medium_slateGrey,
                  ),
                  IconButton(
                    onPressed: () {
                      if (widget.data?.isFavourite == 1) {
                        widget.data?.isFavourite = 0;
                        favoriteController.removeFavoriteApi(
                          context: context,
                          productId: widget.data!.id.toString(),
                        );
                        setState(() {});
                      } else {
                        widget.data?.isFavourite = 1;
                        favoriteController.addFavoriteApi(
                          context: context,
                          productId: widget.data!.id.toString(),
                        );
                        setState(() {});
                      }
                    },
                    icon: Icon(
                      widget.data?.isFavourite == 1
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColors.redColor,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
