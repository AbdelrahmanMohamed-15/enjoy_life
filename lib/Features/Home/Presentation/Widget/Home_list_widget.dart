import 'package:easy_life/Core/Helper/service_kind.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Core/Widget/general_service_card.dart';
import 'package:easy_life/Features/Home/Domain/Entity/resturant_entity.dart';
import 'package:easy_life/Features/Home/Presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Routes/app_routes.dart';
import 'service_actions.dart';

/// Horizontal rail of restaurants, hotels or trips with a "View all" link.
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
    final isVendor = ServiceActions.isVendor;
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16, end: 8),
            child: AppSectionHeader(
              title: title,
              actionLabel: LocaleKeys.homeViewAll.tr(),
              onAction: () => AppNavigation.pushNamed(
                AppRoutes.allHome,
                arguments: {'type': type},
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 244,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: homeData.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                var data = homeData[index];
                return GeneralServiceCard(
                  key: ValueKey('${data.serviceId}_${data.id}'),
                  logo: data.logo ?? '',
                  title: data.name ?? '',
                  isFavourite: data.isFavourite ?? false,
                  rate: data.rating ?? '0.0',
                  kind: ServiceKind.of(
                    id: data.serviceId,
                    name: data.serviceName,
                  ),
                  description: data.description ?? '',
                  address: data.address ?? '',
                  onTap: () => ServiceActions.open(data),
                  onFavouriteChanged: isVendor
                      ? null
                      : (favourite) => ServiceActions.setFavourite(
                          homeCubit,
                          data,
                          favourite,
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
