import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Core/Widget/custom_snack_bar.dart';
import 'package:easy_life/Features/Cart/Domain/Usecases/create_order_usecases.dart';
import 'package:easy_life/Features/Cart/Domain/Usecases/get_cart_usecases.dart';
import 'package:easy_life/Features/Cart/Domain/Usecases/remove_item_cart_usecases.dart';
import 'package:easy_life/Features/Cart/Domain/Usecases/store_session_usecases.dart';
import 'package:easy_life/Features/Cart/Domain/Usecases/update_item_quantity_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Helper/dependency_injection_helper.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../Domain/Entity/cart_entity.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required this.getCartUsecases,
    required this.updateItemQuantityUsecases,
    required this.removeItemCartUsecases,
    required this.createOrderUsecases,
    required this.storeSessionUsecases,
  }) : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of(context);
  // variable of usecase
  final GetCartUsecases getCartUsecases;
  final UpdateItemQuantityUsecases updateItemQuantityUsecases;
  final RemoveItemCartUsecases removeItemCartUsecases;
  final CreateOrderUsecases createOrderUsecases;
  final StoreSessionUsecases storeSessionUsecases;
  // variable of entity
  CartEntity? cartEntity;
  // variable of request state
  RequestState cartRequestState = RequestState.initial;

  Future<void> getCart() async {
    debugPrint('Cart Response : call Cart');
    cartRequestState = RequestState.loading;
    var result = await getCartUsecases.call();
    result.fold(
      (failure) {
        cartRequestState = RequestState.error;
        emit(ErrorGetCart(requestState: cartRequestState));
      },
      (cart) {
        cartEntity = cart;
        if (cart.data!.items!.isEmpty) {
          cartRequestState = RequestState.empty;
          emit(ErrorGetCart(requestState: cartRequestState));
        } else {
          cartRequestState = RequestState.loaded;
          emit(SuccessGetCart(cartEntity: cart));
        }
      },
    );
  }

  updateItemQuantity({
    required String rowID,
    required String quantity,
    required String type,
  }) async {
    EasyLoading.show();
    int quantityInt = int.parse(quantity);
    if (type == 'add') {
      quantityInt++;
    } else {
      quantityInt--;
    }
    final res = await updateItemQuantityUsecases.call(
      rowID: rowID,
      quantity: quantityInt.toString(),
    );
    res.fold(
      (failure) {
        EasyLoading.dismiss();
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (update) {
        EasyLoading.dismiss();
        if (update.status == 200) {
          getCart();
        } else {
          showCustomSnackBar(
            update.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }

  removeItemCart({required String rowID}) async {
    EasyLoading.show();
    final res = await removeItemCartUsecases.call(rowID: rowID);
    res.fold(
      (failure) {
        EasyLoading.dismiss();
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (update) {
        EasyLoading.dismiss();
        if (update.status == 200) {
          getCart();
        } else {
          showCustomSnackBar(
            update.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }

  createOrder() async {
    EasyLoading.show();
    final res = await createOrderUsecases.call();
    res.fold(
      (failure) {
        EasyLoading.dismiss();
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (update) {
        EasyLoading.dismiss();
        if (update.status == 200) {
          getCart();
        } else {
          showCustomSnackBar(
            update.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }

  storeSession() async {
    String? session = DependencyInjectionHelper()
        .sl<AuthHandlerInterface>()
        .getCookies();
    final res = await storeSessionUsecases.storeSession(session: session!);
    res.fold(
      (failure) {
        EasyLoading.dismiss();
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (update) {
        EasyLoading.dismiss();
        if (update.status == 200) {
          getCart();
        } else {
          showCustomSnackBar(
            update.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }
}
