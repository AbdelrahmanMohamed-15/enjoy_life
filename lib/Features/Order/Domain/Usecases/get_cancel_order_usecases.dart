import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/Order/Domain/Repository/order_repository.dart';

import '../../../../Core/Failures/failures.dart';
import '../Entity/order_history_entity.dart';

class GetCancelOrderUsecases {
  final OrderRepository orderRepository;
  GetCancelOrderUsecases({required this.orderRepository});
  Future<Either<Failure, OrderHistoryEntity>> call() async =>
      await orderRepository.getCancelledOrders();
}
