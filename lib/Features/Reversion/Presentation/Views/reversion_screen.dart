import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/Helper/vendor_service_types.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Routes/app_routes.dart';
import 'package:easy_life/Core/Widget/booking_type_icon.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../Widget/reversion_service_type.dart';

/// Reservations hub: one card per service, each opening its own list screen.
class ReversionScreen extends StatefulWidget {
  const ReversionScreen({super.key});

  @override
  State<ReversionScreen> createState() => _ReversionScreenState();
}

class _ReversionScreenState extends State<ReversionScreen> {
  final vendorTypes = DependencyInjectionHelper().sl<VendorServiceTypes>();

  @override
  void initState() {
    super.initState();
    vendorTypes.load();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          LocaleKeys.reversionTitle.tr(),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 20,
            color: AppColors.primary500,
            fontFamily: BaseConstant.cairoBold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        children: [
          Text(
            LocaleKeys.reversionHubSubtitle.tr(),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.natural500,
            ),
          ),
          const SizedBox(height: 20),
          // Only the services this vendor actually runs
          ValueListenableBuilder(
            valueListenable: vendorTypes.types,
            builder: (context, _, _) => Column(
              children: [
                for (final serviceID in ReversionServiceType.all)
                  if (vendorTypes.current.contains(serviceID))
                    _ServiceCard(
                      serviceID: serviceID,
                      onTap: () => AppNavigation.pushNamed(
                        AppRoutes.reversionList,
                        arguments: {'serviceID': serviceID},
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final int serviceID;
  final VoidCallback onTap;
  const _ServiceCard({required this.serviceID, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(22),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                BookingTypeIcon(
                  itemType: ReversionServiceType.itemType(serviceID),
                  size: 68,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ReversionServiceType.title(serviceID),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontFamily: BaseConstant.cairoBold,
                          color: AppColors.black700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        ReversionServiceType.description(serviceID),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.natural500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary100.withValues(alpha: 0.6),
                  ),
                  child: Transform.flip(
                    flipX: isRtl,
                    child: const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.primary600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
