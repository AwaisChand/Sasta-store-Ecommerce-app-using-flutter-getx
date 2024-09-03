
import 'dart:convert';

SendMessageModel sendMessageModelFromJson(String str) => SendMessageModel.fromJson(json.decode(str));

String sendMessageModelToJson(SendMessageModel data) => json.encode(data.toJson());

class SendMessageModel {
  int? status;
  String? message;
  dynamic validationErrors;
  Data? data;

  SendMessageModel({
    this.status,
    this.message,
    this.validationErrors,
    this.data,
  });

  factory SendMessageModel.fromJson(Map<String, dynamic> json) => SendMessageModel(
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
  int? conversationId;
  int? userId;
  int? adminId;
  dynamic message;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? attachmentUrl;

  Data({
    this.conversationId,
    this.userId,
    this.adminId,
    this.message,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.attachmentUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    conversationId: json["conversation_id"],
    userId: json["user_id"],
    adminId: json["admin_id"],
    message: json["message"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
    attachmentUrl: json["attachment_url"],
  );

  Map<String, dynamic> toJson() => {
    "conversation_id": conversationId,
    "user_id": userId,
    "admin_id": adminId,
    "message": message,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "attachment_url": attachmentUrl,
  };
}
