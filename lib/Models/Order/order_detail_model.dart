// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromMap(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromMap(String str) =>
    OrderDetailModel.fromMap(json.decode(str));

String orderDetailModelToMap(OrderDetailModel data) =>
    json.encode(data.toMap());

class OrderDetailModel {
  int? status;
  String? message;
  dynamic validationErrors;
  Data? data;

  OrderDetailModel({
    this.status,
    this.message,
    this.validationErrors,
    this.data,
  });

  factory OrderDetailModel.fromMap(Map<String, dynamic> json) =>
      OrderDetailModel(
        status: json["status"],
        message: json["message"],
        validationErrors: json["validation_errors"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "validation_errors": validationErrors,
        "data": data!.toMap(),
      };
}

class Data {
  int? id;
  int? userId;
  String? code;
  double? subtotal;
  dynamic deliveryCharges;
  int? discount;
  dynamic total;
  dynamic couponCode;
  String? address;
  String? paymentStatus;
  String? orderStatus;
  dynamic deliveryDate;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? paymentMethodId;
  PaymentMethod? paymentMethod;
  List<OrderItem>? orderItems;

  Data({
    this.id,
    this.userId,
    this.code,
    this.subtotal,
    this.deliveryCharges,
    this.discount,
    this.total,
    this.couponCode,
    this.address,
    this.paymentStatus,
    this.orderStatus,
    this.deliveryDate,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.paymentMethodId,
    this.paymentMethod,
    this.orderItems,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        code: json["code"],
        subtotal: json["subtotal"]?.toDouble(),
        deliveryCharges: json["delivery_charges"].toString() ?? '',
        discount: json["discount"],
        total: json["total"]?.toDouble().toString() ?? '',
        couponCode: json["coupon_code"],
        address: json["address"],
        paymentStatus: json["payment_status"],
        orderStatus: json["order_status"],
        deliveryDate: json["delivery_date"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        paymentMethodId: json["payment_method_id"],
        paymentMethod: PaymentMethod.fromMap(json["payment_method"]),
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "code": code,
        "subtotal": subtotal,
        "delivery_charges": deliveryCharges,
        "discount": discount,
        "total": total,
        "coupon_code": couponCode,
        "address": address,
        "payment_status": paymentStatus,
        "order_status": orderStatus,
        "delivery_date": deliveryDate,
        "comment": comment,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "payment_method_id": paymentMethodId,
        "payment_method": paymentMethod!.toMap(),
        "order_items": List<dynamic>.from(orderItems!.map((x) => x.toMap())),
      };
}

class OrderItem {
  int? id;
  int? orderId;
  int? productId;
  double? price;
  int? qty;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;

  OrderItem({
    this.id,
    this.orderId,
    this.productId,
    this.price,
    this.qty,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        price: json["price"]?.toDouble(),
        qty: json["qty"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        product: Product.fromMap(json["product"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "price": price,
        "qty": qty,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "product": product!.toMap(),
      };
}

class Product {
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
  String? thumbnailUrl;
  Thumbnail? thumbnail;

  Product({
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
    this.thumbnailUrl,
    this.thumbnail,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "thumbnail_url": thumbnailUrl,
        "thumbnail": thumbnail!.toMap(),
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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "original_url": originalUrl,
        "preview_url": previewUrl,
      };
}

class PaymentMethod {
  int? id;
  String? name;
  String? slug;
  String? imageUrl;

  PaymentMethod({
    this.id,
    this.name,
    this.slug,
    this.imageUrl,
  });

  factory PaymentMethod.fromMap(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image_url": imageUrl,
      };
}
