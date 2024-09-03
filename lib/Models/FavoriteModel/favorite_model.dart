// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromMap(jsonString);

import 'dart:convert';

FavoriteModel favoriteModelFromMap(String str) =>
    FavoriteModel.fromMap(json.decode(str));

String favoriteModelToMap(FavoriteModel data) => json.encode(data.toMap());

class FavoriteModel {
  int? status;
  String? message;
  dynamic validationErrors;
  List<DatumFav>? data;

  FavoriteModel({
    this.status,
    this.message,
    this.validationErrors,
    this.data,
  });

  factory FavoriteModel.fromMap(Map<String, dynamic> json) => FavoriteModel(
        status: json["status"],
        message: json["message"],
        validationErrors: json["validation_errors"],
        data: List<DatumFav>.from(json["data"].map((x) => DatumFav.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "validation_errors": validationErrors,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class DatumFav {
  int? id;
  int? categoryId;
  int? subcategoryId;
  String? title;
  String? description;
  String? price;
  String? discount;
  int? active;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isFavourite;
  String? thumbnailUrl;
  dynamic thumbnail;

  DatumFav({
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
    this.thumbnailUrl,
    this.thumbnail,
  });

  factory DatumFav.fromMap(Map<String, dynamic> json) => DatumFav(
        id: json["id"],
        categoryId: json["category_id"],
        subcategoryId: json["subcategory_id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        discount: json["discount"],
        active: json["active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isFavourite: json["is_favourite"],
        thumbnailUrl: json["thumbnail_url"],
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
        "thumbnail_url": thumbnailUrl,
        "thumbnail": thumbnail,
      };
}
