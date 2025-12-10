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
                'الطلبات السابقة',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary400,
                  fontFamily: BaseConstant.cairoBold,
                  fontSize: 20,
                ),
              ),
              centerTitle: true,
              elevation: 2,
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
                  child: orderCubit.orderHistoryEntity == null
                      ? const Center(child: CircularProgressIndicator())
                      : orderCubit.orderHistoryEntity!.data!.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AssetsStrings.empty),
                            const SizedBox(height: 20),
                            Center(
                              child: Text(
                                'لا يوجد طلبات سابقه',
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
