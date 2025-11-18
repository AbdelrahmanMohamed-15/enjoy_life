import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Features/Order/Data/Datasource/order_datasource.dart';
import 'package:easy_life/Features/Order/Domain/Entity/order_history_entity.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Handler/response_code.dart';
import '../../../../Core/Handler/response_message.dart';
import '../../Domain/Repository/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDatasource orderDatasource;

  OrderRepositoryImpl({required this.orderDatasource});

  @override
  Future<Either<Failure, OrderHistoryEntity>> getCancelledOrders() async {
    try {
      var result = await orderDatasource.getCancelledOrder();
      debugPrint('Cart Response : ${result.data}');
      if (result.statusCode == 200) {
        return Right(OrderHistoryEntity.fromJson(result.data));
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
  Future<Either<Failure, OrderHistoryEntity>> getCompletedOrders() async {
    try {
      var result = await orderDatasource.getCompletedOrder();
      debugPrint('Cart Response : ${result.data}');
      if (result.statusCode == 200) {
        return Right(OrderHistoryEntity.fromJson(result.data));
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
  Future<Either<Failure, OrderHistoryEntity>> getPendingOrders() async {
    try {
      var result = await orderDatasource.getPendingOrder();
      debugPrint('Cart Response : ${result.data}');
      if (result.statusCode == 200) {
        return Right(OrderHistoryEntity.fromJson(result.data));
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
