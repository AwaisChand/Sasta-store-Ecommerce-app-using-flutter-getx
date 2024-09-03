// To parse this JSON data, do
//
//     final paymentMethodModel = paymentMethodModelFromMap(jsonString);

import 'dart:convert';

PaymentMethodModel paymentMethodModelFromMap(String str) =>
    PaymentMethodModel.fromMap(json.decode(str));

String paymentMethodModelToMap(PaymentMethodModel data) =>
    json.encode(data.toMap());

class PaymentMethodModel {
  int? status;
  String? message;
  dynamic validationErrors;
  int? deliveryCharges;
  List<Datum>? data;

  PaymentMethodModel({
    this.status,
    this.message,
    this.validationErrors,
    this.deliveryCharges,
    this.data,
  });

  factory PaymentMethodModel.fromMap(Map<String, dynamic> json) =>
      PaymentMethodModel(
        status: json["status"],
        message: json["message"],
        validationErrors: json["validation_errors"],
        deliveryCharges: json["delivery_charges"] ?? '',
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "validation_errors": validationErrors,
        "delivery_charges": deliveryCharges,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  int? id;
  String? name;
  String? slug;
  String? imageUrl;

  Datum({
    this.id,
    this.name,
    this.slug,
    this.imageUrl,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"] ?? '',
        slug: json["slug"] ?? '',
        imageUrl: json["image_url"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image_url": imageUrl,
      };
}

CheckOutModel checkOutModelFromMap(String str) =>
    CheckOutModel.fromMap(json.decode(str));

String checkOutModelToMap(CheckOutModel data) => json.encode(data.toMap());

class CheckOutModel {
  double? subtotal;
  int? deliveryCharges;
  int? discount;
  double? total;
  String? address;
  String? comment;
  int? paymentMethodId;
  List<OrderItem>? orderItems = [];

  CheckOutModel({
    this.subtotal,
    this.deliveryCharges,
    this.discount,
    this.total,
    this.address,
    this.comment,
    this.paymentMethodId,
    this.orderItems,
  });

  factory CheckOutModel.fromMap(Map<String, dynamic> json) => CheckOutModel(
        subtotal: json["subtotal"]?.toDouble(),
        deliveryCharges: json["delivery_charges"],
        discount: json["discount"],
        total: json["total"]?.toDouble(),
        address: json["address"],
        comment: json["comment"],
        paymentMethodId: json["payment_method_id"],
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "subtotal": subtotal,
        "delivery_charges": deliveryCharges,
        "discount": discount,
        "total": total,
        "address": address,
        "comment": comment,
        "payment_method_id": paymentMethodId,
        "order_items": List<dynamic>.from(orderItems!.map((x) => x.toMap())),
      };
}

class OrderItem {
  int? productId;
  double? price;
  int? qty;

  OrderItem({
    this.productId,
    this.price,
    this.qty,
  });

  factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
        productId: json["product_id"],
        price: json["price"]?.toDouble(),
        qty: json["qty"],
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "price": price,
        "qty": qty,
      };

  @override
  String toString() => "{ product_id : $productId, price : $price, qty : $qty}";
}
