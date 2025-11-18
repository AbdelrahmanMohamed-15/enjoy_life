part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

// state of get Cart

final class CartLoading extends CartState {}

final class SuccessGetCart extends CartState {
  final CartEntity cartEntity;
  const SuccessGetCart({required this.cartEntity});

  @override
  List<Object> get props => [cartEntity];
}

final class ErrorGetCart extends CartState {
  final RequestState requestState;
  const ErrorGetCart({required this.requestState});

  @override
  List<Object> get props => [requestState];
}
