import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_life/Core/Widget/booking_type_icon.dart';
import 'package:easy_life/Core/Widget/state_message_widget.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/Services/Domain/Entity/trip_entity.dart';
import 'package:easy_life/Features/Services/Presentation/cubit/service_cubit.dart';
import 'package:flutter/material.dart';

import '../Widget/bookable_item_card.dart';

class TripsScreen extends StatelessWidget {
  final String title;
  final ServiceCubit serviceCubit;
  final List<TripData> tripsData;
  const TripsScreen({
    super.key,
    required this.title,
    required this.serviceCubit,
    required this.tripsData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppPageBar(title: title),
      body: tripsData.isEmpty
          ? StateMessageWidget.empty()
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: tripsData.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                var trip = tripsData[index];
                final from = trip.locationFrom ?? '';
                final to = trip.locationTo ?? '';
                return BookableItemCard(
                  leading: const BookingTypeIcon(itemType: 'trip', size: 64),
                  title: from.isNotEmpty || to.isNotEmpty
                      ? '$from  →  $to'
                      : '${LocaleKeys.servicesTripNumber.tr()} ${trip.scheduleNumber ?? ''}',
                  subtitle:
                      '${LocaleKeys.servicesTripNumber.tr()} ${trip.scheduleNumber ?? ''}',
                  facts: [
                    if ((trip.movingTime ?? '').isNotEmpty)
                      ItemFact(Icons.flight_takeoff_rounded, trip.movingTime!),
                    if ((trip.returningTime ?? '').isNotEmpty)
                      ItemFact(Icons.flight_land_rounded, trip.returningTime!),
                    ItemFact(
                      Icons.groups_rounded,
                      '${LocaleKeys.servicesCapacity.tr()} ${trip.capacity ?? 0}',
                    ),
                  ],
                  price: trip.price ?? '0',
                  onAdd: () =>
                      serviceCubit.addToCart(type: 'trip', tripID: trip.id),
                );
              },
            ),
    );
  }
}
