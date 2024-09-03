// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromMap(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromMap(String str) =>
    SignUpModel.fromMap(json.decode(str));

String signUpModelToMap(SignUpModel data) => json.encode(data.toMap());

class SignUpModel {
  int? status;
  String? message;
  dynamic validationErrors;
  Data? data;

  SignUpModel({
    this.status,
    this.message,
    this.validationErrors,
    this.data,
  });

  factory SignUpModel.fromMap(Map<String, dynamic> json) => SignUpModel(
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
  String? name;
  String? email;
  String? phone;
  dynamic referralCode;
  String? apiToken;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic id;
  String? token;
  String? studentProfileUrl;

  Data({
    this.name,
    this.email,
    this.phone,
    this.referralCode,
    this.apiToken,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.token,
    this.studentProfileUrl,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        referralCode: json["referral_code"] ?? '',
        apiToken: json["api_token"] ?? '',
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"] ?? '',
        token: json["token"] ?? '',
        studentProfileUrl: json["student_profile_url"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "phone": phone,
        "referral_code": referralCode,
        "api_token": apiToken,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
        "token": token,
        "student_profile_url": studentProfileUrl,
      };
}
