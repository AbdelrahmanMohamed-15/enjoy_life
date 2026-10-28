import 'package:easy_life/Core/Widget/state_message_widget.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Features/Cart/Presentation/Widget/cart_item_card.dart';
import 'package:easy_life/Features/Cart/Presentation/Widget/cart_summary_widget.dart';
import 'package:easy_life/Features/Cart/Presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Helper/user_validation_helper.dart';
import '../../../../Core/Themes/app_colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyInjectionHelper().sl<CartCubit>()
        ..getCart()
        ..storeSession(),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          var cartCubit = CartCubit.get(context);
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppPageBar(
              title: LocaleKeys.cartTitle.tr(),
              showBack: false,
            ),
            body:
                cartCubit.cartRequestState == RequestState.error &&
                    cartCubit.cartEntity == null
                ? StateMessageWidget.error(onRetry: () => cartCubit.getCart())
                : cartCubit.cartEntity == null
                ? Center(child: CircularProgressIndicator())
                : cartCubit.cartRequestState == RequestState.empty
                ? StateMessageWidget.empty(
                    message: LocaleKeys.cartEmpty.tr(),
                    onRetry: () => cartCubit.getCart(),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          color: AppColors.primary500,
                          onRefresh: () => cartCubit.getCart(),
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                            itemCount:
                                cartCubit.cartEntity!.data!.items!.length,
                            itemBuilder: (context, index) {
                              var cart =
                                  cartCubit.cartEntity!.data!.items![index];
                              return CartItemCard(
                                item: cart,
                                onRemove: () => cartCubit.removeItemCart(
                                  rowID: cart.rowId!,
                                ),
                                onIncrease: () => cartCubit.updateItemQuantity(
                                  rowID: cart.rowId!,
                                  quantity: cart.qty.toString(),
                                  type: 'add',
                                ),
                                onDecrease: () => cartCubit.updateItemQuantity(
                                  rowID: cart.rowId!,
                                  quantity: cart.qty.toString(),
                                  type: 'remove',
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      CartSummaryWidget(
                        itemsCount: cartCubit.cartEntity!.data!.items!.length,
                        total: cartCubit.cartEntity!.data!.total ?? '0.0',
                        onCheckout: () {
                          if (UserValidationHelper.checkUserValidation() ==
                              true) {
                            cartCubit.createOrder();
                          } else {
                            UserValidationHelper.showUserValidation();
                          }
                        },
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
