import 'package:dartz/dartz.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Core/Helper/base_entity.dart';
import 'package:easy_life/Features/Cart/Domain/Repository/cart_repository.dart';

class UpdateItemQuantityUsecases {
  final CartRepository cartRepository;

  UpdateItemQuantityUsecases({required this.cartRepository});

  Future<Either<Failure, BaseEntity>> call({
    required String rowID,
    required String quantity,
  }) async => await cartRepository.updateCartItemQuantity(
    rowID: rowID,
    quantity: quantity,
  );
}
