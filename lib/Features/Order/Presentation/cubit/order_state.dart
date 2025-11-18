part of 'order_cubit.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

// state of pending order
final class OrderPendingLoading extends OrderState {}

final class PendingOrderSuccess extends OrderState {
  final OrderHistoryEntity orderHistoryEntity;
  const PendingOrderSuccess({required this.orderHistoryEntity});

  @override
  List<Object> get props => [orderHistoryEntity];
}

final class PendingOrderFailed extends OrderState {
  final RequestState requestState;
  const PendingOrderFailed({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

// state of Compeleted order
final class OrderCompletedLoading extends OrderState {}

final class CompletedOrderSuccess extends OrderState {
  final OrderHistoryEntity orderHistoryEntity;
  const CompletedOrderSuccess({required this.orderHistoryEntity});

  @override
  List<Object> get props => [orderHistoryEntity];
}

final class CompletedOrderFailed extends OrderState {
  final RequestState requestState;
  const CompletedOrderFailed({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

// state of Cancelled order
final class OrderCancelledLoading extends OrderState {}

final class CancelledOrderSuccess extends OrderState {
  final OrderHistoryEntity orderHistoryEntity;
  const CancelledOrderSuccess({required this.orderHistoryEntity});

  @override
  List<Object> get props => [orderHistoryEntity];
}

final class CancelledOrderFailed extends OrderState {
  final RequestState requestState;
  const CancelledOrderFailed({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

// state of current index
final class CurrentIndexState extends OrderState {
  final int currentIndex;
  const CurrentIndexState({required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}
