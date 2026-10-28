import 'package:easy_life/Core/Helper/service_kind.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_life/Core/Widget/state_message_widget.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Home/Presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Enums/level_message_enums.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/general_service_card.dart';
import '../Widget/service_actions.dart';

class AllHomeScreen extends StatelessWidget {
  final String type;
  const AllHomeScreen({super.key, required this.type});

  String get _title => switch (ServiceKind.of(name: type)) {
    ServiceKind.restaurant => LocaleKeys.homeSectionRestaurants.tr(),
    ServiceKind.hotel => LocaleKeys.homeSectionHotels.tr(),
    ServiceKind.trip => LocaleKeys.homeSectionTrips.tr(),
    null => LocaleKeys.homeAllTitle.tr(),
  };

  @override
  Widget build(BuildContext context) {
    final isVendor = ServiceActions.isVendor;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppPageBar(title: _title),
          body: homeCubit.totalHomeRequestState == RequestState.error
              ? StateMessageWidget.error(
                  onRetry: () => homeCubit.getAllHome(type: type),
                )
              : homeCubit.totalHomeEntity == null ||
                    homeCubit.totalHomeRequestState == RequestState.loading
              ? const Center(child: CircularProgressIndicator())
              : homeCubit.totalHomeRequestState == RequestState.empty
              ? StateMessageWidget.empty(
                  onRetry: () => homeCubit.getAllHome(type: type),
                )
              : RefreshIndicator(
                  color: AppColors.primary500,
                  onRefresh: () async => homeCubit.getAllHome(type: type),
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 220,
                          mainAxisExtent: 244,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
                    itemCount: homeCubit.totalHomeEntity!.data!.length,
                    itemBuilder: (context, index) {
                      var data = homeCubit.totalHomeEntity!.data![index];
                      return GeneralServiceCard(
                        key: ValueKey('${data.serviceId}_${data.id}'),
                        width: double.infinity,
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
        );
      },
    );
  }
}
