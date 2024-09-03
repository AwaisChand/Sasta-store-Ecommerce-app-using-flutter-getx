import 'dart:convert';

GetAllMessageModel getAllMessageModelFromJson(String str) => GetAllMessageModel.fromJson(json.decode(str));

String getAllMessageModelToJson(GetAllMessageModel data) => json.encode(data.toJson());

class GetAllMessageModel {
  int? status;
  String? message;
  dynamic validationErrors;
  List<Datum>? data;

  GetAllMessageModel({
    this.status,
    this.message,
    this.validationErrors,
    this.data,
  });

  factory GetAllMessageModel.fromJson(Map<String, dynamic> json) => GetAllMessageModel(
    status: json["status"],
    message: json["message"],
    validationErrors: json["validation_errors"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "validation_errors": validationErrors,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  int? conversationId;
  int? userId;
  int? adminId;
  String? message;
  String? msgType;
  int? seen;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? attachmentUrl;
  Admin? admin;

  Datum({
    this.id,
    this.conversationId,
    this.userId,
    this.adminId,
    this.message,
    this.msgType,
    this.seen,
    this.createdAt,
    this.updatedAt,
    this.attachmentUrl,
    this.admin,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    conversationId: json["conversation_id"],
    userId: json["user_id"],
    adminId: json["admin_id"],
    message: json["message"],
    msgType: json["msg_type"],
    seen: json["seen"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    attachmentUrl: json["attachment_url"],
    admin: Admin.fromJson(json["admin"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "conversation_id": conversationId,
    "user_id": userId,
    "admin_id": adminId,
    "message": message,
    "msg_type": msgType,
    "seen": seen,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "attachment_url": attachmentUrl,
    "admin": admin?.toJson(),
  };
}

class Admin {
  int? id;
  String? name;
  String? avatarUrl;
  dynamic avatar;

  Admin({
    this.id,
    this.name,
    this.avatarUrl,
    this.avatar,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    id: json["id"],
    name: json["name"],
    avatarUrl: json["avatar_url"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar_url": avatarUrl,
    "avatar": avatar,
  };
}
