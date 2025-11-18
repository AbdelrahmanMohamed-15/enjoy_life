import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final Data? data;
  final String? message;
  final int? status;

  CartEntity({this.data, this.message, this.status});

  factory CartEntity.fromJson(Map<String, dynamic> json) => CartEntity(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] ?? '',
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

class Data extends Equatable {
  final List<Item>? items;
  final String? total;

  Data({this.items, this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: json["items"] == null
        ? []
        : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    total: json["total"] ?? '0.0',
  );

  Map<String, dynamic> toJson() => {
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "total": total,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [items, total];
}

class Item extends Equatable {
  final String? rowId;
  final int? id;
  final String? name;
  final int? qty;
  final String? price;
  final Options? options;
  final String? tax;
  final bool? isSaved;
  final String? subtotal;

  Item({
    this.rowId,
    this.id,
    this.name,
    this.qty,
    this.price,
    this.options,
    this.tax,
    this.isSaved,
    this.subtotal,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    rowId: json["rowId"] ?? '',
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    qty: json["qty"] ?? 0,
    price: json["price"].toString(),
    options: json["options"] == null ? null : Options.fromJson(json["options"]),
    tax: json["tax"] ?? '',
    isSaved: json["isSaved"] ?? false,
    subtotal: json["subtotal"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "rowId": rowId,
    "id": id,
    "name": name,
    "qty": qty,
    "price": price,
    "options": options?.toJson(),
    "tax": tax,
    "isSaved": isSaved,
    "subtotal": subtotal,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    rowId,
    id,
    name,
    qty,
    price,
    options,
    tax,
    isSaved,
    subtotal,
  ];
}

class Options extends Equatable {
  final int? discount;
  final String? delivery;
  final String? startTime;
  final String? endTime;
  final String? totalPrice;
  final int? branchId;
  final String? itemType;
  final String? description;
  final String? image;

  Options({
    this.discount,
    this.delivery,
    this.startTime,
    this.endTime,
    this.totalPrice,
    this.branchId,
    this.itemType,
    this.description,
    this.image,
  });

  factory Options.fromJson(Map<String, dynamic> json) => Options(
    discount: json["discount"] ?? 0,
    delivery: json["delivery"] ?? '',
    startTime: json["start_time"] ?? '',
    endTime: json["end_time"] ?? '',
    totalPrice: json["total_price"].toString(),
    branchId: json["branch_id"] ?? 0,
    itemType: json["item_type"] ?? '',
    description: json["description"] ?? '',
    image: json["image"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "discount": discount,
    "delivery": delivery,
    "start_time": startTime,
    "end_time": endTime,
    "total_price": totalPrice,
    "branch_id": branchId,
    "item_type": itemType,
    "description": description,
    "image": image,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    discount,
    delivery,
    startTime,
    endTime,
    totalPrice,
    branchId,
    itemType,
    description,
    image,
  ];
}
