import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/Helper/service_kind.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Routes/app_routes.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_life/Core/Widget/booking_type_icon.dart';
import 'package:easy_life/Core/Widget/custom_network_image.dart';
import 'package:easy_life/Core/Widget/state_message_widget.dart';
import 'package:easy_life/Features/Home/Domain/Entity/resturant_entity.dart';
import 'package:easy_life/Features/Home/Presentation/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyFavouriteScreen extends StatelessWidget {
  const MyFavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DependencyInjectionHelper().sl<HomeCubit>()..getMyFavourite(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          final items = homeCubit.myFavouriteEntity?.data ?? [];
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppPageBar(
              title: LocaleKeys.mainNavFavorites.tr(),
              showBack: false,
            ),
            body: homeCubit.myFavouriteRequestState == RequestState.error
                ? StateMessageWidget.error(
                    onRetry: () => homeCubit.getMyFavourite(),
                  )
                : homeCubit.myFavouriteEntity == null ||
                      homeCubit.myFavouriteRequestState == RequestState.loading
                ? const Center(child: CircularProgressIndicator())
                : items.isEmpty
                ? StateMessageWidget.empty(
                    message: LocaleKeys.homeFavoritesEmpty.tr(),
                    onRetry: () => homeCubit.getMyFavourite(),
                  )
                : RefreshIndicator(
                    color: AppColors.primary500,
                    onRefresh: () async => homeCubit.getMyFavourite(),
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      itemCount: items.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) => _FavouriteTile(
                        key: ValueKey(
                          '${items[index].serviceId}_${items[index].itemID}',
                        ),
                        data: items[index],
                        homeCubit: homeCubit,
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class _FavouriteTile extends StatelessWidget {
  final HomeData data;
  final HomeCubit homeCubit;
  const _FavouriteTile({
    super.key,
    required this.data,
    required this.homeCubit,
  });

  Future<void> _remove() async {
    final kind = ServiceKind.of(id: data.serviceId, name: data.serviceName);
    if (kind == null) return;
    final ok = await homeCubit.removeFavourite(
      id: data.itemID ?? 0,
      type: kind.apiKey,
    );
    if (ok) await homeCubit.getMyFavourite();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final kind = ServiceKind.of(id: data.serviceId, name: data.serviceName);
    final rating = (double.tryParse(data.rating ?? '') ?? 0).toStringAsFixed(1);
    return AppCard(
      padding: const EdgeInsets.all(10),
      onTap: () => AppNavigation.pushNamed(
        AppRoutes.resturantDetails,
        arguments: {"serviceID": data.itemID, "type": data.serviceName},
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CustomNetworkImage(
              imageUrl: data.logo,
              height: 92,
              width: 92,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (kind != null) ...[
                      BookingTypeIcon(itemType: kind.itemType, size: 22),
                      const SizedBox(width: 6),
                    ],
                    Expanded(
                      child: Text(
                        data.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: BaseConstant.cairoBold,
                          color: AppColors.black700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  data.description ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.natural500,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFC83D),
                      size: 16,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      rating,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: BaseConstant.cairoBold,
                        color: AppColors.black700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.location_on_rounded,
                      color: AppColors.primary500,
                      size: 14,
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        data.address ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.natural600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _remove,
            icon: const Icon(
              Icons.favorite_rounded,
              color: AppColors.errorColor,
            ),
          ),
        ],
      ),
    );
  }
}
