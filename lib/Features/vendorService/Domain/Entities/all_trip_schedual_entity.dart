import 'package:equatable/equatable.dart';

class AllTripScheduleEntity extends Equatable {
  final List<TripScheduleData>? data;
  final String? message;
  final int? status;

  const AllTripScheduleEntity({this.data, this.message, this.status});

  factory AllTripScheduleEntity.fromJson(Map<String, dynamic> json) =>
      AllTripScheduleEntity(
        data: json["data"] == null
            ? []
            : List<TripScheduleData>.from(
                json["data"]!.map((x) => TripScheduleData.fromJson(x)),
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
  List<Object?> get props => [data, message, status];
}

class TripScheduleData extends Equatable {
  final int? id;
  final String? scheduleNumber;
  final String? locationFrom;
  final String? locationTo;
  final DateTime? movingTime;
  final DateTime? returningTime;
  final int? capacity;
  final int? price;
  final int? deposit;
  final int? available;
  final int? status;
  final int? tripId;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? adminStatus;
  final int? branchId;
  final String? description;
  final GetScheduleDescription? getScheduleDescription;

  const TripScheduleData({
    this.id,
    this.scheduleNumber,
    this.locationFrom,
    this.locationTo,
    this.movingTime,
    this.returningTime,
    this.capacity,
    this.price,
    this.deposit,
    this.available,
    this.status,
    this.tripId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.adminStatus,
    this.branchId,
    this.description,
    this.getScheduleDescription,
  });

  factory TripScheduleData.fromJson(Map<String, dynamic> json) =>
      TripScheduleData(
        id: json["id"] ?? 0,
        scheduleNumber: json["schedule_number"] ?? "",
        locationFrom: json["location_from"] ?? "",
        locationTo: json["location_to"] ?? "",
        movingTime: json["moving_time"] == null
            ? null
            : DateTime.parse(json["moving_time"]),
        returningTime: json["returning_time"] == null
            ? null
            : DateTime.parse(json["returning_time"]),
        capacity: json["capacity"] ?? 0,
        price: json["price"] ?? 0,
        deposit: json["deposit"] ?? 0,
        available: json["available"] ?? 0,
        status: json["status"] ?? 0,
        tripId: json["trip_id"] ?? 0,
        deletedAt: json["deleted_at"] ?? 0,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        adminStatus: json["adminStatus"] ?? 0,
        branchId: json["branch_id"] ?? 0,
        description: json["description"] ?? "",
        getScheduleDescription: json["get_schedule_description"] == null
            ? null
            : GetScheduleDescription.fromJson(json["get_schedule_description"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "schedule_number": scheduleNumber,
    "location_from": locationFrom,
    "location_to": locationTo,
    "moving_time": movingTime?.toIso8601String(),
    "returning_time": returningTime?.toIso8601String(),
    "capacity": capacity,
    "price": price,
    "deposit": deposit,
    "available": available,
    "status": status,
    "trip_id": tripId,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "adminStatus": adminStatus,
    "branch_id": branchId,
    "description": description,
    "get_schedule_description": getScheduleDescription?.toJson(),
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
    available,
    status,
    tripId,
    deletedAt,
    createdAt,
    updatedAt,
    adminStatus,
    branchId,
    description,
    getScheduleDescription,
  ];
}

class GetScheduleDescription extends Equatable {
  final int? id;
  final int? tripScheduleId;
  final String? description;
  final String? language;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GetScheduleDescription({
    this.id,
    this.tripScheduleId,
    this.description,
    this.language,
    this.createdAt,
    this.updatedAt,
  });

  factory GetScheduleDescription.fromJson(Map<String, dynamic> json) =>
      GetScheduleDescription(
        id: json["id"] ?? 0,
        tripScheduleId: json["trip_schedule_id"] ?? 0,
        description: json["description"] ?? "",
        language: json["language"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trip_schedule_id": tripScheduleId,
    "description": description,
    "language": language,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    tripScheduleId,
    description,
    language,
    createdAt,
    updatedAt,
  ];
}
