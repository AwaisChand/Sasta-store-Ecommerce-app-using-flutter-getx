// To parse this JSON data, do
//
//     final productModel = productModelFromMap(jsonString);

import 'dart:convert';

ProductModel productModelFromMap(String str) =>
    ProductModel.fromMap(json.decode(str));

String productModelToMap(ProductModel data) => json.encode(data.toMap());

class ProductModel {
  int? status;
  String? message;
  dynamic validationErrors;
  Data? data;

  ProductModel({
    this.status,
    this.message,
    this.validationErrors,
    this.data,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
      status: json["status"],
      message: json["message"],
      validationErrors: json["validation_errors"],
      data: Data.fromMap(json["data"]));

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "validation_errors": validationErrors,
        "data": data!.toMap(),
      };
}

class Data {
  int? currentPage;
  List<ProductData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<ProductData>.from(json["data"].map((x) => ProductData.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links!.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class ProductData {
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

  ProductData({
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

  factory ProductData.fromMap(Map<String, dynamic> json) => ProductData(
        id: json["id"],
        categoryId: json["category_id"],
        subcategoryId: json["subcategory_id"],
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        price: json["price"] ?? '',
        discount: json["discount"],
        active: json["active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isFavourite: json["is_favourite"] ?? 1,
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
        "thumbnail_url": thumbnailUrl,
        "thumbnail": thumbnail,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromMap(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
