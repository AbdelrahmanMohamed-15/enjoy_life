class ReversionEntity {
  final List<ReversionData>? data;
  final String? message;
  final int? status;

  ReversionEntity({this.data, this.message, this.status});

  factory ReversionEntity.fromJson(Map<String, dynamic> json) =>
      ReversionEntity(
        data: json["data"] == null
            ? []
            : List<ReversionData>.from(
                json["data"]!.map((x) => ReversionData.fromJson(x)),
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
}

class ReversionData {
  final Order? order;
  final Client? client;
  final List<OrderDetail>? orderDetails;

  ReversionData({this.order, this.client, this.orderDetails});

  factory ReversionData.fromJson(Map<String, dynamic> json) => ReversionData(
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    client: json["client"] == null ? null : Client.fromJson(json["client"]),

    orderDetails: json["order_details"] == null
        ? []
        : List<OrderDetail>.from(
            json["order_details"]!.map((x) => OrderDetail.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "order": order?.toJson(),
    "client": client?.toJson(),
    "order_details": orderDetails == null
        ? []
        : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
  };
}

class Client {
  final int? id;
  final String? fullName;
  final String? phone;
  final String? email;
  final String? image;

  Client({this.id, this.fullName, this.phone, this.email, this.image});

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["id"] ?? 0,
    fullName: json["full_name"] ?? "",
    phone: json["phone"] ?? "",
    email: json["email"] ?? "",
    image: json["image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "phone": phone,
    "email": email,
    "image": image,
  };
}

class Order {
  final int? id;
  final String? orderCode;
  final String? status;
  final String? totalPrice;
  final String? paymentType;
  final String? address;
  final String? shippingFees;
  final String? taxesFees;
  final String? couponDiscount;
  final String? pointPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? image;

  Order({
    this.id,
    this.orderCode,
    this.status,
    this.totalPrice,
    this.paymentType,
    this.address,
    this.shippingFees,
    this.taxesFees,
    this.couponDiscount,
    this.pointPrice,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.image,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"] ?? 0,
    orderCode: json["order_code"] ?? "",
    status: json["status"] ?? "",
    totalPrice: (json["total_price"] ?? 0).toString(),
    paymentType: json["payment_type"],
    address: json["address"],
    shippingFees: (json["shipping_fees"] ?? 0).toString(),
    taxesFees: (json["taxes_fees"] ?? 0).toString(),
    couponDiscount: (json["coupon_discount"] ?? 0).toString(),
    pointPrice: (json["point_price"] ?? 0).toString(),
    createdAt: _asDate(json["created_at"]),
    updatedAt: _asDate(json["updated_at"]),
    name: json["service_name"] ?? "",
    image: json["service_image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_code": orderCode,
    "status": status,
    "total_price": totalPrice,
    "payment_type": paymentType,
    "address": address,
    "shipping_fees": shippingFees,
    "taxes_fees": taxesFees,
    "coupon_discount": couponDiscount,
    "point_price": pointPrice,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "service_name": name,
    "service_image": image,
  };
}

class OrderDetail {
  final int? id;
  final String? price;
  final String? discount;
  final String? delivery;
  final String? totalPrice;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? hourPrice;
  final String? nightPrice;
  final String? status;
  final int? qrcodeApprove;
  final DateTime? qrcodeApprovalDate;
  final String? type;
  final ServiceBranch? serviceBranch;

  OrderDetail({
    this.id,
    this.price,
    this.discount,
    this.delivery,
    this.totalPrice,
    this.startTime,
    this.endTime,
    this.hourPrice,
    this.nightPrice,
    this.status,
    this.qrcodeApprove,
    this.qrcodeApprovalDate,
    this.type,
    this.serviceBranch,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["id"] ?? 0,
    price: (json["price"] ?? 0).toString(),
    discount: (json["discount"] ?? 0).toString(),
    delivery: (json["delivery"] ?? 0).toString(),
    totalPrice: (json["total_price"] ?? 0).toString(),
    startTime: _asDate(json["start_time"]),
    endTime: _asDate(json["end_time"]),
    hourPrice: json["hour_price"]?.toString(),
    nightPrice: json["night_price"]?.toString(),
    status: json["status"] ?? "",
    qrcodeApprove: json["qrcode_approve"] ?? 0,
    qrcodeApprovalDate: _asDate(json["qrcode_approval_date"]),
    type: json["type"] ?? "",
    serviceBranch: json["service_branch"] == null
        ? null
        : ServiceBranch.fromJson(json["service_branch"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "discount": discount,
    "delivery": delivery,
    "total_price": totalPrice,
    "start_time": startTime?.toIso8601String(),
    "end_time": endTime?.toIso8601String(),
    "hour_price": hourPrice,
    "night_price": nightPrice,
    "status": status,
    "qrcode_approve": qrcodeApprove,
    "qrcode_approval_date": qrcodeApprovalDate?.toIso8601String(),
    "type": type,
    "service_branch": serviceBranch?.toJson(),
  };
}

class ServiceBranch {
  final int? id;
  final String? name;
  final String? price;
  final int? status;
  final String? image;

  ServiceBranch({this.id, this.name, this.price, this.status, this.image});

  factory ServiceBranch.fromJson(Map<String, dynamic> json) => ServiceBranch(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    price: (json["price"] ?? 0).toString(),
    status: json["status"] ?? 0,
    image: json["image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "status": status,
    "image": image,
  };
}

class Service {
  final int? id;
  final String? name;

  Service({this.id, this.name});

  factory Service.fromJson(Map<String, dynamic> json) =>
      Service(id: json["id"] ?? 0, name: json["name"] ?? "");

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

/// Parses API dates without throwing on empty or unexpected values.
DateTime? _asDate(dynamic value) {
  if (value == null) return null;
  return DateTime.tryParse(value.toString());
}
