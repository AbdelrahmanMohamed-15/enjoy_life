import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_life/Core/Widget/booking_type_icon.dart';
import 'package:easy_life/Core/Widget/state_message_widget.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/Services/Domain/Entity/room_entity.dart';
import 'package:easy_life/Features/Services/Presentation/cubit/service_cubit.dart';
import 'package:flutter/material.dart';

import '../Widget/bookable_item_card.dart';
import '../Widget/booking_period_banner.dart';

class RoomScreen extends StatelessWidget {
  final List<RoomData> tableData;
  final String title;
  final ServiceCubit serviceCubit;
  final String startDate;
  final String endDate;
  const RoomScreen({
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
                      var room = tableData[index];
                      return BookableItemCard(
                        leading: const BookingTypeIcon(
                          itemType: 'hotel',
                          size: 64,
                        ),
                        title:
                            '${LocaleKeys.servicesRoomNumber.tr()} ${room.roomNumber ?? ''}',
                        subtitle: room.description,
                        facts: [
                          ItemFact(
                            Icons.groups_rounded,
                            '${LocaleKeys.servicesCapacity.tr()} ${room.capacity ?? 0}',
                          ),
                          if ((room.floorNumber ?? '').isNotEmpty)
                            ItemFact(
                              Icons.stairs_rounded,
                              '${LocaleKeys.vendorFloorNumber.tr()}: ${room.floorNumber}',
                            ),
                          if ((room.deposit ?? 'null') != 'null')
                            ItemFact(
                              Icons.account_balance_wallet_rounded,
                              '${LocaleKeys.vendorDeposit.tr()}: ${room.deposit}',
                            ),
                        ],
                        price: room.price ?? '0',
                        onAdd: () => serviceCubit.addToCart(
                          type: 'room',
                          roomID: room.id!,
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
