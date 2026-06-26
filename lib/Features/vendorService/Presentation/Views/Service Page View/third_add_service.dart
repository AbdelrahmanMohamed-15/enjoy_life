import 'package:easy_life/Features/vendorService/Presentation/Widget/hotel_widget/hotel_list_item.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Widget/resturant_widget/returant_list_item.dart';
import '../../Widget/trip_schedule_widget/trip_schedule_list_item.dart';

class ThirdAddService extends StatelessWidget {
  final String type;
  const ThirdAddService({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    debugPrint('type is $type');
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        // var vendorServiceCubit = VendorServiceCubit.get(context);
        return type == 'resturant'
            ? ReturantListItem()
            : type == 'hotel'
            ? HotelListItem()
            : TripScheduleListItem();
      },
    );
  }
}
