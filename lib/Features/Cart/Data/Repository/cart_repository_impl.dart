import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Core/Helper/base_entity.dart';
import 'package:easy_life/Features/Cart/Domain/Entity/cart_entity.dart';
import 'package:easy_life/Features/Cart/Domain/Repository/cart_repository.dart';
import 'package:flutter/widgets.dart';

import '../../../../Core/Handler/response_code.dart';
import '../../../../Core/Handler/response_message.dart';
import '../DataSource/cart_datasource.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDatasource cartDatasource;
  CartRepositoryImpl({required this.cartDatasource});

  @override
  Future<Either<Failure, CartEntity>> getCart() async {
    try {
      var result = await cartDatasource.getCart();
      debugPrint('Cart Response : ${result.data}');
      if (result.statusCode == 200) {
        return Right(CartEntity.fromJson(result.data));
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
  Future<Either<Failure, BaseEntity>> removeItemFromCart({
    required String rowID,
  }) async {
    try {
      var result = await cartDatasource.removeCartItem(rowID: rowID);
      debugPrint('Cart Response : ${result.data}');
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
  Future<Either<Failure, BaseEntity>> updateCartItemQuantity({
    required String rowID,
    required String quantity,
  }) async {
    try {
      var result = await cartDatasource.updateCartItemQuantity(
        rowID: rowID,
        quantity: quantity,
      );
      debugPrint('Cart Response : ${result.data}');
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
  Future<Either<Failure, BaseEntity>> createOrder() async {
    try {
      var result = await cartDatasource.createOrder();
      debugPrint('Cart Response : ${result.data}');
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
  Future<Either<Failure, BaseEntity>> storeSession({
    required String session,
  }) async {
    try {
      var result = await cartDatasource.storeSession(session: session);
      debugPrint('Cart Response : ${result.data}');
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
