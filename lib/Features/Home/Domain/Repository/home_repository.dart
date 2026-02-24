import 'package:dartz/dartz.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Features/Home/Domain/Entity/resturant_entity.dart';
import 'package:easy_life/Features/Home/Domain/Entity/search_entity.dart';
import '../Entity/slider_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, SliderEntity>> getSliders();

  Future<Either<Failure, HomeEntity>> getResturants();

  Future<Either<Failure, HomeEntity>> getHotels();

  Future<Either<Failure, HomeEntity>> getTrips();

  Future<Either<Failure, HomeEntity>> getVendorResturants();

  Future<Either<Failure, HomeEntity>> getVendorHotels();

  Future<Either<Failure, HomeEntity>> getVendorTrips();

  Future<Either<Failure, HomeEntity>> getAllFavourite();

  Future<Either<Failure, HomeEntity>> getAllHome({required String type});

  Future<Either<Failure, SearchEntity>> search({required String query});

  Future<Either<Failure, bool>> addFavourite({
    required int id,
    required String type,
  });

  Future<Either<Failure, bool>> removeFavourite({
    required int id,
    required String type,
  });
}
