// To parse this JSON data, do
//
//     final loginModel = loginModelFromMap(jsonString);

import 'dart:convert';

LoginModel loginModelFromMap(String str) =>
    LoginModel.fromMap(json.decode(str));

String loginModelToMap(LoginModel data) => json.encode(data.toMap());

class LoginModel {
  int? status;
  String? message;
  Data? data;

  LoginModel({
    this.status,
    this.message,
    this.data,
  });

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data!.toMap(),
      };
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  dynamic emailVerifiedAt;
  dynamic referralCode;
  String? apiToken;
  dynamic passwordRecoveryToken;
  dynamic active;
  dynamic rememberToken;
  dynamic deletionRequestReceivedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? token;
  String? studentProfileUrl;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.referralCode,
    this.apiToken,
    this.passwordRecoveryToken,
    this.active,
    this.rememberToken,
    this.deletionRequestReceivedAt,
    this.createdAt,
    this.updatedAt,
    this.token,
    this.studentProfileUrl,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        emailVerifiedAt: json["email_verified_at"] ?? '',
        referralCode: json["referral_code"] ?? '',
        apiToken: json["api_token"] ?? '',
        passwordRecoveryToken: json["password_recovery_token"] ?? '',
        active: json["active"] ?? '',
        rememberToken: json["remember_token"] ?? '',
        deletionRequestReceivedAt: json["deletion_request_received_at"] ?? '',
        createdAt: DateTime.parse(json["created_at"] ?? DateTime.now()),
        updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now()),
        token: json["token"] ?? '',
        studentProfileUrl: json["student_profile_url"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "email_verified_at": emailVerifiedAt,
        "referral_code": referralCode,
        "api_token": apiToken,
        "password_recovery_token": passwordRecoveryToken,
        "active": active,
        "remember_token": rememberToken,
        "deletion_request_received_at": deletionRequestReceivedAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "token": token,
        "student_profile_url": studentProfileUrl,
      };
}
