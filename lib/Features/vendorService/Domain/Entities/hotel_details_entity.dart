import 'package:equatable/equatable.dart';

class HotelDetailsEntity extends Equatable {
  final HotelData? data;
  final String? message;
  final int? status;

  const HotelDetailsEntity({this.data, this.message, this.status});

  factory HotelDetailsEntity.fromJson(Map<String, dynamic> json) =>
      HotelDetailsEntity(
        data: json["data"] == null ? null : HotelData.fromJson(json["data"]),
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

class HotelData extends Equatable {
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
  final List<HotelRoom>? hotelRooms;
  final List<dynamic>? serviceBranches;

  HotelData({
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
    this.hotelRooms,
    this.serviceBranches,
  });

  factory HotelData.fromJson(Map<String, dynamic> json) => HotelData(
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
    hotelRooms: json["hotelRooms"] == null
        ? []
        : List<HotelRoom>.from(
            json["hotelRooms"]!.map((x) => HotelRoom.fromJson(x)),
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
    "hotelRooms": hotelRooms == null
        ? []
        : List<dynamic>.from(hotelRooms!.map((x) => x.toJson())),
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
    hotelRooms,
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

class HotelRoom extends Equatable {
  final int? id;
  final String? roomNumber;
  final String? floorNumber;
  final int? capacity;
  final String? price;
  final String? deposit;
  final Branch? branch;
  final int? status;
  final int? adminStatus;

  const HotelRoom({
    this.id,
    this.roomNumber,
    this.floorNumber,
    this.capacity,
    this.price,
    this.deposit,
    this.branch,
    this.status,
    this.adminStatus,
  });

  factory HotelRoom.fromJson(Map<String, dynamic> json) => HotelRoom(
    id: json["id"] ?? 0,
    roomNumber: json["room_number"] ?? "",
    floorNumber: json["floor_number"] ?? "",
    capacity: json["capacity"] ?? 0,
    price: (json["price"] ?? 0).toString(),
    deposit: (json["deposit"] ?? 0).toString(),
    branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
    status: json["status"] ?? 0,
    adminStatus: json["adminStatus"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "room_number": roomNumber,
    "floor_number": floorNumber,
    "capacity": capacity,
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
    roomNumber,
    floorNumber,
    capacity,
    price,
    deposit,
    branch,
    status,
    adminStatus,
  ];
}

class Branch {
  final int? id;
  final String? name;
  final GetbranchName? getbranchName;

  Branch({this.id, this.name, this.getbranchName});

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["id"],
    name: json["name"],
    getbranchName: json["getbranch_name"] == null
        ? null
        : GetbranchName.fromJson(json["getbranch_name"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "getbranch_name": getbranchName?.toJson(),
  };
}

class GetbranchName {
  final int? id;
  final int? branchId;
  final String? name;
  final String? language;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GetbranchName({
    this.id,
    this.branchId,
    this.name,
    this.language,
    this.createdAt,
    this.updatedAt,
  });

  factory GetbranchName.fromJson(Map<String, dynamic> json) => GetbranchName(
    id: json["id"],
    branchId: json["branch_id"],
    name: json["name"],
    language: json["language"],
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
