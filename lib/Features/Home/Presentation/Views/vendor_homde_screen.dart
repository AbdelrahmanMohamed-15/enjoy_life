import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Features/Home/Presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Enums/level_message_enums.dart';
import '../Widget/carsoual_banner.dart';
import '../Widget/Home_list_widget.dart';
import '../Widget/main_bar.dart';

class VendorHomeScreen extends StatelessWidget {
  const VendorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DependencyInjectionHelper().sl<HomeCubit>()..getAllVendorHome(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          return Scaffold(
            body: Column(
              children: [
                MainBar(isHaveSearch: false),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      homeCubit.vendorResturantEntity == null
                          ? Container(
                              height: 200,
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              width: double.infinity,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : homeCubit.vendorResturantRequestState ==
                                RequestState.empty
                          ? const SizedBox()
                          : HomeListWidget(
                              title: 'المطاعم',
                              homeData: homeCubit.vendorResturantEntity!.data!,
                              homeCubit: homeCubit,
                              type: 'resturant',
                            ),

                      homeCubit.vendorHotelsEntity == null
                          ? Container(
                              height: 200,
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              width: double.infinity,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : homeCubit.vendorHotelsRequestState ==
                                RequestState.empty
                          ? const SizedBox()
                          : HomeListWidget(
                              title: 'الفنادق',
                              homeData: homeCubit.vendorHotelsEntity!.data!,
                              homeCubit: homeCubit,
                              type: 'Hotel',
                            ),

                      homeCubit.vendorTripsEntity == null
                          ? Container(
                              height: 200,
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              width: double.infinity,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : homeCubit.vendorHotelsRequestState ==
                                RequestState.empty
                          ? const SizedBox()
                          : HomeListWidget(
                              title: 'الرحلات',
                              homeData: homeCubit.vendorTripsEntity!.data!,
                              homeCubit: homeCubit,
                              type: 'Trip',
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
