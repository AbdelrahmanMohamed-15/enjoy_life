import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Features/Order/Domain/Entity/order_history_entity.dart';
import 'package:easy_life/Features/Order/Domain/Usecases/get_complete_order_usecases.dart';
import 'package:easy_life/Features/Order/Domain/Usecases/get_pending_order_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/Usecases/get_cancel_order_usecases.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({
    required this.getPendingOrderUsecases,
    required this.getCompleteOrderUsecases,
    required this.getCancelOrderUsecases,
  }) : super(OrderInitial());
  static OrderCubit get(context) => BlocProvider.of(context);

  // Variable of usecases
  final GetPendingOrderUsecases getPendingOrderUsecases;
  final GetCompleteOrderUsecases getCompleteOrderUsecases;
  final GetCancelOrderUsecases getCancelOrderUsecases;

  // Variable of entity
  OrderHistoryEntity? orderHistoryEntity;
  RequestState orderRequestState = RequestState.initial;
  int currentIndex = 0;

  Future<void> getPendingOrders() async {
    // Clear the previous tab's data so it is not shown while loading
    orderHistoryEntity = null;
    orderRequestState = RequestState.loading;
    emit(OrderPendingLoading());
    final failureOrOrderHistoryEntity = await getPendingOrderUsecases();
    failureOrOrderHistoryEntity.fold(
      (failure) {
        orderRequestState = RequestState.error;
        emit(PendingOrderFailed(requestState: orderRequestState));
      },
      (order) {
        orderHistoryEntity = order;
        if ((order.data ?? []).isNotEmpty) {
          orderRequestState = RequestState.loaded;
          emit(PendingOrderSuccess(orderHistoryEntity: order));
        } else {
          orderRequestState = RequestState.empty;
          emit(PendingOrderFailed(requestState: orderRequestState));
        }
      },
    );
  }

  Future<void> getCompleteOrders() async {
    // Clear the previous tab's data so it is not shown while loading
    orderHistoryEntity = null;
    orderRequestState = RequestState.loading;
    emit(OrderPendingLoading());
    final failureOrOrderHistoryEntity = await getCompleteOrderUsecases();
    failureOrOrderHistoryEntity.fold(
      (failure) {
        orderRequestState = RequestState.error;
        emit(PendingOrderFailed(requestState: orderRequestState));
      },
      (order) {
        orderHistoryEntity = order;
        if ((order.data ?? []).isNotEmpty) {
          orderRequestState = RequestState.loaded;
          emit(PendingOrderSuccess(orderHistoryEntity: order));
        } else {
          orderRequestState = RequestState.empty;
          emit(PendingOrderFailed(requestState: orderRequestState));
        }
      },
    );
  }

  Future<void> getCancelOrders() async {
    // Clear the previous tab's data so it is not shown while loading
    orderHistoryEntity = null;
    orderRequestState = RequestState.loading;
    emit(OrderPendingLoading());
    final failureOrOrderHistoryEntity = await getCancelOrderUsecases();
    failureOrOrderHistoryEntity.fold(
      (failure) {
        orderRequestState = RequestState.error;
        emit(PendingOrderFailed(requestState: orderRequestState));
      },
      (order) {
        orderHistoryEntity = order;
        if ((order.data ?? []).isNotEmpty) {
          orderRequestState = RequestState.loaded;
          emit(PendingOrderSuccess(orderHistoryEntity: order));
        } else {
          orderRequestState = RequestState.empty;
          emit(PendingOrderFailed(requestState: orderRequestState));
        }
      },
    );
  }

  changeIndex(int index) {
    currentIndex = index;
    emit(CurrentIndexState(currentIndex: index));
    fetchData(index: index);
  }

  fetchData({required int index}) {
    orderHistoryEntity = null;
    if (index == 0) {
      getPendingOrders();
    } else if (index == 1) {
      getCompleteOrders();
    } else {
      getCancelOrders();
    }
  }
}
