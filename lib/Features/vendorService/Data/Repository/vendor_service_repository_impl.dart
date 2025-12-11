import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Core/Helper/base_entity.dart';
import 'package:easy_life/Features/vendorService/Data/DataSource/vendor_service_datasource.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_branch_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_category_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_service_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_trip_schedual_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/hotel_details_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/resturant_deatils_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/trip_details_entity.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Handler/response_code.dart';
import '../../../../Core/Handler/response_message.dart';
import '../../Domain/Repository/vendor_service_repository.dart';

class VendorServiceRepositoryImpl implements VendorServiceRepository {
  final VendorServiceDatasource vendorServiceDatasource;
  VendorServiceRepositoryImpl({required this.vendorServiceDatasource});

  @override
  Future<Either<Failure, BaseEntity>> createBranch({
    required FormData formData,
  }) async {
    try {
      var result = await vendorServiceDatasource.createBranch(
        formData: formData,
      );
      debugPrint('Create Branch Response : ${result.data}');
      if (result.statusCode == 200) {
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
      debugPrint('Create Branch Response Error : ${dioError.response}');
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
  Future<Either<Failure, BaseEntity>> createCategory({
    required FormData formData,
  }) async {
    try {
      var result = await vendorServiceDatasource.createCategory(
        formData: formData,
      );
      debugPrint('Create Category Response : ${result.data}');
      if (result.statusCode == 200) {
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
      debugPrint('Create Category Response Error : ${dioError.response}');
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
  Future<Either<Failure, AllBranchEntity>> getAllBranches() async {
    try {
      var result = await vendorServiceDatasource.getAllBranch();
      debugPrint('Get All Branches Response : ${result.data}');
      if (result.statusCode == 200) {
        return Right(AllBranchEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      debugPrint('Get All Branches Response Error : ${dioError.response}');
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
  Future<Either<Failure, AllTripScheduleEntity>> getAllTripSchedule() async {
    try {
      var result = await vendorServiceDatasource.getAllTripSchedule();
      debugPrint('Get All Trip Schedule Response : ${result.data}');
      if (result.statusCode == 200) {
        return Right(AllTripScheduleEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      debugPrint('Get All Trip Schedule Response Error : ${dioError.response}');
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
  Future<Either<Failure, BaseEntity>> createHotel({
    required FormData formData,
    required bool isEdit,
    int? id,
  }) async {
    try {
      var result = await vendorServiceDatasource.createHotel(
        formData: formData,
        isEdit: isEdit,
        id: id,
      );
      debugPrint('Create Hotel Response : ${result.data}');
      if (result.statusCode == 200) {
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
      debugPrint('Create Hotel Response Error : ${dioError.response}');
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
  Future<Either<Failure, BaseEntity>> createResturant({
    required FormData formData,
    required bool isEdit,
    int? id,
  }) async {
    try {
      var result = await vendorServiceDatasource.createResturant(
        formData: formData,
        isEdit: isEdit,
        id: id,
      );
      debugPrint('Create Resturant Response : ${result.data}');
      if (result.statusCode == 200) {
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
      debugPrint('Create Resturant Response Error : ${dioError.response}');
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
  Future<Either<Failure, BaseEntity>> createTrip({
    required FormData formData,
    required bool isEdit,
    int? id,
  }) async {
    try {
      var result = await vendorServiceDatasource.createTrip(
        formData: formData,
        isEdit: isEdit,
        id: id,
      );
      debugPrint('Create Trip Response : ${result.data}');
      if (result.statusCode == 200) {
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
      debugPrint('Create Trip Response Error : ${dioError.response}');
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
  Future<Either<Failure, HotelDetailsEntity>> showHotel({
    required int id,
  }) async {
    try {
      var result = await vendorServiceDatasource.showHotel(id: id);
      debugPrint('Show Hotel Response : ${result.data}');
      if (result.statusCode == 200) {
        return Right(HotelDetailsEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      debugPrint('Show Hotel Response Error : ${dioError.response}');
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
  Future<Either<Failure, ResturantDeatilsEntity>> showResturant({
    required int id,
  }) async {
    try {
      var result = await vendorServiceDatasource.showResturant(id: id);
      debugPrint('Show Resturant Response : ${result.data}');
      if (result.statusCode == 200) {
        return Right(ResturantDeatilsEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      debugPrint('Show Resturant Response Error : ${dioError.response}');
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
  Future<Either<Failure, TripDetailsEntity>> showTrip({required int id}) async {
    try {
      debugPrint('Show Trip Response : $id');
      var result = await vendorServiceDatasource.showTrip(id: id);
      debugPrint('Show Trip Response : ${result.data}');
      if (result.statusCode == 200) {
        return Right(TripDetailsEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      debugPrint('Show Trip Response Error : ${dioError.response}');
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
  Future<Either<Failure, AllCategoryEntity>> getAllCategory() async {
    try {
      var result = await vendorServiceDatasource.getAllCategory();
      debugPrint('Show All Category Response : ${result.data}');
      if (result.statusCode == 200) {
        return Right(AllCategoryEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      debugPrint('Show All Category Response Error : ${dioError.response}');
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
  Future<Either<Failure, BaseEntity>> createService({
    required FormData formData,
  }) async {
    try {
      var result = await vendorServiceDatasource.createService(
        formData: formData,
      );
      debugPrint('Create Service Response : ${result.data}');
      if (result.statusCode == 200) {
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
      debugPrint('Create Service Response Error : ${dioError.response}');
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
  Future<Either<Failure, BaseEntity>> createServiceOtion({
    required FormData formData,
  }) async {
    try {
      var result = await vendorServiceDatasource.createServiceOtion(
        formData: formData,
      );
      debugPrint('Create Service Option Response : ${result.data}');
      if (result.statusCode == 200) {
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
      debugPrint('Create Service Option Response Error : ${dioError.response}');
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
  Future<Either<Failure, AllServiceEntity>> getAllService() async {
    try {
      var result = await vendorServiceDatasource.getAllService();
      debugPrint('Get All Service Response : ${result.data}');
      if (result.statusCode == 200) {
        return Right(AllServiceEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      debugPrint('Get All Service Response Error : ${dioError.response}');
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
