import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Core/Helper/base_entity.dart';
import 'package:easy_life/Features/Reversion/Data/Datasource/reversion_datasource.dart';
import 'package:easy_life/Features/Reversion/Domain/Entities/reversion_entity.dart';
import 'package:easy_life/Features/Reversion/Domain/Repository/reversion_repository.dart';
import 'package:flutter/material.dart';
import '../../../../Core/Handler/response_code.dart';
import '../../../../Core/Handler/response_message.dart';

class ReversionRepositoryImpl implements ReversionRepository {
  final ReversionDatasource reversionDatasource;
  ReversionRepositoryImpl({required this.reversionDatasource});

  @override
  Future<Either<Failure, ReversionEntity>> getReversion({
    required String status,
    required int serviceID,
  }) async {
    try {
      var result = await reversionDatasource.getVendorResturant(
        status: status,
        serviceID: serviceID,
      );
      debugPrint('Get All Reversion Response : ${result.data}');
      if (result.statusCode == 200) {
        return Right(ReversionEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      debugPrint('Get All Reversion Response Error : ${dioError.response}');
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
  Future<Either<Failure, BaseEntity>> scanOrder({
    required String qrCode,
  }) async {
    try {
      var result = await reversionDatasource.scanOrder(qrCode: qrCode);
      debugPrint('Get All Reversion Response : ${result.data}');
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
      debugPrint('Get All Reversion Response Error : ${dioError.response}');
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
