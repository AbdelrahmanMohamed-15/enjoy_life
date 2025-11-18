import 'package:equatable/equatable.dart';

class TableEntity extends Equatable {
  final List<TableData>? data;
  final String? message;
  final int? status;

  const TableEntity({this.data, this.message, this.status});

  factory TableEntity.fromJson(Map<String, dynamic> json) => TableEntity(
    data: json["data"] == null
        ? []
        : List<TableData>.from(json["data"]!.map((x) => TableData.fromJson(x))),
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

class TableData extends Equatable {
  final int? id;
  final String? tableNumber;
  final int? capacity;
  final String? description;
  final String? price;
  final String? deposit;

  const TableData({
    this.id,
    this.tableNumber,
    this.capacity,
    this.description,
    this.price,
    this.deposit,
  });

  factory TableData.fromJson(Map<String, dynamic> json) => TableData(
    id: json["id"] ?? 0,
    tableNumber: json["table_number"] ?? "",
    capacity: json["capacity"] ?? 0,
    description: json["description"] ?? "",
    price: json["price"].toString(),
    deposit: json["deposit"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "table_number": tableNumber,
    "capacity": capacity,
    "description": description,
    "price": price,
    "deposit": deposit,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    tableNumber,
    capacity,
    description,
    price,
    deposit,
  ];
}
