import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Widget/booking_type_icon.dart';
import 'package:easy_life/Core/Widget/custom_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../Domain/Entity/order_history_entity.dart';

class OrderCard extends StatelessWidget {
  final OrderHistoryData order;

  const OrderCard({super.key, required this.order});

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return const Color(0xFFF59E0B);
      case "completed":
        return const Color(0xFF2EAD5B);
      case "cancelled":
        return AppColors.errorColor;
      default:
        return AppColors.natural500;
    }
  }

  IconData _statusIcon(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Icons.hourglass_top_rounded;
      case "completed":
        return Icons.check_circle_rounded;
      case "cancelled":
        return Icons.cancel_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  String _statusLabel(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return LocaleKeys.orderTabPending.tr();
      case 'completed':
        return LocaleKeys.orderTabCompleted.tr();
      case 'cancelled':
        return LocaleKeys.orderTabCancelled.tr();
      default:
        return status ?? '';
    }
  }

  String _formatDate(BuildContext context) {
    final raw = order.createdAt ?? '';
    final date = DateTime.tryParse(raw)?.toLocal();
    if (date == null) return raw.split('T').first;
    try {
      final locale = context.locale.toString();
      return '${DateFormat.yMMMd(locale).format(date)} • ${DateFormat.jm(locale).format(date)}';
    } catch (_) {
      return raw.split('T').first;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final statusColor = _statusColor(order.status ?? '');
    final items = order.items ?? [];
    final currency = LocaleKeys.commonCurrencyEgp.tr();
    // The provider (restaurant / hotel / trip) is the same for every item
    final provider = items
        .where((item) => (item.providerName ?? '').trim().isNotEmpty)
        .firstOrNull;
    final providerName = provider?.providerName?.trim() ?? '';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: provider, order number, date and status
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
            child: Row(
              children: [
                _ProviderImage(
                  imageUrl: provider?.providerImage,
                  providerType: provider?.providerType,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (providerName.isNotEmpty)
                        Text(
                          providerName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontFamily: BaseConstant.cairoBold,
                            color: AppColors.black700,
                          ),
                        ),
                      GestureDetector(
                        onTap: () => _copyCode(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                LocaleKeys.orderNumber.tr(
                                  namedArgs: {'code': order.orderCode ?? ''},
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: providerName.isNotEmpty
                                    ? theme.textTheme.bodySmall?.copyWith(
                                        fontFamily: BaseConstant.cairoBold,
                                        color: AppColors.primary600,
                                      )
                                    : theme.textTheme.titleMedium?.copyWith(
                                        fontFamily: BaseConstant.cairoBold,
                                        color: AppColors.black700,
                                      ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.copy_rounded,
                              size: 14,
                              color: AppColors.natural400,
                            ),
                          ],
                        ),
                      ),
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
                              _formatDate(context),
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _statusIcon(order.status ?? ''),
                        size: 14,
                        color: statusColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _statusLabel(order.status),
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: BaseConstant.cairoBold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Items
          if (items.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.natural50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  for (var i = 0; i < items.length; i++) ...[
                    if (i > 0)
                      const Divider(
                        height: 1,
                        indent: 50,
                        color: AppColors.natural200,
                      ),
                    _OrderItemRow(item: items[i], currency: currency),
                  ],
                ],
              ),
            ),

          // Info chips
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _InfoChip(
                  icon: Icons.shopping_bag_rounded,
                  text: LocaleKeys.orderItemsCount.tr(
                    namedArgs: {'count': '${items.length}'},
                  ),
                ),
                if ((order.paymentType ?? '').isNotEmpty)
                  _InfoChip(
                    icon: Icons.payments_rounded,
                    text: order.paymentType!,
                  ),
                if ((order.address ?? '').isNotEmpty)
                  _InfoChip(
                    icon: Icons.location_on_rounded,
                    text: order.address!,
                  ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Divider(height: 1, color: AppColors.natural200),
          ),

          // Footer: QR button and total
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () => _showQrSheet(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.natural100,
                    backgroundColor: AppColors.primary600,
                    side: const BorderSide(color: AppColors.primary600),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.qr_code_2_rounded, size: 20),
                  label: Text(
                    LocaleKeys.orderShowQr.tr(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      LocaleKeys.orderTotal.tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.natural500,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${order.totalPrice ?? 0}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: BaseConstant.cairoBold,
                              color: AppColors.primary500,
                            ),
                          ),
                          TextSpan(
                            text: ' $currency',
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: BaseConstant.cairoBold,
                              color: AppColors.natural500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _copyCode() {
    final code = order.orderCode ?? '';
    if (code.isEmpty) return;
    Clipboard.setData(ClipboardData(text: code));
    showCustomSnackBar(
      LocaleKeys.orderCodeCopied.tr(),
      type: SnackBarType.success,
    );
  }

  void _showQrSheet(BuildContext context) {
    var theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.natural300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                LocaleKeys.orderQrTitle.tr(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontFamily: BaseConstant.cairoBold,
                  color: AppColors.black700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                LocaleKeys.orderQrHint.tr(),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.natural500,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary200, width: 1.5),
                ),
                child: QrImageView(
                  data: order.orderCode ?? '',
                  version: QrVersions.auto,
                  size: 200,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                LocaleKeys.orderNumber.tr(
                  namedArgs: {'code': order.orderCode ?? ''},
                ),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontFamily: BaseConstant.cairoBold,
                  color: AppColors.primary600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  final Item item;
  final String currency;
  const _OrderItemRow({required this.item, required this.currency});

  /// Prefer the backend's `provider_type`; otherwise infer it from which
  /// venue fields are filled in.
  String get _itemType {
    if ((item.providerType ?? '').isNotEmpty) return item.providerType!;
    if ((item.restaurantTable ?? '').isNotEmpty ||
        (item.restaurant ?? '').isNotEmpty) {
      return 'restaurant';
    }
    if ((item.hotemRoom ?? '').isNotEmpty || (item.hotel ?? '').isNotEmpty) {
      return 'hotel';
    }
    if ((item.tripSchedule ?? '').isNotEmpty || (item.trip ?? '').isNotEmpty) {
      return 'trip';
    }
    return item.type ?? '';
  }

  String get _title {
    for (final value in [
      item.name,
      item.restaurant,
      item.hotel,
      item.trip,
      item.service,
    ]) {
      // the API sends "-" as the name of bookings
      final text = value?.trim() ?? '';
      if (text.isNotEmpty && text != '-') return text;
    }
    return '—';
  }

  String get _subtitle {
    final parts = <String>[
      if ((item.restaurantTable ?? '').isNotEmpty)
        '${LocaleKeys.servicesTableNumber.tr()} ${item.restaurantTable}',
      if ((item.hotemRoom ?? '').isNotEmpty)
        '${LocaleKeys.servicesRoomNumber.tr()} ${item.hotemRoom}',
      if ((item.tripSchedule ?? '').isNotEmpty) item.tripSchedule!,
      if ((item.branch ?? '').isNotEmpty) item.branch!,
    ];
    return parts.join('  •  ');
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final subtitle = _subtitle;
    final startTime = item.startTime ?? '';
    final endTime = item.endTime ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          BookingTypeIcon(itemType: _itemType, size: 40),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: BaseConstant.cairoBold,
                    color: AppColors.black700,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.natural500,
                    ),
                  ),
                if (startTime.isNotEmpty)
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        size: 12,
                        color: AppColors.natural500,
                      ),
                      const SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          endTime.isNotEmpty
                              ? '$startTime  →  $endTime'
                              : startTime,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.natural500,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${item.price ?? 0} $currency',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontFamily: BaseConstant.cairoBold,
              color: AppColors.black700,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 220),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.natural50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.natural200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary500),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: AppColors.natural600),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProviderImage extends StatelessWidget {
  final String? imageUrl;
  final String? providerType;
  const _ProviderImage({this.imageUrl, this.providerType});

  @override
  Widget build(BuildContext context) {
    const double size = 52;
    final url = imageUrl?.trim() ?? '';
    final Widget fallback = BookingTypeIcon.supports(providerType)
        ? BookingTypeIcon(itemType: providerType!, size: size)
        : Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: AppColors.primary100.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              color: AppColors.primary600,
            ),
          );
    if (url.isEmpty) return fallback;
    return Container(
      height: size,
      width: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.natural200),
      ),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => fallback,
      ),
    );
  }
}
