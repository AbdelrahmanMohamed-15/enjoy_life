import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/Cart/Domain/Repository/cart_repository.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Helper/base_entity.dart';

class StoreSessionUsecases {
  final CartRepository cartRepository;

  StoreSessionUsecases({required this.cartRepository});

  Future<Either<Failure, BaseEntity>> storeSession({
    required String session,
  }) async => await cartRepository.storeSession(session: session);
}
