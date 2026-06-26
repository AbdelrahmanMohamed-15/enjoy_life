import 'package:equatable/equatable.dart';

class AllServiceEntity extends Equatable {
  final List<AllServiceData>? data;
  final String? message;
  final int? status;

  const AllServiceEntity({this.data, this.message, this.status});

  factory AllServiceEntity.fromJson(Map<String, dynamic> json) =>
      AllServiceEntity(
        data: json["data"] == null
            ? []
            : List<AllServiceData>.from(
                json["data"]!.map((x) => AllServiceData.fromJson(x)),
              ),
        message: json["message"] ?? "",
        status: json["status"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };

  @override
  List<Object?> get props => [data, message, status];
}

class AllServiceData {
  final int? id;
  final String? name;

  AllServiceData({this.id, this.name});

  factory AllServiceData.fromJson(Map<String, dynamic> json) =>
      AllServiceData(id: json["id"] ?? 0, name: json["name"] ?? "");

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
