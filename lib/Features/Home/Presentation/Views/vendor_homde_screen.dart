import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Widget/state_message_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/Home/Presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Enums/level_message_enums.dart';
import '../Widget/Home_list_widget.dart';
import '../Widget/home_section.dart';
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
          final sectionStates = [
            homeCubit.vendorResturantRequestState,
            homeCubit.vendorHotelsRequestState,
            homeCubit.vendorTripsRequestState,
          ];
          final bool allFailed = sectionStates.every(
            (s) => s == RequestState.error,
          );
          final bool nothingToShow = sectionStates.every(
            (s) => s == RequestState.error || s == RequestState.empty,
          );
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Column(
              children: [
                MainBar(isHaveSearch: false),
                Expanded(
                  child: allFailed
                      ? StateMessageWidget.error(
                          onRetry: () => homeCubit.getAllVendorHome(),
                        )
                      : nothingToShow
                      ? StateMessageWidget.empty(
                          onRetry: () => homeCubit.getAllVendorHome(),
                        )
                      : RefreshIndicator(
                          color: AppColors.primary500,
                          onRefresh: () async {
                            await homeCubit.getAllVendorHome();
                          },
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 14, bottom: 24),
                            children: [
                              HomeSection(
                                requestState:
                                    homeCubit.vendorResturantRequestState,
                                hasData:
                                    homeCubit.vendorResturantEntity != null,
                                builder: () => HomeListWidget(
                                  title: LocaleKeys.homeVendorRestaurants.tr(),
                                  homeData:
                                      homeCubit.vendorResturantEntity!.data!,
                                  homeCubit: homeCubit,
                                  type: 'resturant',
                                ),
                              ),
                              HomeSection(
                                requestState:
                                    homeCubit.vendorHotelsRequestState,
                                hasData: homeCubit.vendorHotelsEntity != null,
                                builder: () => HomeListWidget(
                                  title: LocaleKeys.homeVendorHotels.tr(),
                                  homeData: homeCubit.vendorHotelsEntity!.data!,
                                  homeCubit: homeCubit,
                                  type: 'Hotel',
                                ),
                              ),
                              HomeSection(
                                requestState: homeCubit.vendorTripsRequestState,
                                hasData: homeCubit.vendorTripsEntity != null,
                                builder: () => HomeListWidget(
                                  title: LocaleKeys.homeVendorTrips.tr(),
                                  homeData: homeCubit.vendorTripsEntity!.data!,
                                  homeCubit: homeCubit,
                                  type: 'Trip',
                                ),
                              ),
                            ],
                          ),
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
