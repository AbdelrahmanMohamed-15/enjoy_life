import 'package:equatable/equatable.dart';

class AllBranchEntity extends Equatable {
  final List<BranchData>? data;
  final String? message;
  final int? status;

  const AllBranchEntity({this.data, this.message, this.status});

  factory AllBranchEntity.fromJson(Map<String, dynamic> json) =>
      AllBranchEntity(
        data: json["data"] == null
            ? []
            : List<BranchData>.from(
                json["data"]!.map((x) => BranchData.fromJson(x)),
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

class BranchData extends Equatable {
  final int? id;
  final String? address;
  final String? logo;
  final String? phone;
  final String? image;
  final String? latitude;
  final String? longitude;
  final int? status;
  final int? deliveryPrice;
  final int? delivery;
  final int? clientId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final int? adminStatus;
  final String? name;
  final GetbranchName? getbranchName;

  const BranchData({
    this.id,
    this.address,
    this.logo,
    this.phone,
    this.image,
    this.latitude,
    this.longitude,
    this.status,
    this.deliveryPrice,
    this.delivery,
    this.clientId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.adminStatus,
    this.name,
    this.getbranchName,
  });

  factory BranchData.fromJson(Map<String, dynamic> json) => BranchData(
    id: json["id"] ?? 0,
    address: json["address"] ?? "",
    logo: json["logo"] ?? "",
    phone: json["phone"] ?? "",
    image: json["image"] ?? "",
    latitude: json["latitude"] ?? "",
    longitude: json["longitude"] ?? "",
    status: json["status"] ?? 0,
    deliveryPrice: json["delivery_price"] ?? 0,
    delivery: json["delivery"] ?? 0,
    clientId: json["client_id"] ?? 0,
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null
        ? null
        : DateTime.parse(json["deleted_at"]),
    adminStatus: json["adminStatus"] ?? 0,
    name: json["name"] ?? "",
    getbranchName: json["getbranch_name"] == null
        ? null
        : GetbranchName.fromJson(json["getbranch_name"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "logo": logo,
    "phone": phone,
    "image": image,
    "latitude": latitude,
    "longitude": longitude,
    "status": status,
    "delivery_price": deliveryPrice,
    "delivery": delivery,
    "client_id": clientId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "adminStatus": adminStatus,
    "name": name,
    "getbranch_name": getbranchName?.toJson(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    address,
    logo,
    phone,
    image,
    latitude,
    longitude,
    status,
    deliveryPrice,
    delivery,
    clientId,
    createdAt,
    updatedAt,
    deletedAt,
    adminStatus,
    name,
    getbranchName,
  ];
}

class GetbranchName extends Equatable {
  final int? id;
  final int? branchId;
  final String? name;
  final String? language;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const GetbranchName({
    this.id,
    this.branchId,
    this.name,
    this.language,
    this.createdAt,
    this.updatedAt,
  });

  factory GetbranchName.fromJson(Map<String, dynamic> json) => GetbranchName(
    id: json["id"] ?? 0,
    branchId: json["branch_id"] ?? 0,
    name: json["name"] ?? "",
    language: json["language"] ?? "",
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branch_id": branchId,
    "name": name,
    "language": language,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    branchId,
    name,
    language,
    createdAt,
    updatedAt,
  ];
}
