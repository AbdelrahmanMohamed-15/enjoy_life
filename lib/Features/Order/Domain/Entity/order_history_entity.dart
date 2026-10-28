import 'package:equatable/equatable.dart';

class OrderHistoryEntity extends Equatable {
  final List<OrderHistoryData>? data;
  final String? message;
  final int? status;

  const OrderHistoryEntity({this.data, this.message, this.status});

  factory OrderHistoryEntity.fromJson(Map<String, dynamic> json) =>
      OrderHistoryEntity(
        data: json["data"] == null
            ? []
            : List<OrderHistoryData>.from(
                json["data"]!.map((x) => OrderHistoryData.fromJson(x)),
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
  // TODO: implement props
  List<Object?> get props => [data, message, status];
}

class OrderHistoryData extends Equatable {
  final int? id;
  final String? status;
  final String? orderCode;
  final int? clientId;
  final String? clientName;
  final int? totalPrice;
  final String? paymentType;
  final String? address;
  final int? couponId;
  final String? couponType;
  final int? couponDiscount;
  final int? shippingFees;
  final int? taxesFees;
  final int? pointPrice;
  final String? createdAt;
  final int? itemsCount;
  final List<Item>? items;

  OrderHistoryData({
    this.id,
    this.status,
    this.orderCode,
    this.clientId,
    this.clientName,
    this.totalPrice,
    this.paymentType,
    this.address,
    this.couponId,
    this.couponType,
    this.couponDiscount,
    this.shippingFees,
    this.taxesFees,
    this.pointPrice,
    this.createdAt,
    this.itemsCount,
    this.items,
  });

  factory OrderHistoryData.fromJson(Map<String, dynamic> json) =>
      OrderHistoryData(
        id: json["id"] ?? 0,
        status: json["status"] ?? "",
        orderCode: json["order_code"] ?? "",
        clientId: json["client_id"] ?? 0,
        clientName: json["client_name"] ?? "",
        totalPrice: json["total_price"] ?? 0,
        paymentType: json["payment_type"] ?? "",
        address: json["address"] ?? "",
        couponId: json["coupon_id"] ?? 0,
        couponType: json["coupon_type"] ?? "",
        couponDiscount: json["coupon_discount"] ?? 0,
        shippingFees: json["shipping_fees"] ?? 0,
        taxesFees: json["taxes_fees"] ?? 0,
        pointPrice: json["point_price"] ?? 0,
        createdAt: json["created_at"] ?? "",
        itemsCount: json["items_count"] ?? 0,
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "order_code": orderCode,
    "client_id": clientId,
    "client_name": clientName,
    "total_price": totalPrice,
    "payment_type": paymentType,
    "address": address,
    "coupon_id": couponId,
    "coupon_type": couponType,
    "coupon_discount": couponDiscount,
    "shipping_fees": shippingFees,
    "taxes_fees": taxesFees,
    "point_price": pointPrice,
    "created_at": createdAt,
    "items_count": itemsCount,
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    status,
    orderCode,
    clientId,
    clientName,
    totalPrice,
    paymentType,
    address,
    couponId,
    couponType,
    couponDiscount,
    shippingFees,
    taxesFees,
    pointPrice,
    createdAt,
    itemsCount,
    items,
  ];
}

class Item extends Equatable {
  final int? id;
  final int? price;
  final int? discount;
  final int? delivery;
  final String? totalPrice;
  final String? hourPrice;
  final String? nightPrice;
  final String? startTime;
  final String? endTime;
  final String? type;
  final bool? isServiceOptions;
  final String? name;
  final String? service;
  final String? branch;
  final String? restaurantTable;
  final String? restaurant;
  final String? hotemRoom;
  final String? hotel;
  final String? tripSchedule;
  final String? trip;
  final String? providerType;
  final String? providerName;
  final String? providerImage;

  Item({
    this.id,
    this.price,
    this.discount,
    this.delivery,
    this.totalPrice,
    this.hourPrice,
    this.nightPrice,
    this.startTime,
    this.endTime,
    this.type,
    this.isServiceOptions,
    this.name,
    this.service,
    this.branch,
    this.restaurantTable,
    this.restaurant,
    this.hotemRoom,
    this.hotel,
    this.tripSchedule,
    this.trip,
    this.providerType,
    this.providerName,
    this.providerImage,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: _asInt(json["id"]),
    price: _asInt(json["price"]),
    discount: _asInt(json["discount"]),
    delivery: _asInt(json["delivery"]),
    totalPrice: _asString(json["total_price"]),
    hourPrice: _asString(json["hour_price"]),
    nightPrice: _asString(json["night_price"]),
    startTime: _asString(json["start_time"]),
    endTime: _asString(json["end_time"]),
    type: _asString(json["type"]),
    isServiceOptions: json["is_service_options"] == true,
    name: _asString(json["name"]),
    service: _asString(json["service"]),
    branch: _asString(json["branch"]),
    restaurantTable: _asString(
      json["restaurantTable"] ?? json["restaurant_table"],
    ),
    restaurant: _asString(json["restaurant"]),
    hotemRoom: _asString(json["hotemRoom"] ?? json["hotel_room"]),
    hotel: _asString(json["hotel"]),
    tripSchedule: _asString(json["tripSchedule"] ?? json["trip_schedule"]),
    trip: _asString(json["trip"]),
    providerType: _asString(json["provider_type"]),
    providerName: _asString(json["provider_name"]),
    providerImage: _asString(json["provider_image"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "discount": discount,
    "delivery": delivery,
    "total_price": totalPrice,
    "hour_price": hourPrice,
    "night_price": nightPrice,
    "start_time": startTime,
    "end_time": endTime,
    "type": type,
    "is_service_options": isServiceOptions,
    "name": name,
    "service": service,
    "branch": branch,
    "restaurantTable": restaurantTable,
    "restaurant": restaurant,
    "hotemRoom": hotemRoom,
    "hotel": hotel,
    "tripSchedule": tripSchedule,
    "trip": trip,
    "provider_type": providerType,
    "provider_name": providerName,
    "provider_image": providerImage,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    price,
    discount,
    delivery,
    totalPrice,
    hourPrice,
    nightPrice,
    startTime,
    endTime,
    type,
    isServiceOptions,
    name,
    service,
    branch,
    restaurantTable,
    restaurant,
    hotemRoom,
    hotel,
    tripSchedule,
    trip,
    providerType,
    providerName,
    providerImage,
  ];
}

String _asString(dynamic value) {
  if (value == null) return '';
  if (value is String) return value;
  if (value is Map) {
    final name = value['name'] ?? value['title'] ?? value['label'];
    return name?.toString() ?? '';
  }
  return value.toString();
}

int _asInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}
