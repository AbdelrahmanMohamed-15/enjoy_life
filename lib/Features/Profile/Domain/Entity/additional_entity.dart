import 'package:equatable/equatable.dart';

class AdditionalEntity extends Equatable {
  final bool? status;
  final int? code;
  final String? message;
  final List<AdditonalData>? data;

  const AdditionalEntity({this.status, this.code, this.message, this.data});

  factory AdditionalEntity.fromJson(Map<String, dynamic> json) =>
      AdditionalEntity(
        status: json["status"] ?? false,
        code: json["code"] ?? 0,
        message: json["message"] ?? "",
        data: json["data"] == null
            ? []
            : List<AdditonalData>.from(
                json["data"]!.map((x) => AdditonalData.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };

  @override
  List<Object?> get props => [status, code, message, data];
}

class AdditonalData {
  final int? id;
  final String? type;
  final String? description;
  final DateTime? createdAt;

  AdditonalData({this.id, this.type, this.description, this.createdAt});

  factory AdditonalData.fromJson(Map<String, dynamic> json) => AdditonalData(
    id: json["id"] ?? 0,
    type: json["type"] ?? "",
    description: json["description"] ?? "",
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
  };
}
