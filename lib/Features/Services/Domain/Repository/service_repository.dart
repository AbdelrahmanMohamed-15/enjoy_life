import 'package:dartz/dartz.dart';
import 'package:easy_life/Core/Helper/base_entity.dart';
import 'package:easy_life/Features/Services/Domain/Entity/room_entity.dart';
import 'package:easy_life/Features/Services/Domain/Entity/table_entity.dart';
import 'package:easy_life/Features/Services/Domain/Entity/trip_entity.dart';

import '../../../../Core/Failures/failures.dart';
import '../Entity/service_deatils_entity.dart';

abstract class ServiceRepository {
  Future<Either<Failure, ServiceDetailsEntity>> getResturantByID({
    required int resturantID,
  });

  Future<Either<Failure, ServiceDetailsEntity>> getHotelByID({
    required int hotelID,
  });

  Future<Either<Failure, ServiceDetailsEntity>> getTripByID({
    required int tripID,
  });

  Future<Either<Failure, TableEntity>> getAvaliableTables({
    required int resturantID,
    required String startDate,
    required String endDate,
  });

  Future<Either<Failure, RoomEntity>> getAvaliableRooms({
    required int hotelID,
    required String startDate,
    required String endDate,
  });

  Future<Either<Failure, TripEntity>> getAvaliableTrips({required int tripID});

  Future<Either<Failure, BaseEntity>> addToCart({
    required String type,
    int? id,
    int? branchID,
    int? tableID,
    int? roomID,
    int? tripID,
    String? startDate,
    String? endDate,
  });
}
