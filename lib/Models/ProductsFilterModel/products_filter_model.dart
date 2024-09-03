// To parse this JSON data, do
//
//     final productsFilterModel = productsFilterModelFromJson(jsonString);

import 'dart:convert';

ProductsFilterModel productsFilterModelFromMap(String str) =>
    ProductsFilterModel.fromMap(json.decode(str));

String productsFilterModelToMap(ProductsFilterModel data) =>
    json.encode(data.toJson());

class ProductsFilterModel {
  int? status;
  String? message;
  dynamic validationErrors;
  Data? data;

  ProductsFilterModel({
    this.status,
    this.message,
    this.validationErrors,
    this.data,
  });

  factory ProductsFilterModel.fromMap(Map<String, dynamic> json) =>
      ProductsFilterModel(
        status: json["status"],
        message: json["message"],
        validationErrors: json["validation_errors"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "validation_errors": validationErrors,
        "data": data?.toMap(),
      };
}

class Data {
  int? currentPage;
  List<FilterProducts>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
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
        data: List<FilterProducts>.from(
            json["data"].map((x) => FilterProducts.fromMap(x))),
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

class FilterProducts {
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
  int? avgRating;
  int? totalReviews;
  int? isFavourite;
  String? thumbnailUrl;
  Thumbnail? thumbnail;

  FilterProducts({
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
    this.avgRating,
    this.totalReviews,
    this.isFavourite,
    this.thumbnailUrl,
    this.thumbnail,
  });

  factory FilterProducts.fromMap(Map<String, dynamic> json) => FilterProducts(
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
        avgRating: json["avg_rating"],
        totalReviews: json["total_reviews"],
        isFavourite: json["is_favourite"],
        thumbnailUrl: json["thumbnail_url"],
        thumbnail: Thumbnail.fromMap(json["thumbnail"]),
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "avg_rating": avgRating,
        "total_reviews": totalReviews,
        "is_favourite": isFavourite,
        "thumbnail_url": thumbnailUrl,
        "thumbnail": thumbnail?.toMap(),
      };
}

class Thumbnail {
  int? id;
  String? modelType;
  int? modelId;
  String? uuid;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  String? conversionsDisk;
  int? size;
  List<dynamic>? manipulations;
  List<dynamic>? customProperties;
  List<dynamic>? generatedConversions;
  List<dynamic>? responsiveImages;
  int? orderColumn;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? originalUrl;
  String? previewUrl;

  Thumbnail({
    this.id,
    this.modelType,
    this.modelId,
    this.uuid,
    this.collectionName,
    this.name,
    this.fileName,
    this.mimeType,
    this.disk,
    this.conversionsDisk,
    this.size,
    this.manipulations,
    this.customProperties,
    this.generatedConversions,
    this.responsiveImages,
    this.orderColumn,
    this.createdAt,
    this.updatedAt,
    this.originalUrl,
    this.previewUrl,
  });

  factory Thumbnail.fromMap(Map<String, dynamic> json) => Thumbnail(
        id: json["id"],
        modelType: json["model_type"],
        modelId: json["model_id"],
        uuid: json["uuid"],
        collectionName: json["collection_name"],
        name: json["name"],
        fileName: json["file_name"],
        mimeType: json["mime_type"],
        disk: json["disk"],
        conversionsDisk: json["conversions_disk"],
        size: json["size"],
        manipulations: List<dynamic>.from(json["manipulations"].map((x) => x)),
        customProperties:
            List<dynamic>.from(json["custom_properties"].map((x) => x)),
        generatedConversions:
            List<dynamic>.from(json["generated_conversions"].map((x) => x)),
        responsiveImages:
            List<dynamic>.from(json["responsive_images"].map((x) => x)),
        orderColumn: json["order_column"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        originalUrl: json["original_url"],
        previewUrl: json["preview_url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "model_type": modelType,
        "model_id": modelId,
        "uuid": uuid,
        "collection_name": collectionName,
        "name": name,
        "file_name": fileName,
        "mime_type": mimeType,
        "disk": disk,
        "conversions_disk": conversionsDisk,
        "size": size,
        "manipulations": List<dynamic>.from(manipulations!.map((x) => x)),
        "custom_properties":
            List<dynamic>.from(customProperties!.map((x) => x)),
        "generated_conversions":
            List<dynamic>.from(generatedConversions!.map((x) => x)),
        "responsive_images":
            List<dynamic>.from(responsiveImages!.map((x) => x)),
        "order_column": orderColumn,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "original_url": originalUrl,
        "preview_url": previewUrl,
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
