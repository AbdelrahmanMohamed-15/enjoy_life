import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/Cart/Domain/Repository/cart_repository.dart';

import '../../../../Core/Failures/failures.dart';
import '../Entity/cart_entity.dart';

class GetCartUsecases {
  final CartRepository cartRepository;
  GetCartUsecases({required this.cartRepository});

  Future<Either<Failure, CartEntity>> call() async {
    return await cartRepository.getCart();
  }
}
