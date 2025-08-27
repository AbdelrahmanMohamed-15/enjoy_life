// import 'package:equatable/equatable.dart';

// class HomeModel extends Equatable {
//   final Data? data;
//   final String? message;
//   final int? status;

//   HomeModel({this.data, this.message, this.status});

//   factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
//     data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     message: json["message"] ?? "",
//     status: json["status"] ?? 0,
//   );

//   Map<String, dynamic> toJson() => {
//     "data": data?.toJson(),
//     "message": message,
//     "status": status,
//   };

//   @override
//   // TODO: implement props
//   List<Object?> get props => [data, message, status];
// }

// class Data extends Equatable {
//   final List<Slider>? sliders;
//   final List<Hotel>? resturants;
//   final List<Hotel>? hotels;
//   final List<Trip>? trips;

//   Data({this.sliders, this.resturants, this.hotels, this.trips});

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     sliders: json["sliders"] == null
//         ? []
//         : List<Slider>.from(json["sliders"]!.map((x) => Slider.fromJson(x))),
//     resturants: json["resturants"] == null
//         ? []
//         : List<Hotel>.from(json["resturants"]!.map((x) => Hotel.fromJson(x))),
//     hotels: json["hotels"] == null
//         ? []
//         : List<Hotel>.from(json["hotels"]!.map((x) => Hotel.fromJson(x))),
//     trips: json["trips"] == null
//         ? []
//         : List<Trip>.from(json["trips"]!.map((x) => Trip.fromJson(x))),
//   );

//   Map<String, dynamic> toJson() => {
//     "sliders": sliders == null
//         ? []
//         : List<dynamic>.from(sliders!.map((x) => x.toJson())),
//     "resturants": resturants == null
//         ? []
//         : List<dynamic>.from(resturants!.map((x) => x.toJson())),
//     "hotels": hotels == null
//         ? []
//         : List<dynamic>.from(hotels!.map((x) => x.toJson())),
//     "trips": trips == null
//         ? []
//         : List<dynamic>.from(trips!.map((x) => x.toJson())),
//   };

//   @override
//   List<Object?> get props => [sliders, resturants, hotels, trips];
// }

// class Hotel extends Equatable {
//   final int? id;
//   final String? address;
//   final String? phone;
//   final String? logo;
//   final String? image;
//   final String? latitude;
//   final String? longitude;
//   final int? status;
//   final int? serviceId;
//   final int? clientId;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final DateTime? deletedAt;
//   final int? adminStatus;
//   final List<Image>? images;
//   final String? name;
//   final String? description;
//   final double? rating;
//   final Service? service;
//   final List<Media>? media;
//   final Get? getHotelName;
//   final Get? getHotelDescription;
//   final Get? getRestaurantName;
//   final Get? getRestaurantDescription;

//   Hotel({
//     this.id,
//     this.address,
//     this.phone,
//     this.logo,
//     this.image,
//     this.latitude,
//     this.longitude,
//     this.status,
//     this.serviceId,
//     this.clientId,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.adminStatus,
//     this.images,
//     this.name,
//     this.description,
//     this.rating,
//     this.service,
//     this.media,
//     this.getHotelName,
//     this.getHotelDescription,
//     this.getRestaurantName,
//     this.getRestaurantDescription,
//   });

//   factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
//     id: json["id"] ?? 0,
//     address: json["address"] ?? "",
//     phone: json["phone"] ?? "",
//     logo: json["logo"] ?? "",
//     image: json["image"] ?? "",
//     latitude: json["latitude"] ?? "",
//     longitude: json["longitude"] ?? "",
//     status: json["status"] ?? 0,
//     serviceId: json["service_id"] ?? 0,
//     clientId: json["client_id"] ?? 0,
//     createdAt: json["created_at"] == null
//         ? null
//         : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null
//         ? null
//         : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"] == null
//         ? null
//         : DateTime.parse(json["deleted_at"]),
//     adminStatus: json["adminStatus"] ?? 0,
//     images: json["images"] == null
//         ? []
//         : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
//     name: json["name"] ?? "",
//     description: json["description"] ?? "",
//     rating: (json["rating"] ?? 0 + 0.0),
//     service: json["service"] == null ? null : Service.fromJson(json["service"]),
//     media: json["media"] == null
//         ? []
//         : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
//     getHotelName: json["get_hotel_name"] == null
//         ? null
//         : Get.fromJson(json["get_hotel_name"]),
//     getHotelDescription: json["get_hotel_description"] == null
//         ? null
//         : Get.fromJson(json["get_hotel_description"]),
//     getRestaurantName: json["get_restaurant_name"] == null
//         ? null
//         : Get.fromJson(json["get_restaurant_name"]),
//     getRestaurantDescription: json["get_restaurant_description"] == null
//         ? null
//         : Get.fromJson(json["get_restaurant_description"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "address": address,
//     "phone": phone,
//     "logo": logo,
//     "image": image,
//     "latitude": latitude,
//     "longitude": longitude,
//     "status": status,
//     "service_id": serviceId,
//     "client_id": clientId,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//     "adminStatus": adminStatus,
//     "images": images == null
//         ? []
//         : List<dynamic>.from(images!.map((x) => x.toJson())),
//     "name": name,
//     "description": description,
//     "rating": rating,
//     "service": service?.toJson(),
//     "media": media == null
//         ? []
//         : List<dynamic>.from(media!.map((x) => x.toJson())),
//     "get_hotel_name": getHotelName?.toJson(),
//     "get_hotel_description": getHotelDescription?.toJson(),
//     "get_restaurant_name": getRestaurantName?.toJson(),
//     "get_restaurant_description": getRestaurantDescription?.toJson(),
//   };

//   @override
//   // TODO: implement props
//   List<Object?> get props => [
//     id,
//     address,
//     phone,
//     logo,
//     image,
//     latitude,
//     longitude,
//     status,
//     serviceId,
//     clientId,
//     createdAt,
//     updatedAt,
//     deletedAt,
//     adminStatus,
//     images,
//     name,
//     description,
//     rating,
//     service,
//   ];
// }

// class Get extends Equatable {
//   final int? id;
//   final int? hotelId;
//   final String? name;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final String? description;
//   final int? restaurantId;
//   final int? tripId;

//   Get({
//     this.id,
//     this.hotelId,
//     this.name,
//     this.createdAt,
//     this.updatedAt,
//     this.description,
//     this.restaurantId,
//     this.tripId,
//   });

//   factory Get.fromJson(Map<String, dynamic> json) => Get(
//     id: json["id"],
//     hotelId: json["hotel_id"],
//     name: json["name"],
//     createdAt: json["created_at"] == null
//         ? null
//         : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null
//         ? null
//         : DateTime.parse(json["updated_at"]),
//     description: json["description"],
//     restaurantId: json["restaurant_id"],
//     tripId: json["trip_id"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "hotel_id": hotelId,
//     "name": name,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "description": description,
//     "restaurant_id": restaurantId,
//     "trip_id": tripId,
//   };

//   @override
//   // TODO: implement props
//   List<Object?> get props => [
//     id,
//     hotelId,
//     name,
//     createdAt,
//     updatedAt,
//     description,
//     restaurantId,
//     tripId,
//   ];
// }

// class Image extends Equatable {
//   final int? id;
//   final String? url;

//   Image({this.id, this.url});

//   factory Image.fromJson(Map<String, dynamic> json) =>
//       Image(id: json["id"] ?? 0, url: json["url"] ?? "");

//   Map<String, dynamic> toJson() => {"id": id, "url": url};

//   @override
//   // TODO: implement props
//   List<Object?> get props => [id, url];
// }

// class Media extends Equatable {
//   final int? id;
//   final int? modelId;
//   final String? uuid;
//   final String? name;
//   final String? fileName;
//   final int? size;
//   final List<dynamic>? manipulations;
//   final List<dynamic>? customProperties;
//   final List<dynamic>? generatedConversions;
//   final List<dynamic>? responsiveImages;
//   final int? orderColumn;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final String? localUrl;
//   final String? originalUrl;
//   final String? previewUrl;

//   Media({
//     this.id,
//     this.modelId,
//     this.uuid,
//     this.name,
//     this.fileName,
//     this.size,
//     this.manipulations,
//     this.customProperties,
//     this.generatedConversions,
//     this.responsiveImages,
//     this.orderColumn,
//     this.createdAt,
//     this.updatedAt,
//     this.localUrl,
//     this.originalUrl,
//     this.previewUrl,
//   });

//   factory Media.fromJson(Map<String, dynamic> json) => Media(
//     id: json["id"],
//     modelId: json["model_id"],
//     uuid: json["uuid"],
//     name: json["name"],
//     fileName: json["file_name"],
//     size: json["size"],
//     manipulations: json["manipulations"] == null
//         ? []
//         : List<dynamic>.from(json["manipulations"]!.map((x) => x)),
//     customProperties: json["custom_properties"] == null
//         ? []
//         : List<dynamic>.from(json["custom_properties"]!.map((x) => x)),
//     generatedConversions: json["generated_conversions"] == null
//         ? []
//         : List<dynamic>.from(json["generated_conversions"]!.map((x) => x)),
//     responsiveImages: json["responsive_images"] == null
//         ? []
//         : List<dynamic>.from(json["responsive_images"]!.map((x) => x)),
//     orderColumn: json["order_column"],
//     createdAt: json["created_at"] == null
//         ? null
//         : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null
//         ? null
//         : DateTime.parse(json["updated_at"]),
//     localUrl: json["localUrl"],
//     originalUrl: json["original_url"],
//     previewUrl: json["preview_url"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "model_id": modelId,
//     "uuid": uuid,
//     "name": name,
//     "file_name": fileName,
//     "size": size,
//     "manipulations": manipulations == null
//         ? []
//         : List<dynamic>.from(manipulations!.map((x) => x)),
//     "custom_properties": customProperties == null
//         ? []
//         : List<dynamic>.from(customProperties!.map((x) => x)),
//     "generated_conversions": generatedConversions == null
//         ? []
//         : List<dynamic>.from(generatedConversions!.map((x) => x)),
//     "responsive_images": responsiveImages == null
//         ? []
//         : List<dynamic>.from(responsiveImages!.map((x) => x)),
//     "order_column": orderColumn,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "localUrl": localUrl,
//     "original_url": originalUrl,
//     "preview_url": previewUrl,
//   };

//   @override
//   // TODO: implement props
//   List<Object?> get props => [
//     id,
//     modelId,
//     uuid,
//     name,
//     fileName,
//     size,
//     manipulations,
//     customProperties,
//     generatedConversions,
//     responsiveImages,
//     orderColumn,
//     createdAt,
//     updatedAt,
//     localUrl,
//     originalUrl,
//   ];
// }

// class Service {
//   final int? id;
//   final int? categoryId;
//   final dynamic image;
//   final int? status;
//   final int? vendorStatus;
//   final int? vendorNotes;
//   final int? sorting;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final dynamic deletedAt;
//   final String? name;
//   final GetSliderName? getServiceName;

//   Service({
//     this.id,
//     this.categoryId,
//     this.image,
//     this.status,
//     this.vendorStatus,
//     this.vendorNotes,
//     this.sorting,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.name,
//     this.getServiceName,
//   });

//   factory Service.fromJson(Map<String, dynamic> json) => Service(
//     id: json["id"],
//     categoryId: json["category_id"],
//     image: json["image"],
//     status: json["status"],
//     vendorStatus: json["vendor_status"],
//     vendorNotes: json["vendor_notes"],
//     sorting: json["sorting"],
//     createdAt: json["created_at"] == null
//         ? null
//         : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null
//         ? null
//         : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     name: json["name"],
//     getServiceName: json["get_service_name"] == null
//         ? null
//         : GetSliderName.fromJson(json["get_service_name"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "category_id": categoryId,
//     "image": image,
//     "status": status,
//     "vendor_status": vendorStatus,
//     "vendor_notes": vendorNotes,
//     "sorting": sorting,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//     "name": name,
//     "get_service_name": getServiceName?.toJson(),
//   };
// }

// class GetSliderName {
//   final int? id;
//   final int? serviceId;
//   final String? name;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? sliderId;

//   GetSliderName({
//     this.id,
//     this.serviceId,
//     this.name,
//     this.createdAt,
//     this.updatedAt,
//     this.sliderId,
//   });

//   factory GetSliderName.fromJson(Map<String, dynamic> json) => GetSliderName(
//     id: json["id"],
//     serviceId: json["service_id"],
//     name: json["name"],
//     createdAt: json["created_at"] == null
//         ? null
//         : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null
//         ? null
//         : DateTime.parse(json["updated_at"]),
//     sliderId: json["slider_id"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "service_id": serviceId,
//     "name": name,
//     "language": languageValues.reverse[language],
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "slider_id": sliderId,
//   };
// }

// class Slider {
//   final int? id;
//   final dynamic type;
//   final dynamic url;
//   final String? image;
//   final int? status;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final dynamic deletedAt;
//   final String? name;
//   final List<GetSliderName>? sliderTranslation;
//   final GetSliderName? getSliderName;

//   Slider({
//     this.id,
//     this.type,
//     this.url,
//     this.image,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.name,
//     this.sliderTranslation,
//     this.getSliderName,
//   });

//   factory Slider.fromJson(Map<String, dynamic> json) => Slider(
//     id: json["id"],
//     type: json["type"],
//     url: json["url"],
//     image: json["image"],
//     status: json["status"],
//     createdAt: json["created_at"] == null
//         ? null
//         : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null
//         ? null
//         : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     name: json["name"],
//     sliderTranslation: json["slider_translation"] == null
//         ? []
//         : List<GetSliderName>.from(
//             json["slider_translation"]!.map((x) => GetSliderName.fromJson(x)),
//           ),
//     getSliderName: json["get_slider_name"] == null
//         ? null
//         : GetSliderName.fromJson(json["get_slider_name"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "type": type,
//     "url": url,
//     "image": image,
//     "status": status,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//     "name": name,
//     "slider_translation": sliderTranslation == null
//         ? []
//         : List<dynamic>.from(sliderTranslation!.map((x) => x.toJson())),
//     "get_slider_name": getSliderName?.toJson(),
//   };
// }

// class Trip {
//   final int? id;
//   final String? logo;
//   final dynamic image;
//   final int? status;
//   final int? serviceId;
//   final int? clientId;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final dynamic deletedAt;
//   final int? adminStatus;
//   final List<Image>? images;
//   final String? name;
//   final Description? description;
//   final int? rating;
//   final Client? client;
//   final Service? service;
//   final List<Media>? media;
//   final Get? getTripName;
//   final Get? getTripDescription;

//   Trip({
//     this.id,
//     this.logo,
//     this.image,
//     this.status,
//     this.serviceId,
//     this.clientId,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.adminStatus,
//     this.images,
//     this.name,
//     this.description,
//     this.rating,
//     this.client,
//     this.service,
//     this.media,
//     this.getTripName,
//     this.getTripDescription,
//   });

//   factory Trip.fromJson(Map<String, dynamic> json) => Trip(
//     id: json["id"],
//     logo: json["logo"],
//     image: json["image"],
//     status: json["status"],
//     serviceId: json["service_id"],
//     clientId: json["client_id"],
//     createdAt: json["created_at"] == null
//         ? null
//         : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null
//         ? null
//         : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     adminStatus: json["adminStatus"],
//     images: json["images"] == null
//         ? []
//         : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
//     name: json["name"],
//     description: descriptionValues.map[json["description"]]!,
//     rating: json["rating"],
//     client: json["client"] == null ? null : Client.fromJson(json["client"]),
//     service: json["service"] == null ? null : Service.fromJson(json["service"]),
//     media: json["media"] == null
//         ? []
//         : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
//     getTripName: json["get_trip_name"] == null
//         ? null
//         : Get.fromJson(json["get_trip_name"]),
//     getTripDescription: json["get_trip_description"] == null
//         ? null
//         : Get.fromJson(json["get_trip_description"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "logo": logo,
//     "image": image,
//     "status": status,
//     "service_id": serviceId,
//     "client_id": clientId,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//     "adminStatus": adminStatus,
//     "images": images == null
//         ? []
//         : List<dynamic>.from(images!.map((x) => x.toJson())),
//     "name": name,
//     "description": descriptionValues.reverse[description],
//     "rating": rating,
//     "client": client?.toJson(),
//     "service": service?.toJson(),
//     "media": media == null
//         ? []
//         : List<dynamic>.from(media!.map((x) => x.toJson())),
//     "get_trip_name": getTripName?.toJson(),
//     "get_trip_description": getTripDescription?.toJson(),
//   };
// }

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
