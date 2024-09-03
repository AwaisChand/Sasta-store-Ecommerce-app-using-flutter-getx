// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Utils/images.dart';
import 'custom_progress_indicator.dart';

class CustomCacheImage extends StatelessWidget {
  final String url;
  final double height;
  double? width;

  final String? name;
  bool? circular = false;

  CustomCacheImage({
    Key? key,
    required this.url,
    required this.height,
    this.name,
    this.circular,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width ?? 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)
        ),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const Image(
              image: AssetImage(
                  Images.localImagesPath + Images.default_profile_image)),
          imageBuilder: (context, imageProvider) => Image(
            image: imageProvider,
          ),
          placeholder: (context, url) {
            return Container(
                height: height,
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: customProgressIndicator());
          },
        ));
  }
}
