import 'package:equatable/equatable.dart';

class RoomEntity extends Equatable {
  final List<RoomData>? data;
  final String? message;
  final int? status;

  const RoomEntity({this.data, this.message, this.status});

  factory RoomEntity.fromJson(Map<String, dynamic> json) => RoomEntity(
    data: json["data"] == null
        ? []
        : List<RoomData>.from(json["data"]!.map((x) => RoomData.fromJson(x))),
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

class RoomData extends Equatable {
  final int? id;
  final String? roomNumber;
  final String? floorNumber;
  final int? capacity;
  final String? description;
  final String? price;
  final String? deposit;

  RoomData({
    this.id,
    this.roomNumber,
    this.floorNumber,
    this.capacity,
    this.description,
    this.price,
    this.deposit,
  });

  factory RoomData.fromJson(Map<String, dynamic> json) => RoomData(
    id: json["id"] ?? 0,
    roomNumber: json["room_number"] ?? "",
    floorNumber: json["floor_number"] ?? "",
    capacity: json["capacity"] ?? 0,
    description: json["description"] ?? "",
    price: json["price"].toString(),
    deposit: json["deposit"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "room_number": roomNumber,
    "floor_number": floorNumber,
    "capacity": capacity,
    "description": description,
    "price": price,
    "deposit": deposit,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    roomNumber,
    floorNumber,
    capacity,
    description,
    price,
    deposit,
  ];
}
