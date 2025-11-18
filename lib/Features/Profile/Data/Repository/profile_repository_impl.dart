import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Features/Profile/Data/DataSource/profile_datasource.dart';
import 'package:easy_life/Features/Profile/Domain/Entity/additional_entity.dart';
import 'package:easy_life/Features/Profile/Domain/Entity/profile_entity.dart';
import 'package:easy_life/Features/Profile/Domain/Repository/profile_repository.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Handler/response_code.dart';
import '../../../../Core/Handler/response_message.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatasource profileDatasource;

  ProfileRepositoryImpl({required this.profileDatasource});

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      var result = await profileDatasource.getProfile();
      debugPrint('Cart Response : ${result.data}');
      if (result.statusCode == 200) {
        return Right(ProfileEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      debugPrint('Cart Response : ${dioError.response}');
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
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required FormData formData,
  }) async {
    try {
      var result = await profileDatasource.updateProfile(formData: formData);
      debugPrint('Cart Response : ${result.data}');
      if (result.statusCode == 200) {
        return Right(ProfileEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      debugPrint('Cart Response : ${dioError.response}');
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
  Future<Either<Failure, AdditionalEntity>> getAdditionalPage({
    required String type,
  }) async {
    try {
      var result = await profileDatasource.getAdditionalPage(type: type);
      debugPrint('AdditionalEntity Response : ${result.data}');
      if (result.statusCode == 200) {
        return Right(AdditionalEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } on DioException catch (dioError) {
      debugPrint('Cart Response : ${dioError.response}');
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
