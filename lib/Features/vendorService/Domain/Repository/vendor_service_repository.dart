import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_life/Core/Helper/base_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_branch_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_category_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_service_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_trip_schedual_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/hotel_details_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/resturant_deatils_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/trip_details_entity.dart';

import '../../../../Core/Failures/failures.dart';

abstract class VendorServiceRepository {
  Future<Either<Failure, BaseEntity>> createCategory({
    required FormData formData,
  });
  Future<Either<Failure, BaseEntity>> createBranch({
    required FormData formData,
  });

  Future<Either<Failure, AllBranchEntity>> getAllBranches();

  Future<Either<Failure, AllCategoryEntity>> getAllCategory();

  Future<Either<Failure, AllTripScheduleEntity>> getAllTripSchedule();

  Future<Either<Failure, BaseEntity>> createResturant({
    required FormData formData,
    required bool isEdit,
    int? id,
  });

  Future<Either<Failure, BaseEntity>> createHotel({
    required FormData formData,
    required bool isEdit,
    int? id,
  });

  Future<Either<Failure, BaseEntity>> createTrip({
    required FormData formData,
    required bool isEdit,
    int? id,
  });

  Future<Either<Failure, ResturantDeatilsEntity>> showResturant({
    required int id,
  });

  Future<Either<Failure, HotelDetailsEntity>> showHotel({required int id});

  Future<Either<Failure, TripDetailsEntity>> showTrip({required int id});

  Future<Either<Failure, AllServiceEntity>> getAllService();

  Future<Either<Failure, BaseEntity>> createService({
    required FormData formData,
  });

  Future<Either<Failure, BaseEntity>> createServiceOtion({
    required FormData formData,
  });
}
