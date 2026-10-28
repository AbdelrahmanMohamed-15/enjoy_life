import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Widget/state_message_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Home/Presentation/Widget/main_bar.dart';
import 'package:easy_life/Features/Home/Presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../Core/Themes/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Enums/level_message_enums.dart';
import '../Widget/carsoual_banner.dart';
import '../Widget/Home_list_widget.dart';
import '../Widget/home_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DependencyInjectionHelper().sl<HomeCubit>()..getHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          final sectionStates = [
            homeCubit.sliderRequestState,
            homeCubit.resturantRequestState,
            homeCubit.hotelsRequestState,
            homeCubit.tripsRequestState,
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
                MainBar(isHaveSearch: true),
                Expanded(
                  child: allFailed
                      ? StateMessageWidget.error(
                          onRetry: () => homeCubit.getHomeData(),
                        )
                      : nothingToShow
                      ? StateMessageWidget.empty(
                          onRetry: () => homeCubit.getHomeData(),
                        )
                      : RefreshIndicator(
                          color: AppColors.primary500,
                          onRefresh: () => homeCubit.getHomeData(),
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 14, bottom: 24),
                            children: [
                              HomeSection(
                                requestState: homeCubit.sliderRequestState,
                                hasData: homeCubit.slidersEntity != null,
                                builder: () => CarouselBanner(
                                  sliderEntity: homeCubit.slidersEntity!,
                                ),
                              ),
                              HomeSection(
                                requestState: homeCubit.resturantRequestState,
                                hasData: homeCubit.resturantEntity != null,
                                builder: () => HomeListWidget(
                                  title: LocaleKeys.homeSectionRestaurants.tr(),
                                  homeData: homeCubit.resturantEntity!.data!,
                                  homeCubit: homeCubit,
                                  type: 'resturant',
                                ),
                              ),
                              HomeSection(
                                requestState: homeCubit.hotelsRequestState,
                                hasData: homeCubit.hotelsEntity != null,
                                builder: () => HomeListWidget(
                                  title: LocaleKeys.homeSectionHotels.tr(),
                                  homeData: homeCubit.hotelsEntity!.data!,
                                  homeCubit: homeCubit,
                                  type: 'Hotel',
                                ),
                              ),
                              HomeSection(
                                requestState: homeCubit.tripsRequestState,
                                hasData: homeCubit.tripsEntity != null,
                                builder: () => HomeListWidget(
                                  title: LocaleKeys.homeSectionTrips.tr(),
                                  homeData: homeCubit.tripsEntity!.data!,
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
