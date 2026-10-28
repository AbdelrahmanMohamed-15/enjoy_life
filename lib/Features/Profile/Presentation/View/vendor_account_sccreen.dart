import 'package:easy_life/Core/Extentions/center_ext.dart';
import 'package:easy_life/Core/Helper/vendor_service_types.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Routes/app_routes.dart';
import 'package:easy_life/Core/Widget/booking_type_icon.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/language_bottom_sheet.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/logout_dialog.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/profile_header.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/profile_menu_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Helper/dependency_injection_helper.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../Widget/delete_bottom_sheet.dart';
import '../cubit/profile_cubit.dart';

class VendorAccountSccreen extends StatelessWidget {
  const VendorAccountSccreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = ProfileCubit.get(context);
    var theme = Theme.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) => ProfileHeader(
                userData: DependencyInjectionHelper()
                    .sl<AuthHandlerInterface>()
                    .getUserData(),
                onEdit: () async {
                  await AppNavigation.pushNamed(AppRoutes.editProfile);
                  profileCubit.refreshUserData();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 22, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(LocaleKeys.profileSectionQuickAdd.tr()),
                  const _QuickAddRow(),
                  const SizedBox(height: 22),
                  ProfileMenuSection(
                    title: LocaleKeys.profileSectionBusiness.tr(),
                    tiles: [
                      ProfileMenuTile(
                        icon: Icons.category_rounded,
                        color: const Color(0xFF8E6CEF),
                        title: LocaleKeys.vendorAddCategory.tr(),
                        onTap: () =>
                            AppNavigation.pushNamed(AppRoutes.addCategory),
                      ),
                      ProfileMenuTile(
                        icon: Icons.storefront_rounded,
                        color: const Color(0xFF3A7BD5),
                        title: LocaleKeys.vendorAddBranch.tr(),
                        onTap: () =>
                            AppNavigation.pushNamed(AppRoutes.addBranch),
                      ),
                      ProfileMenuTile(
                        icon: Icons.room_service_rounded,
                        color: AppColors.primary500,
                        title: LocaleKeys.vendorAddService.tr(),
                        onTap: () => AppNavigation.pushNamed(
                          AppRoutes.addNewServiceScreen,
                        ),
                      ),
                      ProfileMenuTile(
                        icon: Icons.playlist_add_rounded,
                        color: const Color(0xFF16967D),
                        title: LocaleKeys.vendorAddServiceOption.tr(),
                        onTap: () =>
                            AppNavigation.pushNamed(AppRoutes.addServiceOption),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  ProfileMenuSection(
                    title: LocaleKeys.profileSectionPreferences.tr(),
                    tiles: [
                      ProfileMenuTile(
                        icon: Icons.translate_rounded,
                        color: const Color(0xFF16967D),
                        title: LocaleKeys.profileLanguage.tr(),
                        trailingText: context.locale.languageCode == 'ar'
                            ? LocaleKeys.languageArabic.tr()
                            : LocaleKeys.languageEnglish.tr(),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => const LanguageBottomSheet(),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  ProfileMenuSection(
                    tiles: [
                      ProfileMenuTile(
                        icon: Icons.logout_rounded,
                        color: AppColors.natural600,
                        title: LocaleKeys.profileLogout.tr(),
                        onTap: () => confirmLogout(context),
                      ),
                      ProfileMenuTile(
                        icon: Icons.delete_forever_rounded,
                        color: AppColors.errorColor,
                        title: LocaleKeys.profileDeleteAccount.tr(),
                        isDestructive: true,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) {
                              return DeleteBottomSheet(
                                profileCubit: profileCubit,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    BaseConstant.appVersion,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.natural400,
                    ),
                  ).setCenter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Add restaurant / hotel / trip shortcuts, limited to the services this
/// vendor runs.
class _QuickAddRow extends StatefulWidget {
  const _QuickAddRow();

  @override
  State<_QuickAddRow> createState() => _QuickAddRowState();
}

class _QuickAddRowState extends State<_QuickAddRow> {
  final vendorTypes = DependencyInjectionHelper().sl<VendorServiceTypes>();

  @override
  void initState() {
    super.initState();
    vendorTypes.load();
  }

  @override
  Widget build(BuildContext context) {
    // Rebuild the labels when the language changes
    context.locale;
    final shortcuts = [
      (1, 'restaurant', 'resturant', LocaleKeys.vendorAddRestaurant.tr()),
      (2, 'hotel', 'hotel', LocaleKeys.vendorAddHotel.tr()),
      (3, 'trip', 'trip', LocaleKeys.vendorAddTrip.tr()),
    ];
    return ValueListenableBuilder(
      valueListenable: vendorTypes.types,
      builder: (context, _, _) {
        final visible = shortcuts
            .where((s) => vendorTypes.current.contains(s.$1))
            .toList();
        return Row(
          children: [
            for (var i = 0; i < visible.length; i++) ...[
              if (i > 0) const SizedBox(width: 10),
              _QuickAddCard(
                itemType: visible[i].$2,
                title: visible[i].$4,
                onTap: () => AppNavigation.pushNamed(
                  AppRoutes.addService,
                  arguments: {'type': visible[i].$3, 'isEdit': false},
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 6, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontFamily: BaseConstant.cairoBold,
          color: AppColors.natural500,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

/// Large shortcut card to add a restaurant, hotel or trip.
class _QuickAddCard extends StatelessWidget {
  final String itemType;
  final String title;
  final VoidCallback onTap;
  const _QuickAddCard({
    required this.itemType,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      BookingTypeIcon(itemType: itemType, size: 54),
                      PositionedDirectional(
                        bottom: -4,
                        end: -4,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: AppColors.natural200),
                          ),
                          child: const Icon(
                            Icons.add_rounded,
                            size: 14,
                            color: AppColors.primary600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: BaseConstant.cairoBold,
                      color: AppColors.black700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
