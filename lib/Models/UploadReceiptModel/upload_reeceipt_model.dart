// To parse this JSON data, do
//
//     final uploadReceiptModel = uploadReceiptModelFromJson(jsonString);

import 'dart:convert';

UploadReceiptModel uploadReceiptModelFromJson(String str) => UploadReceiptModel.fromJson(json.decode(str));

String uploadReceiptModelToJson(UploadReceiptModel data) => json.encode(data.toJson());

class UploadReceiptModel {
  int? status;
  String? message;
  dynamic validationErrors;
  Data? data;

  UploadReceiptModel({
    this.status,
    this.message,
    this.validationErrors,
    this.data,
  });

  factory UploadReceiptModel.fromJson(Map<String, dynamic> json) => UploadReceiptModel(
    status: json["status"],
    message: json["message"],
    validationErrors: json["validation_errors"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "validation_errors": validationErrors,
    "data": data?.toJson(),
  };
}

class Data {
  String? paymentReceiptUrl;

  Data({
    this.paymentReceiptUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    paymentReceiptUrl: json["payment_receipt_url"],
  );

  Map<String, dynamic> toJson() => {
    "payment_receipt_url": paymentReceiptUrl,
  };
}
