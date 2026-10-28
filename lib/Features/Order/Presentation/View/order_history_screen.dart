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
              elevation: 2,
              leading: GestureDetector(
                onTap: () {
                  AppNavigation.pop();
                },
                child: Icon(Icons.arrow_back_ios, color: AppColors.primary500),
              ),
            ),
            body: Column(
              children: [
                const SizedBox(height: 10),
                OrderTabs(
                  currentIndex: orderCubit.currentIndex,
                  orderCubit: orderCubit,
                ),
                const SizedBox(height: 10),
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
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: orderCubit
                              .orderHistoryEntity!
                              .data!
                              .reversed
                              .length,
                          itemBuilder: (context, index) {
                            var order = orderCubit
                                .orderHistoryEntity!
                                .data!
                                .reversed
                                .toList()[index];
                            return OrderCard(order: order);
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
