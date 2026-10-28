import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_life/Core/Widget/booking_type_icon.dart';
import 'package:easy_life/Core/Widget/state_message_widget.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/Services/Domain/Entity/table_entity.dart';
import 'package:easy_life/Features/Services/Presentation/cubit/service_cubit.dart';
import 'package:flutter/material.dart';

import '../Widget/bookable_item_card.dart';
import '../Widget/booking_period_banner.dart';

class TablesScreen extends StatelessWidget {
  final List<TableData> tableData;
  final String title;
  final ServiceCubit serviceCubit;
  final String startDate;
  final String endDate;
  const TablesScreen({
    super.key,
    required this.tableData,
    required this.title,
    required this.serviceCubit,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppPageBar(title: title),
      body: Column(
        children: [
          BookingPeriodBanner(startDate: startDate, endDate: endDate),
          Expanded(
            child: tableData.isEmpty
                ? StateMessageWidget.empty()
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: tableData.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      var table = tableData[index];
                      return BookableItemCard(
                        leading: const BookingTypeIcon(
                          itemType: 'restaurant',
                          size: 64,
                        ),
                        title:
                            '${LocaleKeys.servicesTableNumber.tr()} ${table.tableNumber ?? ''}',
                        subtitle: table.description,
                        facts: [
                          ItemFact(
                            Icons.groups_rounded,
                            '${LocaleKeys.servicesCapacity.tr()} ${table.capacity ?? 0}',
                          ),
                          if ((table.deposit ?? 'null') != 'null')
                            ItemFact(
                              Icons.account_balance_wallet_rounded,
                              '${LocaleKeys.vendorDeposit.tr()}: ${table.deposit}',
                            ),
                        ],
                        price: table.price ?? '0',
                        onAdd: () => serviceCubit.addToCart(
                          type: 'table',
                          tableID: table.id!,
                          startDate: startDate,
                          endDate: endDate,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
