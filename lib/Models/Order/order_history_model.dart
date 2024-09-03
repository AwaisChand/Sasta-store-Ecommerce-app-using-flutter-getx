// To parse this JSON data, do
//
//     final orderHistoryModel = orderHistoryModelFromMap(jsonString);

import 'dart:convert';

OrderHistoryModel orderHistoryModelFromMap(String str) =>
    OrderHistoryModel.fromMap(json.decode(str));

String orderHistoryModelToMap(OrderHistoryModel data) =>
    json.encode(data.toMap());

class OrderHistoryModel {
  int? status;
  String? message;
  dynamic validationErrors;
  Data? data;

  OrderHistoryModel({
    this.status,
    this.message,
    this.validationErrors,
    this.data,
  });

  factory OrderHistoryModel.fromMap(Map<String, dynamic> json) =>
      OrderHistoryModel(
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
  int? currentPage;
  List<Datum>? data;
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
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
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

class Datum {
  int? id;
  int? userId;
  String? code;
  double? subtotal;
  int? deliveryCharges;
  int? discount;
  double? total;
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

  Datum({
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
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        code: json["code"],
        subtotal: json["subtotal"]?.toDouble(),
        deliveryCharges: json["delivery_charges"],
        discount: json["discount"],
        total: json["total"]?.toDouble(),
        couponCode: json["coupon_code"],
        address: json["address"],
        paymentStatus: json["payment_status"]!,
        orderStatus: json["order_status"]!,
        deliveryDate: json["delivery_date"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        paymentMethodId: json["payment_method_id"],
        paymentMethod: PaymentMethod.fromMap(json["payment_method"]),
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
        name: json["name"]!,
        slug: json["slug"]!,
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image_url": imageUrl,
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
