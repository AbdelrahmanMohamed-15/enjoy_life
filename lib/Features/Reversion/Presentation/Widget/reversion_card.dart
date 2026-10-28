import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Widget/booking_type_icon.dart';
import 'package:easy_life/Features/Reversion/Domain/Entities/reversion_entity.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Routes/app_routes.dart';
import '../../../../Core/Themes/app_colors.dart';
import 'reversion_service_type.dart';

class ReversionCard extends StatelessWidget {
  final ReversionData reversion;
  final int serviceID;
  const ReversionCard({
    super.key,
    required this.reversion,
    required this.serviceID,
  });

  String _formatDate(BuildContext context) {
    final date = reversion.order?.createdAt?.toLocal();
    if (date == null) return '';
    try {
      final locale = context.locale.toString();
      return '${DateFormat.yMMMd(locale).format(date)} • ${DateFormat.jm(locale).format(date)}';
    } catch (_) {
      return '${date.year}-${date.month}-${date.day}';
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final order = reversion.order;
    final client = reversion.client;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final date = _formatDate(context);
    final servicesCount = reversion.orderDetails?.length ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => AppNavigation.pushNamed(
            AppRoutes.reversionDetails,
            arguments: {'reversionData': reversion},
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  children: [
                    _ServiceImage(
                      imageUrl: order?.image,
                      itemType: ReversionServiceType.itemType(serviceID),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order?.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontFamily: BaseConstant.cairoBold,
                              color: AppColors.black700,
                            ),
                          ),
                          if ((order?.orderCode ?? '').isNotEmpty)
                            Text(
                              LocaleKeys.orderNumber.tr(
                                namedArgs: {'code': order!.orderCode!},
                              ),
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontFamily: BaseConstant.cairoBold,
                                color: AppColors.primary600,
                              ),
                            ),
                          if (date.isNotEmpty)
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_rounded,
                                  size: 12,
                                  color: AppColors.natural500,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    date,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: AppColors.natural500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          order?.totalPrice ?? '0',
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: BaseConstant.cairoBold,
                            color: AppColors.primary500,
                          ),
                        ),
                        Text(
                          LocaleKeys.commonCurrencyEgp.tr(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.natural500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.natural50,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      if ((client?.fullName ?? '').isNotEmpty) ...[
                        const Icon(
                          Icons.person_rounded,
                          size: 18,
                          color: AppColors.primary500,
                        ),
                        const SizedBox(width: 6),
                      ],
                      Expanded(
                        child: Text(
                          client?.fullName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontFamily: BaseConstant.cairoBold,
                            color: AppColors.natural600,
                          ),
                        ),
                      ),
                      if (servicesCount > 0) ...[
                        const Icon(
                          Icons.shopping_bag_rounded,
                          size: 15,
                          color: AppColors.natural500,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '$servicesCount',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.natural600,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Transform.flip(
                        flipX: isRtl,
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          size: 20,
                          color: AppColors.natural400,
                        ),
                      ),
                    ],
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

class _ServiceImage extends StatelessWidget {
  final String? imageUrl;
  final String itemType;
  const _ServiceImage({this.imageUrl, required this.itemType});

  @override
  Widget build(BuildContext context) {
    const double size = 60;
    final url = imageUrl?.trim() ?? '';
    final fallback = BookingTypeIcon(itemType: itemType, size: size);
    if (url.isEmpty) return fallback;
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.28),
      child: Image.network(
        url,
        height: size,
        width: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => fallback,
      ),
    );
  }
}
