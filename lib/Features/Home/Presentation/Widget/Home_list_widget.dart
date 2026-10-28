import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Core/Extentions/padding_ext.dart';
import 'package:easy_life/Core/Widget/general_service_card.dart';
import 'package:easy_life/Features/Authentication/Domain/Entity/user_entity.dart';
import 'package:easy_life/Features/Home/Domain/Entity/resturant_entity.dart';
import 'package:easy_life/Features/Home/Presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'service_actions.dart';

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
                LocaleKeys.homeViewAll.tr(),
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
                  onTap: () => ServiceActions.open(data),
                  child: GeneralServiceCard(
                    logo: data.logo ?? '',
                    title: data.name ?? '',
                    isFavourite: data.isFavourite ?? false,
                    rate: data.rating ?? '0.0',
                    serviceName: data.serviceName ?? '',
                    description: data.description ?? '',
                    address: data.address ?? '',
                    addFavouriteTap: () =>
                        ServiceActions.setFavourite(homeCubit, data, true),
                    removeFavouriteTap: () =>
                        ServiceActions.setFavourite(homeCubit, data, false),
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
