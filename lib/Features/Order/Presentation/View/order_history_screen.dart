import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Core/Widget/state_message_widget.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Order/Presentation/Widget/order_card.dart';
import 'package:easy_life/Features/Order/Presentation/Widget/order_tabs.dart';
import 'package:easy_life/Features/Order/Presentation/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../Core/Constant/assets_strings.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        var orderCubit = OrderCubit.get(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              title: Text(
                LocaleKeys.orderHistoryTitle.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary400,
                  fontFamily: BaseConstant.cairoBold,
                  fontSize: 20,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: AppColors.backgroundColor,
              leading: IconButton(
                onPressed: () {
                  AppNavigation.pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.primary500,
                  size: 20,
                ),
              ),
            ),
            body: Column(
              children: [
                const SizedBox(height: 6),
                OrderTabs(
                  currentIndex: orderCubit.currentIndex,
                  orderCubit: orderCubit,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: orderCubit.orderRequestState == RequestState.error
                      ? StateMessageWidget.error(
                          onRetry: () => orderCubit.fetchData(
                            index: orderCubit.currentIndex,
                          ),
                        )
                      : orderCubit.orderHistoryEntity == null
                      ? const Center(child: CircularProgressIndicator())
                      : (orderCubit.orderHistoryEntity!.data ?? []).isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AssetsStrings.empty),
                            const SizedBox(height: 20),
                            Center(
                              child: Text(
                                LocaleKeys.orderHistoryEmpty.tr(),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 17,
                                  color: AppColors.black700,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Builder(
                          builder: (context) {
                            final orders = orderCubit
                                .orderHistoryEntity!
                                .data!
                                .reversed
                                .toList();
                            return ListView.builder(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                // Fade/slide cards in, staggered by position
                                return TweenAnimationBuilder<double>(
                                  key: ValueKey(orders[index].id),
                                  tween: Tween(begin: 0, end: 1),
                                  duration: Duration(
                                    milliseconds:
                                        300 + (index.clamp(0, 6) * 70),
                                  ),
                                  curve: Curves.easeOutCubic,
                                  builder: (context, value, child) => Opacity(
                                    opacity: value,
                                    child: Transform.translate(
                                      offset: Offset(0, 24 * (1 - value)),
                                      child: child,
                                    ),
                                  ),
                                  child: OrderCard(order: orders[index]),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
