import 'package:dartz/dartz.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Helper/base_entity.dart';
import '../Repository/cart_repository.dart';

class RemoveItemCartUsecases {
  final CartRepository cartRepository;
  RemoveItemCartUsecases({required this.cartRepository});
  Future<Either<Failure, BaseEntity>> call({required String rowID}) async =>
      await cartRepository.removeItemFromCart(rowID: rowID);
}
