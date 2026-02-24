import 'package:equatable/equatable.dart';

class SearchEntity extends Equatable {
  final bool? status;
  final int? code;
  final String? message;
  final List<SearchData>? data;

  const SearchEntity({this.status, this.code, this.message, this.data});

  factory SearchEntity.fromJson(Map<String, dynamic> json) => SearchEntity(
    status: json["status"] ?? false,
    code: json["code"] ?? 0,
    message: json["message"] ?? '',
    data: json["data"] == null
        ? []
        : List<SearchData>.from(
            json["data"]!.map((x) => SearchData.fromJson(x)),
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

class SearchData extends Equatable {
  final int? id;
  final String? type;
  final String? logo;
  final String? name;
  final String? phone;
  final String? address;
  final String? latitude;
  final String? longitude;
  final DateTime? createdAt;

  const SearchData({
    this.id,
    this.type,
    this.logo,
    this.name,
    this.phone,
    this.address,
    this.latitude,
    this.longitude,
    this.createdAt,
  });

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
    id: json["id"] ?? 0,
    type: json["type"] ?? '',
    logo: json["logo"] ?? '',
    name: json["name"] ?? '',
    phone: json["phone"] ?? '',
    address: json["address"] ?? '',
    latitude: json["latitude"] ?? '',
    longitude: json["longitude"] ?? '',
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "logo": logo,
    "name": name,
    "phone": phone,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "created_at": createdAt?.toIso8601String(),
  };

  @override
  List<Object?> get props => [
    id,
    type,
    logo,
    name,
    phone,
    address,
    latitude,
    longitude,
    createdAt,
  ];
}
