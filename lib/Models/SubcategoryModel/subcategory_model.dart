// To parse this JSON data, do
//
//     final subcategoryModel = subcategoryModelFromMap(jsonString);

import 'dart:convert';

SubcategoryModel subcategoryModelFromMap(String str) =>
    SubcategoryModel.fromMap(json.decode(str));

String subcategoryModelToMap(SubcategoryModel data) =>
    json.encode(data.toMap());

class SubcategoryModel {
  int? status;
  String? message;
  dynamic validationErrors;
  List<Datum>? data;

  SubcategoryModel({
    this.status,
    this.message,
    this.validationErrors,
    this.data,
  });

  factory SubcategoryModel.fromMap(Map<String, dynamic> json) =>
      SubcategoryModel(
        status: json["status"],
        message: json["message"],
        validationErrors: json["validation_errors"],
        data: json["data"] == []
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "validation_errors": validationErrors,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  int? id;
  int? categoryId;
  String? name;
  int? active;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;

  Datum({
    this.id,
    this.categoryId,
    this.name,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"] ?? '',
        active: json["active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "active": active,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "image_url": imageUrl,
      };
}
