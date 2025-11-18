import 'package:dartz/dartz.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Core/Helper/base_entity.dart';
import 'package:easy_life/Features/Cart/Domain/Entity/cart_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>> getCart();

  Future<Either<Failure, BaseEntity>> updateCartItemQuantity({
    required String rowID,
    required String quantity,
  });

  Future<Either<Failure, BaseEntity>> removeItemFromCart({
    required String rowID,
  });

  Future<Either<Failure, BaseEntity>> createOrder();

  Future<Either<Failure, BaseEntity>> storeSession({required String session});
}
