// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromMap(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromMap(String str) =>
    CategoryModel.fromMap(json.decode(str));

String categoryModelToMap(CategoryModel data) => json.encode(data.toMap());

class CategoryModel {
  int? status;
  String? message;
  dynamic validationErrors;
  List<CategoryData>? data;

  CategoryModel({
    this.status,
    this.message,
    this.validationErrors,
    this.data,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        status: json["status"],
        message: json["message"],
        validationErrors: json["validation_errors"],
        data: json["data"] == []
            ? []
            : List<CategoryData>.from(json["data"].map((x) => CategoryData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "validation_errors": validationErrors,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class CategoryData {
  int? id;
  String? name;
  int? active;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;

  CategoryData({
    this.id,
    this.name,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory CategoryData.fromMap(Map<String, dynamic> json) => CategoryData(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        active: json["active"] ?? 1,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "active": active,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "image_url": imageUrl,
      };
}
