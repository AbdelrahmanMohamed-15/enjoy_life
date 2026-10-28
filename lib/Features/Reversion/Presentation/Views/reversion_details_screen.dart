import 'package:easy_life/Core/Helper/url_launcher_helper.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_life/Core/Widget/custom_network_image.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/profile_avatar.dart';
import 'package:easy_life/Features/Reversion/Domain/Entities/reversion_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';

class ReversionDetailsScreen extends StatelessWidget {
  final ReversionData reversionData;
  const ReversionDetailsScreen({super.key, required this.reversionData});

  Color _statusColor(String status) => switch (status.toLowerCase()) {
    'pending' => const Color(0xFFF59E0B),
    'completed' => const Color(0xFF2EAD5B),
    'cancelled' => AppColors.errorColor,
    _ => AppColors.natural500,
  };

  String _statusLabel(String status) => switch (status.toLowerCase()) {
    'pending' => LocaleKeys.reversionStatusPending.tr(),
    'completed' => LocaleKeys.reversionStatusApproved.tr(),
    'cancelled' => LocaleKeys.reversionStatusCancelled.tr(),
    _ => status,
  };

  String _formatDate(BuildContext context, DateTime? date) {
    if (date == null) return '';
    try {
      final locale = context.locale.toString();
      return '${DateFormat.yMMMd(locale).format(date.toLocal())} • ${DateFormat.jm(locale).format(date.toLocal())}';
    } catch (_) {
      return '${date.year}-${date.month}-${date.day}';
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final order = reversionData.order;
    final client = reversionData.client;
    final details = reversionData.orderDetails ?? [];
    final currency = LocaleKeys.commonCurrencyEgp.tr();
    final status = order?.status ?? '';
    final statusColor = _statusColor(status);
    final phone = client?.phone ?? '';

    Widget priceRow(String label, String value, {bool total = false}) =>
        Padding(
          padding: EdgeInsets.symmetric(vertical: total ? 4 : 5),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: total ? AppColors.black700 : AppColors.natural600,
                    fontFamily: total ? BaseConstant.cairoBold : null,
                    fontSize: total ? 16 : 14,
                  ),
                ),
              ),
              Text(
                '$value $currency',
                style: TextStyle(
                  fontFamily: BaseConstant.cairoBold,
                  color: total ? AppColors.primary500 : AppColors.black700,
                  fontSize: total ? 18 : 14,
                ),
              ),
            ],
          ),
        );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppPageBar(title: LocaleKeys.reversionDetailsTitle.tr()),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          // Order header
          AppCard(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CustomNetworkImage(
                    imageUrl: order?.image,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
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
                      Text(
                        LocaleKeys.orderNumber.tr(
                          namedArgs: {'code': order?.orderCode ?? ''},
                        ),
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: BaseConstant.cairoBold,
                          color: AppColors.primary600,
                        ),
                      ),
                      Text(
                        _formatDate(context, order?.createdAt),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.natural500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (status.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _statusLabel(status),
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: BaseConstant.cairoBold,
                        color: statusColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Customer
          if ((client?.fullName ?? '').isNotEmpty || phone.isNotEmpty)
            AppCard(
              margin: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  ProfileAvatar(
                    imageUrl: client?.image,
                    name: client?.fullName,
                    size: 48,
                    borderWidth: 0,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          client?.fullName ?? '',
                          style: const TextStyle(
                            fontFamily: BaseConstant.cairoBold,
                            color: AppColors.black700,
                          ),
                        ),
                        if ((client?.email ?? '').isNotEmpty)
                          Text(
                            client!.email!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.natural500,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (phone.isNotEmpty)
                    Material(
                      color: const Color(0xFF2EAD5B).withValues(alpha: 0.12),
                      shape: const CircleBorder(),
                      child: IconButton(
                        onPressed: () => UrlLauncherHelper.openPhone(phone),
                        icon: const Icon(
                          Icons.call_rounded,
                          color: Color(0xFF2EAD5B),
                        ),
                      ),
                    ),
                ],
              ),
            ),

          // Booked services
          if (details.isNotEmpty) ...[
            AppSectionHeader(title: LocaleKeys.reversionServices.tr()),
            const SizedBox(height: 10),
            for (final item in details)
              AppCard(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: CustomNetworkImage(
                        imageUrl: item.serviceBranch?.image,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.serviceBranch?.name ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: BaseConstant.cairoBold,
                              color: AppColors.black700,
                            ),
                          ),
                          if (item.startTime != null)
                            Text(
                              _formatDate(context, item.startTime),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.natural500,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      '${item.totalPrice ?? 0} $currency',
                      style: const TextStyle(
                        fontFamily: BaseConstant.cairoBold,
                        color: AppColors.black700,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 6),
          ],

          // Payment summary
          AppCard(
            child: Column(
              children: [
                priceRow(
                  LocaleKeys.reversionPrice.tr(),
                  order?.totalPrice ?? '0',
                ),
                priceRow(
                  LocaleKeys.reversionShipping.tr(),
                  order?.shippingFees ?? '0',
                ),
                priceRow(LocaleKeys.reversionTax.tr(), order?.taxesFees ?? '0'),
                priceRow(
                  LocaleKeys.reversionDiscount.tr(),
                  order?.couponDiscount ?? '0',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(height: 1, color: AppColors.natural200),
                ),
                priceRow(
                  LocaleKeys.reversionTotal.tr(),
                  order?.totalPrice ?? '0',
                  total: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
