import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Home/Presentation/Widget/main_bar.dart';
import 'package:easy_life/Features/Home/Presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Enums/level_message_enums.dart';
import '../Widget/carsoual_banner.dart';
import '../Widget/Home_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyInjectionHelper().sl<HomeCubit>()
        ..getSliders()
        ..getResturant()
        ..getHotels()
        ..getTrips(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          return Scaffold(
            body: Column(
              children: [
                MainBar(isHaveSearch: true),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      homeCubit.slidersEntity == null
                          ? Container(
                              height: 200,
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              width: double.infinity,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : homeCubit.sliderRequestState == RequestState.empty
                          ? const SizedBox()
                          : CarouselBanner(
                              sliderEntity: homeCubit.slidersEntity!,
                            ),

                      homeCubit.resturantEntity == null
                          ? Container(
                              height: 200,
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              width: double.infinity,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : homeCubit.resturantRequestState ==
                                RequestState.empty
                          ? const SizedBox()
                          : HomeListWidget(
                              title: LocaleKeys.homeSectionRestaurants.tr(),
                              homeData: homeCubit.resturantEntity!.data!,
                              homeCubit: homeCubit,
                              type: 'resturant',
                            ),

                      homeCubit.hotelsEntity == null
                          ? Container(
                              height: 200,
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              width: double.infinity,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : homeCubit.hotelsRequestState == RequestState.empty
                          ? const SizedBox()
                          : HomeListWidget(
                              title: LocaleKeys.homeSectionHotels.tr(),
                              homeData: homeCubit.hotelsEntity!.data!,
                              homeCubit: homeCubit,
                              type: 'Hotel',
                            ),

                      homeCubit.tripsEntity == null
                          ? Container(
                              height: 200,
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              width: double.infinity,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : homeCubit.tripsRequestState == RequestState.empty
                          ? const SizedBox()
                          : HomeListWidget(
                              title: LocaleKeys.homeSectionTrips.tr(),
                              homeData: homeCubit.tripsEntity!.data!,
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
