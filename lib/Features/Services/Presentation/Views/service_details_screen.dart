import 'package:easy_life/Core/Widget/state_message_widget.dart';
import 'package:easy_life/Core/Widget/custom_network_image.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Core/Helper/service_kind.dart';
import 'package:easy_life/Core/Helper/user_validation_helper.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_life/Core/Widget/booking_type_icon.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/profile_avatar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:easy_life/Core/Widget/map_location_widget.dart';
import 'package:easy_life/Features/Authentication/Domain/Entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_life/Features/Services/Presentation/cubit/service_cubit.dart';
import 'package:easy_life/Features/Services/Domain/Entity/service_deatils_entity.dart'
    hide Image;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Core/Constant/assets_strings.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Enums/level_message_enums.dart';
import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Helper/dependency_injection_helper.dart';
import '../Widget/select_slot_bottomsheet.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final int serviceID;
  final String type;
  final int? id;
  const ServiceDetailsScreen({
    super.key,
    required this.serviceID,
    required this.type,
    this.id,
  });

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  Branch? selectedBranch;
  String? selectedImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Userdata? userData = DependencyInjectionHelper()
        .sl<AuthHandlerInterface>()
        .getUserData();
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        var serviceCubit = ServiceCubit.get(context);
        const messageAppBar = AppPageBar(title: '');

        if (serviceCubit.serviceRequestState == RequestState.error) {
          return Scaffold(
            appBar: messageAppBar,
            body: StateMessageWidget.error(
              message: LocaleKeys.servicesLoadError.tr(),
              onRetry: () => serviceCubit.getinitialData(
                id: widget.serviceID,
                type: widget.type,
              ),
            ),
          );
        }

        if (serviceCubit.serviceDetails == null ||
            serviceCubit.serviceRequestState == RequestState.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (serviceCubit.serviceRequestState == RequestState.empty ||
            serviceCubit.serviceDetails!.data == null) {
          return Scaffold(
            appBar: messageAppBar,
            body: StateMessageWidget.empty(),
          );
        }

        if (serviceCubit.serviceDetails != null) {
          final resturant = serviceCubit.serviceDetails!.data!;
          final kind = ServiceKind.of(name: widget.type);
          final isGuest = userData == null;
          final isVendor = userData != null && userData.clientType != 0;
          final uniqueBranches = <int?, Branch>{
            for (final sb in resturant.serviceBranches ?? <ServiceBranch>[])
              if (sb.branch != null) sb.branch!.id: sb.branch!,
          }.values.toList();
          // Services of the selected branch, without duplicates
          List<ServiceBranch> uniqueBranchesById = {
            for (var sb in (resturant.serviceBranches ?? []).where(
              (s) => s.branch?.id == selectedBranch?.id,
            ))
              sb.id: sb,
          }.values.toList();
          final images = resturant.images ?? [];
          final rates = resturant.rates ?? [];
          final rating = (resturant.avarageRating ?? 0).toStringAsFixed(1);

          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 280,
                  pinned: true,
                  stretch: true,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  backgroundColor: AppColors.backgroundColor,
                  automaticallyImplyLeading: false,
                  leading: _CircleAction(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => AppNavigation.pop(),
                  ),
                  actions: [
                    _CircleAction(
                      icon: Icons.share_rounded,
                      onTap: () => SharePlus.instance.share(
                        ShareParams(
                          text: LocaleKeys.servicesShareText.tr(
                            namedArgs: {
                              'name': resturant.name ?? '',
                              'address': resturant.address ?? '',
                              'lat': resturant.latitude ?? '',
                              'lng': resturant.longitude ?? '',
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          selectedImage ?? resturant.logo ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              SvgPicture.asset(
                                AssetsStrings.noImages,
                                fit: BoxFit.cover,
                              ),
                        ),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0x55000000), Color(0x00000000)],
                              stops: [0, 0.35],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name, type and rating
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (kind != null) ...[
                              BookingTypeIcon(
                                itemType: kind.itemType,
                                size: 44,
                              ),
                              const SizedBox(width: 12),
                            ],
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    resturant.name ?? '',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontFamily: BaseConstant.cairoBold,
                                      color: AppColors.black700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Color(0xFFFFC83D),
                                        size: 18,
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        rating,
                                        style: const TextStyle(
                                          fontFamily: BaseConstant.cairoBold,
                                          color: AppColors.black700,
                                        ),
                                      ),
                                      Text(
                                        '  (${rates.length} ${LocaleKeys.servicesReviews.tr()})',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.natural500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if ((resturant.address ?? '').isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                color: AppColors.primary500,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  resturant.address!,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: AppColors.natural600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],

                        // Gallery
                        if (images.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 72,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: images.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                final url = images[index].url ?? '';
                                final selected = url == selectedImage;
                                return GestureDetector(
                                  onTap: () =>
                                      setState(() => selectedImage = url),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 72,
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: selected
                                            ? AppColors.primary500
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: CustomNetworkImage(
                                        imageUrl: url,
                                        width: 68,
                                        height: 68,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],

                        // About
                        if ((resturant.description ?? '').isNotEmpty) ...[
                          const SizedBox(height: 20),
                          AppSectionHeader(
                            title: LocaleKeys.servicesAbout.tr(),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            resturant.description!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.natural600,
                              height: 1.6,
                            ),
                          ),
                        ],

                        // Branches (customers pick one to see its services)
                        if (!isVendor && uniqueBranches.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          AppSectionHeader(
                            title: LocaleKeys.servicesBranches.tr(),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            LocaleKeys.servicesBranchHint.tr(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.natural500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final branch in uniqueBranches)
                                ChoiceChip(
                                  label: Text(branch.name ?? ''),
                                  avatar: Icon(
                                    Icons.storefront_rounded,
                                    size: 18,
                                    color: selectedBranch?.id == branch.id
                                        ? Colors.white
                                        : AppColors.primary500,
                                  ),
                                  showCheckmark: false,
                                  selected: selectedBranch?.id == branch.id,
                                  selectedColor: AppColors.primary500,
                                  backgroundColor: Colors.white,
                                  side: BorderSide(
                                    color: selectedBranch?.id == branch.id
                                        ? AppColors.primary500
                                        : AppColors.natural200,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  labelStyle: TextStyle(
                                    fontFamily: BaseConstant.cairoBold,
                                    color: selectedBranch?.id == branch.id
                                        ? Colors.white
                                        : AppColors.black700,
                                  ),
                                  onSelected: (_) =>
                                      setState(() => selectedBranch = branch),
                                ),
                            ],
                          ),
                        ],

                        // Location
                        const SizedBox(height: 20),
                        AppSectionHeader(
                          title: LocaleKeys.servicesLocation.tr(),
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: MapLocationWidget(
                            latitude:
                                double.tryParse(resturant.latitude ?? '') ??
                                0.0,
                            longitude:
                                double.tryParse(resturant.longitude ?? '') ??
                                0.0,
                          ),
                        ),

                        // Reviews
                        if (rates.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          AppSectionHeader(
                            title:
                                '${LocaleKeys.servicesReviews.tr()} (${rates.length})',
                          ),
                          const SizedBox(height: 10),
                          for (final rate in rates)
                            AppCard(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProfileAvatar(
                                    imageUrl: rate.clientImage,
                                    name: rate.clientName,
                                    size: 44,
                                    borderWidth: 0,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                rate.clientName ?? '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontFamily:
                                                      BaseConstant.cairoBold,
                                                  color: AppColors.black700,
                                                ),
                                              ),
                                            ),
                                            RatingBarIndicator(
                                              rating:
                                                  double.tryParse(
                                                    rate.rating ?? '',
                                                  ) ??
                                                  0,
                                              itemSize: 14,
                                              unratedColor:
                                                  AppColors.natural200,
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                    Icons.star_rounded,
                                                    color: Color(0xFFFFC83D),
                                                  ),
                                            ),
                                          ],
                                        ),
                                        if ((rate.comment ?? '')
                                            .isNotEmpty) ...[
                                          const SizedBox(height: 4),
                                          Text(
                                            rate.comment!,
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                                  color: AppColors.natural600,
                                                ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: isVendor
                ? null
                : Container(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 16,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      top: false,
                      child: Row(
                        children: [
                          if (selectedBranch != null) ...[
                            Expanded(
                              child: SizedBox(
                                height: 52,
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    if (isGuest) {
                                      UserValidationHelper.showUserValidation();
                                      return;
                                    }
                                    AppNavigation.pushNamed(
                                      AppRoutes.serviceScreen,
                                      arguments: {
                                        'serviceBranches': uniqueBranchesById,
                                        'title': resturant.name ?? '',
                                        'branchID': selectedBranch?.id ?? 0,
                                        'serviceCubit': serviceCubit,
                                      },
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: AppColors.primary300,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.room_service_rounded,
                                    size: 20,
                                  ),
                                  label: Text(
                                    LocaleKeys.servicesServices.tr(),
                                    style: const TextStyle(
                                      fontFamily: BaseConstant.cairoBold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          Expanded(
                            child: AppGradientButton(
                              label: isGuest
                                  ? LocaleKeys.servicesLoginToBook.tr()
                                  : LocaleKeys.servicesBookNow.tr(),
                              icon: Icons.event_available_rounded,
                              onTap: () {
                                if (isGuest) {
                                  UserValidationHelper.showUserValidation();
                                  return;
                                }
                                if (kind == ServiceKind.trip) {
                                  serviceCubit.getAvaliableTrips(
                                    tripID: resturant.id ?? 0,
                                    title: resturant.name ?? '',
                                    serviceCubit: serviceCubit,
                                  );
                                  return;
                                }
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                  ),
                                  builder: (_) => BookingTimeBottomSheet(
                                    serviceCubit: serviceCubit,
                                    type: widget.type,
                                    title: resturant.name ?? '',
                                    serviceID: resturant.id ?? 0,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        }

        return const Scaffold();
      },
    );
  }
}

class _CircleAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleAction({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        elevation: 2,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(icon, size: 20, color: AppColors.black700),
          ),
        ),
      ),
    );
  }
}
