import 'package:equatable/equatable.dart';

class TripEntity extends Equatable {
  final List<TripData>? data;
  final String? message;
  final int? status;

  const TripEntity({this.data, this.message, this.status});

  factory TripEntity.fromJson(Map<String, dynamic> json) => TripEntity(
    data: json["data"] == null
        ? []
        : List<TripData>.from(json["data"]!.map((x) => TripData.fromJson(x))),
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
  List<Object?> get props => [data, message, status];
}

class TripData extends Equatable {
  final int? id;
  final String? scheduleNumber;
  final String? locationFrom;
  final String? locationTo;
  final String? movingTime;
  final String? returningTime;
  final int? capacity;
  final String? price;
  final String? deposit;

  const TripData({
    this.id,
    this.scheduleNumber,
    this.locationFrom,
    this.locationTo,
    this.movingTime,
    this.returningTime,
    this.capacity,
    this.price,
    this.deposit,
  });

  factory TripData.fromJson(Map<String, dynamic> json) => TripData(
    id: json["id"] ?? 0,
    scheduleNumber: json["schedule_number"] ?? '',
    locationFrom: json["location_from"] ?? '',
    locationTo: json["location_to"] ?? '',
    movingTime: json["moving_time"] ?? '',
    returningTime: json["returning_time"] ?? '',
    capacity: json["capacity"] ?? 0,
    price: json["price"].toString(),
    deposit: json["deposit"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "schedule_number": scheduleNumber,
    "location_from": locationFrom,
    "location_to": locationTo,
    "moving_time": movingTime,
    "returning_time": returningTime,
    "capacity": capacity,
    "price": price,
    "deposit": deposit,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    scheduleNumber,
    locationFrom,
    locationTo,
    movingTime,
    returningTime,
    capacity,
    price,
    deposit,
  ];
}
