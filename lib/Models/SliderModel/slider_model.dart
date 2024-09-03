import 'dart:convert';

SliderModel sliderModelFromMap(String str) =>
    SliderModel.fromMap(json.decode(str));

String sliderModelToMap(SliderModel data) => json.encode(data.toMap());

class SliderModel {
  int? status;
  String? message;
  dynamic validationErrors;
  List<Datum>? data;

  SliderModel({
    this.status,
    this.message,
    this.validationErrors,
    this.data,
  });

  factory SliderModel.fromMap(Map<String, dynamic> json) => SliderModel(
        status: json["status"],
        message: json["message"],
        validationErrors: json["validation_errors"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "validation_errors": validationErrors,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  int? id;
  String? name;
  int? active;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;

  Datum({
    this.id,
    this.name,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        active: json["active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "active": active,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "image_url": imageUrl,
      };
}
