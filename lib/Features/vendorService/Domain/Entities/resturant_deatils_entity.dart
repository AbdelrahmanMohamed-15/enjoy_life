import 'package:equatable/equatable.dart';

class ResturantDeatilsEntity extends Equatable {
  final ResturantData? data;
  final String? message;
  final int? status;

  const ResturantDeatilsEntity({this.data, this.message, this.status});

  factory ResturantDeatilsEntity.fromJson(Map<String, dynamic> json) =>
      ResturantDeatilsEntity(
        data: json["data"] == null
            ? null
            : ResturantData.fromJson(json["data"]),
        message: json["message"] ?? "",
        status: json["status"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "status": status,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [data, message, status];
}

class ResturantData extends Equatable {
  final int? id;
  final String? logo;
  final List<Image>? images;
  final String? name;
  final String? phone;
  final String? address;
  final String? latitude;
  final String? longitude;
  final int? status;
  final int? adminStatus;
  final DateTime? createdAt;
  final Service? service;
  final List<RestaurantTable>? restaurantTables;
  final List<dynamic>? serviceBranches;

  ResturantData({
    this.id,
    this.logo,
    this.images,
    this.name,
    this.phone,
    this.address,
    this.latitude,
    this.longitude,
    this.status,
    this.adminStatus,
    this.createdAt,
    this.service,
    this.restaurantTables,
    this.serviceBranches,
  });

  factory ResturantData.fromJson(Map<String, dynamic> json) => ResturantData(
    id: json["id"] ?? 0,
    logo: json["logo"] ?? "",
    images: json["images"] == null
        ? []
        : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    name: json["name"] ?? "",
    phone: json["phone"] ?? "",
    address: json["address"] ?? "",
    latitude: json["latitude"] ?? "",
    longitude: json["longitude"] ?? "",
    status: json["status"] ?? 0,
    adminStatus: json["adminStatus"] ?? 0,
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    restaurantTables: json["restaurantTables"] == null
        ? []
        : List<RestaurantTable>.from(
            json["restaurantTables"]!.map((x) => RestaurantTable.fromJson(x)),
          ),
    serviceBranches: json["serviceBranches"] == null
        ? []
        : List<dynamic>.from(json["serviceBranches"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "logo": logo,
    "images": images == null
        ? []
        : List<dynamic>.from(images!.map((x) => x.toJson())),
    "name": name,
    "phone": phone,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "status": status,
    "adminStatus": adminStatus,
    "created_at": createdAt?.toIso8601String(),
    "service": service?.toJson(),
    "restaurantTables": restaurantTables == null
        ? []
        : List<dynamic>.from(restaurantTables!.map((x) => x.toJson())),
    "serviceBranches": serviceBranches == null
        ? []
        : List<dynamic>.from(serviceBranches!.map((x) => x)),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    logo,
    images,
    name,
    phone,
    address,
    latitude,
    longitude,
    status,
    adminStatus,
    createdAt,
    service,
    restaurantTables,
    serviceBranches,
  ];
}

class Image extends Equatable {
  final int? id;
  final String? url;
  final String? localUrl;
  final String? fileName;
  final int? size;
  final String? mimeType;

  Image({
    this.id,
    this.url,
    this.localUrl,
    this.fileName,
    this.size,
    this.mimeType,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"] ?? 0,
    url: json["url"] ?? "",
    localUrl: json["local_url"] ?? "",
    fileName: json["file_name"] ?? "",
    size: json["size"] ?? 0,
    mimeType: json["mime_type"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "local_url": localUrl,
    "file_name": fileName,
    "size": size,
    "mime_type": mimeType,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, url, localUrl, fileName, size, mimeType];
}

class RestaurantTable extends Equatable {
  final int? id;
  final String? tableNumber;
  final int? capacity;
  final int? available;
  final String? price;
  final String? deposit;
  final Branch? branch;
  final int? status;
  final int? adminStatus;

  RestaurantTable({
    this.id,
    this.tableNumber,
    this.capacity,
    this.available,
    this.price,
    this.deposit,
    this.branch,
    this.status,
    this.adminStatus,
  });

  factory RestaurantTable.fromJson(Map<String, dynamic> json) =>
      RestaurantTable(
        id: json["id"] ?? 0,
        tableNumber: json["table_number"] ?? "",
        capacity: json["capacity"] ?? 0,
        available: json["available"] ?? 0,
        price: (json["price"] ?? 0).toString(),
        deposit: (json["deposit"] ?? 0).toString(),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        status: json["status"] ?? 0,
        adminStatus: json["adminStatus"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "table_number": tableNumber,
    "capacity": capacity,
    "available": available,
    "price": price,
    "deposit": deposit,
    "branch": branch?.toJson(),
    "status": status,
    "adminStatus": adminStatus,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    tableNumber,
    capacity,
    available,
    price,
    deposit,
    branch,
    status,
    adminStatus,
  ];
}

class Branch extends Equatable {
  final int? id;
  final String? name;
  final GetName? getbranchName;

  Branch({this.id, this.name, this.getbranchName});

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    getbranchName: json["getbranch_name"] == null
        ? null
        : GetName.fromJson(json["getbranch_name"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "getbranch_name": getbranchName?.toJson(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, getbranchName];
}

class GetName extends Equatable {
  final int? id;
  final int? branchId;
  final String? name;
  final String? language;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? serviceId;

  GetName({
    this.id,
    this.branchId,
    this.name,
    this.language,
    this.createdAt,
    this.updatedAt,
    this.serviceId,
  });

  factory GetName.fromJson(Map<String, dynamic> json) => GetName(
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
    serviceId: json["service_id"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branch_id": branchId,
    "name": name,
    "language": language,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "service_id": serviceId,
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
    serviceId,
  ];
}

class Service extends Equatable {
  final int? id;
  final int? categoryId;
  final dynamic image;
  final int? status;
  final int? vendorStatus;
  final int? vendorNotes;
  final int? sorting;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final GetName? getServiceName;

  Service({
    this.id,
    this.categoryId,
    this.image,
    this.status,
    this.vendorStatus,
    this.vendorNotes,
    this.sorting,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.getServiceName,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"] ?? 0,
    categoryId: json["category_id"] ?? 0,
    image: json["image"] ?? "",
    status: json["status"] ?? 0,
    vendorStatus: json["vendor_status"] ?? 0,
    vendorNotes: json["vendor_notes"] ?? 0,
    sorting: json["sorting"] ?? 0,
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    name: json["name"],
    getServiceName: json["get_service_name"] == null
        ? null
        : GetName.fromJson(json["get_service_name"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "image": image,
    "status": status,
    "vendor_status": vendorStatus,
    "vendor_notes": vendorNotes,
    "sorting": sorting,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "name": name,
    "get_service_name": getServiceName?.toJson(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    categoryId,
    image,
    status,
    vendorStatus,
    vendorNotes,
    sorting,
    createdAt,
    updatedAt,
    name,
    getServiceName,
  ];
}
