// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromMap(jsonString);

import 'dart:convert';

ProductDetailModel productDetailModelFromMap(String str) =>
    ProductDetailModel.fromMap(json.decode(str));

String productDetailModelToMap(ProductDetailModel data) =>
    json.encode(data.toMap());

class ProductDetailModel {
  int? status;
  String? message;
  dynamic validationErrors;
  Data? data;
  String? referalLink;

  ProductDetailModel({
    this.status,
    this.message,
    this.validationErrors,
    this.data,
    this.referalLink,
  });

  factory ProductDetailModel.fromMap(Map<String, dynamic> json) =>
      ProductDetailModel(
        status: json["status"],
        message: json["message"],
        validationErrors: json["validation_errors"],
        data: Data.fromMap(json["data"]),
        referalLink: json["referal_link"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "validation_errors": validationErrors,
        "data": data!.toMap(),
        "referal_link": referalLink,
      };
}

class Data {
  int? id;
  int? categoryId;
  int? subcategoryId;
  String? title;
  String? description;
  String? price;
  String? discount;
  dynamic active;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isFavourite;
  List<String>? productImages;
  String? thumbnailUrl;
  dynamic thumbnail;

  Data({
    this.id,
    this.categoryId,
    this.subcategoryId,
    this.title,
    this.description,
    this.price,
    this.discount,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.isFavourite,
    this.productImages,
    this.thumbnailUrl,
    this.thumbnail,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"] ?? '',
        categoryId: json["category_id"] ?? '',
        subcategoryId: json["subcategory_id"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        price: json["price"] ?? '',
        discount: json["discount"] ?? '',
        active: json["active"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isFavourite: json["is_favourite"] ?? 0,
        productImages: List<String>.from(json["product_images"].map((x) => x)),
        thumbnailUrl: json["thumbnail_url"] ?? '',
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "title": title,
        "description": description,
        "price": price,
        "discount": discount,
        "active": active,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "is_favourite": isFavourite,
        "product_images": List<dynamic>.from(productImages!.map((x) => x)),
        "thumbnail_url": thumbnailUrl,
        "thumbnail": thumbnail,
      };
}
