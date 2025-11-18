import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/Cart/Domain/Repository/cart_repository.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Helper/base_entity.dart';

class CreateOrderUsecases {
  final CartRepository cartRepository;
  CreateOrderUsecases({required this.cartRepository});
  Future<Either<Failure, BaseEntity>> call() async =>
      await cartRepository.createOrder();
}
