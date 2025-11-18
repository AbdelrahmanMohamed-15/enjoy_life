import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_life/Core/Helper/base_entity.dart';
import 'package:easy_life/Features/Authentication/Data/DataSource/auth_datasource.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Handler/response_code.dart';
import '../../../../Core/Handler/response_message.dart';
import '../../Domain/Entity/user_entity.dart';
import '../../Domain/Repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDatasource;
  AuthRepositoryImpl({required this.authDatasource});

  @override
  Future<Either<Failure, UserEntity>> login({
    required String dailCode,
    required String phone,
    required String password,
  }) async {
    try {
      var result = await authDatasource.login(
        dailCode: dailCode,
        phone: phone,
        password: password,
      );
      if (result.statusCode == 200) {
        return Right(UserEntity.fromJson(result.data));
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
  Future<Either<Failure, BaseEntity>> forgetPassword({
    required String email,
  }) async {
    try {
      var result = await authDatasource.forgetPassword(email: email);
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
  Future<Either<Failure, BaseEntity>> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      var result = await authDatasource.resetPassword(
        email: email,
        password: newPassword,
        confirmPassword: confirmPassword,
      );
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
  Future<Either<Failure, BaseEntity>> verifyResntOTP({
    required String email,
    required String otp,
  }) async {
    try {
      var result = await authDatasource.verifyRestCode(email: email, code: otp);
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
  Future<Either<Failure, BaseEntity>> activeEmail({
    required String code,
    required String email,
  }) async {
    try {
      var result = await authDatasource.activeEmail(code: code, email: email);
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
  Future<Either<Failure, BaseEntity>> register({
    required String dailCode,
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String address,
  }) async {
    try {
      var result = await authDatasource.register(
        dailCode: dailCode,
        name: name,
        email: email,
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
        address: address,
      );
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
