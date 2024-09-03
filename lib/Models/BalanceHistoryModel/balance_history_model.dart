import 'dart:convert';

BalanceHistoryModel balanceHistoryModelFromJson(String str) =>
    BalanceHistoryModel.fromJson(json.decode(str));

String balanceHistoryModelToJson(BalanceHistoryModel data) =>
    json.encode(data.toJson());

class BalanceHistoryModel {
  String? status;
  List<Datum>? data;
  String? statusCode;

  BalanceHistoryModel({
    this.status,
    this.data,
    this.statusCode,
  });

  factory BalanceHistoryModel.fromJson(Map<String, dynamic> json) =>
      BalanceHistoryModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class Datum {
  int? id;
  int? fromUserId;
  int? toUserId;
  String? amount;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? fromUser;
  User? toUser;

  Datum({
    this.id,
    this.fromUserId,
    this.toUserId,
    this.amount,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.fromUser,
    this.toUser,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        fromUserId: json["from_user_id"],
        toUserId: json["to_user_id"],
        amount: json["amount"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        fromUser: User.fromJson(json["from_user"]),
        toUser: User.fromJson(json["to_user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from_user_id": fromUserId,
        "to_user_id": toUserId,
        "amount": amount,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "from_user": fromUser?.toJson(),
        "to_user": toUser?.toJson(),
      };
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  dynamic emailVerifiedAt;
  dynamic referralCode;
  String? apiToken;
  int? passwordRecoveryToken;
  int? active;
  dynamic rememberToken;
  dynamic deletionRequestReceivedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? balance;
  String? personalReferralCode;
  String? profileImageUrl;

  User({
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
    this.balance,
    this.personalReferralCode,
    this.profileImageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        emailVerifiedAt: json["email_verified_at"],
        referralCode: json["referral_code"],
        apiToken: json["api_token"],
        passwordRecoveryToken: json["password_recovery_token"],
        active: json["active"],
        rememberToken: json["remember_token"],
        deletionRequestReceivedAt: json["deletion_request_received_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        balance: json["balance"],
        personalReferralCode: json["personal_referral_code"],
        profileImageUrl: json["profile_image_url"],
      );

  Map<String, dynamic> toJson() => {
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "balance": balance,
        "personal_referral_code": personalReferralCode,
        "profile_image_url": profileImageUrl,
      };
}
