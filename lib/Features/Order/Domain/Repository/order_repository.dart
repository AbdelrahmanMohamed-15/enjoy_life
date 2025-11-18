import 'package:dartz/dartz.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Features/Order/Domain/Entity/order_history_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderHistoryEntity>> getPendingOrders();

  Future<Either<Failure, OrderHistoryEntity>> getCompletedOrders();

  Future<Either<Failure, OrderHistoryEntity>> getCancelledOrders();
}
