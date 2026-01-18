import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/Extentions/padding_ext.dart';
import 'package:easy_life/Core/Widget/general_service_card.dart';
import 'package:easy_life/Features/Authentication/Domain/Entity/user_entity.dart';
import 'package:easy_life/Features/Home/Domain/Entity/resturant_entity.dart';
import 'package:easy_life/Features/Home/Presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Helper/dependency_injection_helper.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Routes/app_routes.dart';
import '../../../../Core/Themes/app_colors.dart';

class HomeListWidget extends StatelessWidget {
  final List<HomeData> homeData;
  final String title;
  final HomeCubit homeCubit;
  final String type;
  const HomeListWidget({
    super.key,
    required this.homeData,
    required this.title,
    required this.homeCubit,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Userdata? userData = DependencyInjectionHelper()
        .sl<AuthHandlerInterface>()
        .getUserData();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontFamily: BaseConstant.cairoBold,
                color: AppColors.black700,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                AppNavigation.pushNamed(
                  AppRoutes.allHome,
                  arguments: {'type': type},
                );
              },
              child: Text(
                'عرض الكل',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: BaseConstant.cairoBold,
                  color: AppColors.primary400,
                ),
              ),
            ),
          ],
        ),
        // const SizedBox(height: 5),
        SizedBox(
          height: 245,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: homeData.length,
            itemBuilder: (context, index) {
              var data = homeData[index];
              return Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    debugPrint('UserData ${userData?.clientType}');
                    debugPrint('serviceID ${data.id}');
                    debugPrint('serviceID ${data.serviceName}');
                    if (userData?.clientType == 0 || userData == null) {
                      debugPrint('serviceID ${data.id}');
                      debugPrint('serviceID ${data.serviceName}');
                      AppNavigation.pushNamed(
                        AppRoutes.resturantDetails,
                        arguments: {
                          "serviceID": data.id,
                          "type": data.serviceName,
                        },
                      );
                    } else {
                      if (data.serviceName == 'resturant' ||
                          data.serviceName == 'مطعم') {
                        AppNavigation.pushNamed(
                          AppRoutes.addService,
                          arguments: {
                            'type': 'resturant',
                            'isEdit': true,
                            'id': data.id,
                          },
                        );
                      } else if (data.serviceName == 'hotel' ||
                          data.serviceName == 'فندق') {
                        AppNavigation.pushNamed(
                          AppRoutes.addService,
                          arguments: {
                            'type': 'hotel',
                            'isEdit': true,
                            'id': data.id,
                          },
                        );
                      } else {
                        debugPrint('serviceID Trip ${data.id}');
                        debugPrint('serviceID Trip ${data.serviceName}');
                        AppNavigation.pushNamed(
                          AppRoutes.addService,
                          arguments: {
                            'type': 'trip',
                            'isEdit': true,
                            'id': data.id,
                          },
                        );
                      }
                    }
                  },
                  child: GeneralServiceCard(
                    logo: data.logo ?? '',
                    title: data.name ?? '',
                    isFavourite: data.isFavourite ?? false,
                    rate: data.rating ?? '0.0',
                    serviceName: data.serviceName ?? '',
                    description: data.description ?? '',
                    address: data.address ?? '',
                    addFavouriteTap: () {
                      if (data.serviceName == 'Restaurant'.toUpperCase() ||
                          data.serviceName == 'مطعم') {
                        homeCubit.addFavourite(
                          id: data.id ?? 0,
                          type: 'resturant',
                        );
                        homeCubit.getResturant();
                      } else if (data.serviceName == 'Hotel'.toUpperCase() ||
                          data.serviceName == 'فندق') {
                        homeCubit.addFavourite(id: data.id ?? 0, type: 'hotel');
                        homeCubit.getHotels();
                      } else if (data.serviceName == 'Trip'.toUpperCase() ||
                          data.serviceName == 'رحلة') {
                        homeCubit.addFavourite(id: data.id ?? 0, type: 'trip');
                        homeCubit.getTrips();
                      }
                    },
                    removeFavouriteTap: () {
                      if (data.serviceName == 'Restaurant'.toUpperCase() ||
                          data.serviceName == 'مطعم') {
                        homeCubit.removeFavourite(
                          id: data.id ?? 0,
                          type: 'resturant',
                        );
                        homeCubit.getResturant();
                      } else if (data.serviceName == 'Hotel'.toUpperCase() ||
                          data.serviceName == 'فندق') {
                        homeCubit.removeFavourite(
                          id: data.id ?? 0,
                          type: 'hotel',
                        );
                        homeCubit.getHotels();
                      } else if (data.serviceName == 'Trip'.toUpperCase() ||
                          data.serviceName == 'رحلة') {
                        homeCubit.removeFavourite(
                          id: data.id ?? 0,
                          type: 'trip',
                        );
                        homeCubit.getTrips();
                      }
                    },
                  ).setHorizontalPadding(context, 8, enableMediaQuery: false),
                ),
              );
            },
          ),
        ),
      ],
    ).setHorizontalAndVerticalPadding(context, 15, 10, enableMediaQuery: false);
  }
}
