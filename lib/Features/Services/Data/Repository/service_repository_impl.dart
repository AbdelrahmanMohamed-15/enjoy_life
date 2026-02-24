import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Core/Handler/auth_handler.dart';
import 'package:easy_life/Core/Helper/base_entity.dart';
import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Features/Services/Data/DataSource/service_datasource.dart';
import 'package:easy_life/Features/Services/Domain/Entity/room_entity.dart';
import 'package:easy_life/Features/Services/Domain/Entity/service_deatils_entity.dart';
import 'package:easy_life/Features/Services/Domain/Entity/table_entity.dart';
import 'package:easy_life/Features/Services/Domain/Entity/trip_entity.dart';
import '../../../../Core/Handler/response_code.dart';
import '../../../../Core/Handler/response_message.dart';
import '../../Domain/Repository/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceDatasource serviceDatasource;

  ServiceRepositoryImpl({required this.serviceDatasource});

  @override
  Future<Either<Failure, ServiceDetailsEntity>> getResturantByID({
    required int resturantID,
  }) async {
    try {
      var result = await serviceDatasource.getResturantByID(
        resturantID: resturantID,
      );
      if (result.statusCode == 200) {
        return Right(ServiceDetailsEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      // For libraries like Dio, this will capture HTTP errors
      if (dioError.response != null) {
        // Extract the error message from the response
        final errorMessage =
            dioError.response?.data['message'] ?? 'Unknown error occurred';
        return Left(
          Failure(
            code: dioError.response?.statusCode ?? APIResponseCode.unknown,
            message: errorMessage,
          ),
        );
      } else {
        // Handle network or other unexpected Dio errors
        return Left(
          Failure(
            code: APIResponseCode.noInternetConnection,
            message: dioError.message.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failure, ServiceDetailsEntity>> getHotelByID({
    required int hotelID,
  }) async {
    try {
      var result = await serviceDatasource.getHotelByID(hotelID: hotelID);
      if (result.statusCode == 200) {
        return Right(ServiceDetailsEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      // For libraries like Dio, this will capture HTTP errors
      if (dioError.response != null) {
        // Extract the error message from the response
        final errorMessage =
            dioError.response?.data['message'] ?? 'Unknown error occurred';
        return Left(
          Failure(
            code: dioError.response?.statusCode ?? APIResponseCode.unknown,
            message: errorMessage,
          ),
        );
      } else {
        // Handle network or other unexpected Dio errors
        return Left(
          Failure(
            code: APIResponseCode.noInternetConnection,
            message: dioError.message.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failure, ServiceDetailsEntity>> getTripByID({
    required int tripID,
  }) async {
    try {
      var result = await serviceDatasource.getTripByID(tripID: tripID);
      if (result.statusCode == 200) {
        return Right(ServiceDetailsEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      // For libraries like Dio, this will capture HTTP errors
      if (dioError.response != null) {
        // Extract the error message from the response
        final errorMessage =
            dioError.response?.data['message'] ?? 'Unknown error occurred';
        return Left(
          Failure(
            code: dioError.response?.statusCode ?? APIResponseCode.unknown,
            message: errorMessage,
          ),
        );
      } else {
        // Handle network or other unexpected Dio errors
        return Left(
          Failure(
            code: APIResponseCode.noInternetConnection,
            message: dioError.message.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failure, RoomEntity>> getAvaliableRooms({
    required int hotelID,
    required String startDate,
    required String endDate,
  }) async {
    try {
      var result = await serviceDatasource.getAvaliableRooms(
        hotelID: hotelID,
        startDate: startDate,
        endDate: endDate,
      );
      if (result.statusCode == 200) {
        return Right(RoomEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      // For libraries like Dio, this will capture HTTP errors
      if (dioError.response != null) {
        // Extract the error message from the response
        final errorMessage =
            dioError.response?.data['message'] ?? 'Unknown error occurred';
        return Left(
          Failure(
            code: dioError.response?.statusCode ?? APIResponseCode.unknown,
            message: errorMessage,
          ),
        );
      } else {
        // Handle network or other unexpected Dio errors
        return Left(
          Failure(
            code: APIResponseCode.noInternetConnection,
            message: dioError.message.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failure, TableEntity>> getAvaliableTables({
    required int resturantID,
    required String startDate,
    required String endDate,
  }) async {
    try {
      var result = await serviceDatasource.getAvaliableTables(
        resturantID: resturantID,
        startDate: startDate,
        endDate: endDate,
      );
      if (result.statusCode == 200) {
        return Right(TableEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      // For libraries like Dio, this will capture HTTP errors
      if (dioError.response != null) {
        // Extract the error message from the response
        final errorMessage =
            dioError.response?.data['message'] ?? 'Unknown error occurred';
        return Left(
          Failure(
            code: dioError.response?.statusCode ?? APIResponseCode.unknown,
            message: errorMessage,
          ),
        );
      } else {
        // Handle network or other unexpected Dio errors
        return Left(
          Failure(
            code: APIResponseCode.noInternetConnection,
            message: dioError.message.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failure, BaseEntity>> addToCart({
    required String type,
    int? id,
    int? branchID,
    int? tableID,
    int? roomID,
    int? tripID,
    String? startDate,
    String? endDate,
    int? optionID,
  }) async {
    try {
      var result = await serviceDatasource.addToCart(
        type: type,
        id: id,
        branchID: branchID,
        tableID: tableID,
        roomID: roomID,
        tripID: tripID,
        startDate: startDate,
        endDate: endDate,
        optionID: optionID,
      );
      if (result.statusCode == 200) {
        if (DependencyInjectionHelper()
                .sl<AuthHandlerInterface>()
                .getCookies() ==
            null) {
          final cookieHeader = result.headers['set-cookie']![0];
          DependencyInjectionHelper().sl<AuthHandlerInterface>().setCookies(
            cookieHeader,
          );
        }
        return Right(BaseEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      // For libraries like Dio, this will capture HTTP errors
      if (dioError.response != null) {
        // Extract the error message from the response
        final errorMessage =
            dioError.response?.data['message'] ?? 'Unknown error occurred';
        return Left(
          Failure(
            code: dioError.response?.statusCode ?? APIResponseCode.unknown,
            message: errorMessage,
          ),
        );
      } else {
        // Handle network or other unexpected Dio errors
        return Left(
          Failure(
            code: APIResponseCode.noInternetConnection,
            message: dioError.message.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failure, TripEntity>> getAvaliableTrips({
    required int tripID,
  }) async {
    try {
      var result = await serviceDatasource.getAvaliableTrips(tripsID: tripID);
      if (result.statusCode == 200) {
        return Right(TripEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      // For libraries like Dio, this will capture HTTP errors
      if (dioError.response != null) {
        // Extract the error message from the response
        final errorMessage =
            dioError.response?.data['message'] ?? 'Unknown error occurred';
        return Left(
          Failure(
            code: dioError.response?.statusCode ?? APIResponseCode.unknown,
            message: errorMessage,
          ),
        );
      } else {
        // Handle network or other unexpected Dio errors
        return Left(
          Failure(
            code: APIResponseCode.noInternetConnection,
            message: dioError.message.toString(),
          ),
        );
      }
    }
  }
}
