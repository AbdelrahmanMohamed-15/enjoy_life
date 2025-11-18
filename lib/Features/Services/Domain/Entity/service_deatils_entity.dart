import 'package:equatable/equatable.dart';

class ServiceDetailsEntity extends Equatable {
  final ServiceData? data;
  final String? message;
  final int? status;

  const ServiceDetailsEntity({this.data, this.message, this.status});

  factory ServiceDetailsEntity.fromJson(Map<String, dynamic> json) =>
      ServiceDetailsEntity(
        data: json["data"] == null ? null : ServiceData.fromJson(json["data"]),
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

class ServiceData extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? phone;
  final String? address;
  final String? latitude;
  final String? longitude;
  final double? avarageRating;
  final String? logo;
  final List<Image>? images;
  final List<ServiceBranch>? serviceBranches;
  final List<RateEntity>? rates;

  const ServiceData({
    this.id,
    this.name,
    this.description,
    this.phone,
    this.address,
    this.latitude,
    this.longitude,
    this.avarageRating,
    this.logo,
    this.images,
    this.serviceBranches,
    this.rates,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    phone: json["phone"] ?? "",
    address: json["address"] ?? "",
    latitude: json["latitude"] ?? "",
    longitude: json["longitude"] ?? "",
    avarageRating: double.parse((json["avarage_rating"] ?? '0.0').toString()),
    logo: json["logo"] ?? "",
    images: json["images"] == null
        ? []
        : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    serviceBranches: json["serviceBranches"] == null
        ? []
        : List<ServiceBranch>.from(
            json["serviceBranches"]!.map((x) => ServiceBranch.fromJson(x)),
          ),
    rates: json["rates"] == null
        ? []
        : List<RateEntity>.from(
            json["rates"]!.map((x) => RateEntity.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "phone": phone,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "avarage_rating": avarageRating,
    "logo": logo,
    "images": images == null
        ? []
        : List<dynamic>.from(images!.map((x) => x.toJson())),
    "serviceBranches": serviceBranches == null
        ? []
        : List<dynamic>.from(serviceBranches!.map((x) => x.toJson())),
    "rates": rates == null
        ? []
        : List<dynamic>.from(rates!.map((x) => x.toJson())),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    description,
    phone,
    address,
    latitude,
    longitude,
    avarageRating,
    logo,
    images,
    serviceBranches,
    rates,
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

class ServiceBranch extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final Service? service;
  final Branch? branch;
  final String? price;
  final String? icgDiscount;
  final String? discount;
  final ServiceBranchCategory? serviceBranchCategory;
  final String? image;
  final List<ServiceBranchOption>? serviceBranchOptions;

  ServiceBranch({
    this.id,
    this.name,
    this.description,
    this.service,
    this.branch,
    this.price,
    this.icgDiscount,
    this.discount,
    this.serviceBranchCategory,
    this.image,
    this.serviceBranchOptions,
  });

  factory ServiceBranch.fromJson(Map<String, dynamic> json) => ServiceBranch(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
    price: json["price"].toString(),
    icgDiscount: json["icg_discount"].toString(),
    discount: json["discount"].toString(),
    serviceBranchCategory: json["serviceBranchCategory"] == null
        ? null
        : ServiceBranchCategory.fromJson(json["serviceBranchCategory"]),
    image: json["image"],
    serviceBranchOptions: json["serviceBranchOptions"] == null
        ? []
        : List<ServiceBranchOption>.from(
            json["serviceBranchOptions"]!.map(
              (x) => ServiceBranchOption.fromJson(x),
            ),
          ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "service": service?.toJson(),
    "branch": branch?.toJson(),
    "price": price,
    "icg_discount": icgDiscount,
    "discount": discount,
    "serviceBranchCategory": serviceBranchCategory?.toJson(),
    "image": image,
    "serviceBranchOptions": serviceBranchOptions == null
        ? []
        : List<dynamic>.from(serviceBranchOptions!.map((x) => x.toJson())),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    description,
    service,
    branch,
    price,
    icgDiscount,
    discount,
    serviceBranchCategory,
    image,
    serviceBranchOptions,
  ];
}

class Branch extends Equatable {
  final int? id;
  final String? address;
  final String? logo;
  final String? phone;
  final String? image;
  final String? latitude;
  final String? longitude;
  final int? status;
  final String? deliveryPrice;
  final int? delivery;
  final int? clientId;
  final int? adminStatus;
  final String? name;
  final GetName? getbranchName;

  Branch({
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
    this.adminStatus,
    this.name,
    this.getbranchName,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["id"] ?? 0,
    address: json["address"] ?? "",
    logo: json["logo"] ?? "",
    phone: json["phone"] ?? "",
    image: json["image"] ?? "",
    latitude: json["latitude"] ?? "",
    longitude: json["longitude"] ?? "",
    status: json["status"] ?? 0,
    deliveryPrice: json["delivery_price"].toString(),
    delivery: json["delivery"] ?? 0,
    clientId: json["client_id"] ?? 0,
    adminStatus: json["adminStatus"] ?? 0,
    name: json["name"] ?? "",
    getbranchName: json["getbranch_name"] == null
        ? null
        : GetName.fromJson(json["getbranch_name"]),
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
    adminStatus,
    name,
    getbranchName,
  ];
}

class GetName extends Equatable {
  final int? id;
  final int? branchId;
  final String? name;
  final String? language;
  final int? serviceId;
  final int? serviceBranchCategoryId;

  GetName({
    this.id,
    this.branchId,
    this.name,
    this.language,
    this.serviceId,
    this.serviceBranchCategoryId,
  });

  factory GetName.fromJson(Map<String, dynamic> json) => GetName(
    id: json["id"] ?? 0,
    branchId: json["branch_id"] ?? 0,
    name: json["name"] ?? "",
    language: json["language"] ?? "",
    serviceId: json["service_id"] ?? 0,
    serviceBranchCategoryId: json["service_branch_category_id"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branch_id": branchId,
    "name": name,
    "language": language,
    "service_id": serviceId,
    "service_branch_category_id": serviceBranchCategoryId,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    branchId,
    name,
    language,
    serviceId,
    serviceBranchCategoryId,
  ];
}

class Service extends Equatable {
  final int? id;
  final int? categoryId;
  final String? image;
  final int? status;
  final int? vendorStatus;
  final int? vendorNotes;
  final int? sorting;
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
    name: json["name"] ?? "",
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
    name,
    getServiceName,
  ];
}

class ServiceBranchCategory extends Equatable {
  final int? id;
  final int? clientId;
  final int? status;
  final String? name;
  final GetName? getServiceBranchCategoryName;

  const ServiceBranchCategory({
    this.id,
    this.clientId,
    this.status,
    this.name,
    this.getServiceBranchCategoryName,
  });

  factory ServiceBranchCategory.fromJson(Map<String, dynamic> json) =>
      ServiceBranchCategory(
        id: json["id"] ?? 0,
        clientId: json["client_id"] ?? 0,
        status: json["status"] ?? 0,
        name: json["name"] ?? "",
        getServiceBranchCategoryName:
            json["get_service_branch_category_name"] == null
            ? null
            : GetName.fromJson(json["get_service_branch_category_name"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "status": status,
    "name": name,
    "get_service_branch_category_name": getServiceBranchCategoryName?.toJson(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    clientId,
    status,
    name,
    getServiceBranchCategoryName,
  ];
}

class ServiceBranchOption extends Equatable {
  final int? id;
  final String? name;
  final int? price;
  final int? icgDiscount;
  final int? discount;

  ServiceBranchOption({
    this.id,
    this.name,
    this.price,
    this.icgDiscount,
    this.discount,
  });

  factory ServiceBranchOption.fromJson(Map<String, dynamic> json) =>
      ServiceBranchOption(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        icgDiscount: json["icg_discount"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "icg_discount": icgDiscount,
    "discount": discount,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, price, icgDiscount, discount];
}

class RateEntity extends Equatable {
  final int? id;
  final String? rating;
  final String? comment;
  final int? clientId;
  final String? clientName;
  final String? clientImage;

  RateEntity({
    this.id,
    this.rating,
    this.comment,
    this.clientId,
    this.clientName,
    this.clientImage,
  });

  factory RateEntity.fromJson(Map<String, dynamic> json) => RateEntity(
    id: json["id"] ?? 0,
    rating: json["rating"].toString(),
    comment: json["comment"] ?? "",
    clientId: json["client_id"] ?? 0,
    clientName: json["client_name"] ?? "",
    clientImage: json["client_image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "comment": comment,
    "client_id": clientId,
    "client_name": clientName,
    "client_image": clientImage,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    rating,
    comment,
    clientId,
    clientName,
    clientImage,
  ];
}
