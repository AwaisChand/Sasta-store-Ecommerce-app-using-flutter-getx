// To parse this JSON data, do
//
//     final profileModel = profileModelFromMap(jsonString);

import 'dart:convert';

ProfileModel profileModelFromMap(String str) =>
    ProfileModel.fromMap(json.decode(str));

String profileModelToMap(ProfileModel data) => json.encode(data.toMap());

class ProfileModel {
  int? status;
  String? message;
  dynamic validationErrors;
  Data? data;

  ProfileModel({
    this.status,
    this.message,
    this.validationErrors,
    this.data,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
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
  dynamic balance;
  dynamic personal_referral_code;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? profileImageUrl;

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
    this.balance,
    this.personal_referral_code,
    this.createdAt,
    this.updatedAt,
    this.profileImageUrl,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"] ?? '',
        balance: json["balance"] ?? '',
        personal_referral_code: json["personal_referral_code"] ?? '',
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
        profileImageUrl: json["profile_image_url"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "balance": balance,
        "personal_referral_code": personal_referral_code,
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
        "profile_image_url": profileImageUrl,
      };
}
