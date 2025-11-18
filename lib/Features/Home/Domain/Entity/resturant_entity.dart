import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  final List<HomeData>? data;
  final String? message;
  final int? status;

  const HomeEntity({this.data, this.message, this.status});

  factory HomeEntity.fromJson(Map<String, dynamic> json) => HomeEntity(
    data: json["data"] == null
        ? []
        : List<HomeData>.from(json["data"]!.map((x) => HomeData.fromJson(x))),
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
  // TODO: implement props
  List<Object?> get props => [data, message, status];
}

class HomeData extends Equatable {
  final int? id;
  final int? itemID;
  final String? name;
  final String? description;
  final String? phone;
  final String? address;
  final String? latitude;
  final String? longitude;
  final String? rating;
  final bool? isFavourite;
  final String? logo;
  final List<Image>? images;
  final int? serviceId;
  final String? serviceName;
  final int? clientId;
  final String? clientName;

  HomeData({
    this.id,
    this.itemID,
    this.name,
    this.description,
    this.phone,
    this.address,
    this.latitude,
    this.longitude,
    this.rating,
    this.isFavourite,
    this.logo,
    this.images,
    this.serviceId,
    this.serviceName,
    this.clientId,
    this.clientName,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
    id: json["id"] ?? 0,
    itemID: json["item_id"] ?? 0,
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    phone: json["phone"] ?? "",
    address: json["address"] ?? "",
    latitude: json["latitude"] ?? "",
    longitude: json["longitude"] ?? "",
    rating: (json["rating"] ?? 0).toString(),
    isFavourite: json["is_favourite"] ?? false,
    logo: json["logo"] ?? "",
    images: json["images"] == null
        ? []
        : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    serviceId: json["service_id"] ?? 0,
    serviceName: json["service_name"] ?? "",
    clientId: json["client_id"] ?? 0,
    clientName: json["client_name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_id": itemID,
    "name": name,
    "description": description,
    "phone": phone,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "rating": rating,
    "is_favourite": isFavourite,
    "logo": logo,
    "images": images == null
        ? []
        : List<dynamic>.from(images!.map((x) => x.toJson())),
    "service_id": serviceId,
    "service_name": serviceName,
    "client_id": clientId,
    "client_name": clientName,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    itemID,
    name,
    description,
    phone,
    address,
    latitude,
    longitude,
    rating,
    isFavourite,
    logo,
    images,
    serviceId,
    serviceName,
    clientId,
    clientName,
  ];
}

class Image extends Equatable {
  final int? id;
  final String? url;

  Image({this.id, this.url});

  factory Image.fromJson(Map<String, dynamic> json) =>
      Image(id: json["id"] ?? 0, url: json["url"] ?? "");

  Map<String, dynamic> toJson() => {"id": id, "url": url};

  @override
  // TODO: implement props
  List<Object?> get props => [id, url];
}
