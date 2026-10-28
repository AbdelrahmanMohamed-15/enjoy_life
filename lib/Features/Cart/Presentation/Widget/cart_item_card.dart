import 'package:easy_life/Core/Constant/assets_strings.dart';
import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Core/Widget/booking_type_icon.dart';
import 'package:easy_life/Features/Cart/Domain/Entity/cart_entity.dart';
import 'package:easy_life/Features/Cart/Presentation/Widget/quantity_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

class CartItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onRemove;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  const CartItemCard({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onIncrease,
    required this.onDecrease,
  });

  String get _itemType => item.options?.itemType ?? '';

  String get _typeLabel => switch (_itemType) {
    'restaurant' => LocaleKeys.cartTypeRestaurant.tr(),
    'hotel' => LocaleKeys.cartTypeHotel.tr(),
    'trip' => LocaleKeys.cartTypeTrip.tr(),
    _ => LocaleKeys.cartTypeService.tr(),
  };

  String get _price =>
      (item.subtotal ?? '').isNotEmpty ? item.subtotal! : item.price ?? '0';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final startTime = item.options?.startTime ?? '';
    final endTime = item.options?.endTime ?? '';
    final description = item.options?.description ?? '';
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLeading(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _TypeChip(label: _typeLabel),
                    const Spacer(),
                    _RemoveButton(onTap: () => _confirmRemove(context)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  item.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.black700,
                    fontFamily: BaseConstant.cairoBold,
                    height: 1.3,
                  ),
                ),
                if (description.isNotEmpty)
                  Html(
                    data: description,
                    style: {
                      "body": Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        color: AppColors.natural500,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        fontSize: FontSize(13),
                      ),
                      "p": Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    },
                  ),
                if (startTime.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  _InfoRow(
                    icon: Icons.schedule_rounded,
                    text: endTime.isNotEmpty
                        ? '$startTime  →  $endTime'
                        : startTime,
                  ),
                ],
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: _price,
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: BaseConstant.cairoBold,
                                color: AppColors.primary500,
                              ),
                            ),
                            TextSpan(
                              text: ' ${LocaleKeys.commonCurrencyEgp.tr()}',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: BaseConstant.cairoBold,
                                color: AppColors.natural500,
                              ),
                            ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (_itemType == 'service')
                      QuantityWidget(
                        quantity: item.qty ?? 0,
                        onAdd: onIncrease,
                        onRemove: onDecrease,
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

  Widget _buildLeading() {
    const double size = 84;
    if (BookingTypeIcon.supports(_itemType)) {
      return BookingTypeIcon(itemType: _itemType, size: size);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.28),
      child: Image.network(
        item.options?.image ?? '',
        height: size,
        width: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return SvgPicture.asset(
            AssetsStrings.noImages,
            height: size,
            width: size,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  Future<void> _confirmRemove(BuildContext context) async {
    var theme = Theme.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.darkRed.withValues(alpha: 0.1),
          ),
          child: const Icon(
            Icons.delete_outline_rounded,
            color: AppColors.darkRed,
            size: 30,
          ),
        ),
        title: Text(
          LocaleKeys.cartRemoveTitle.tr(),
          style: theme.textTheme.titleMedium?.copyWith(
            color: AppColors.black700,
            fontFamily: BaseConstant.cairoBold,
          ),
        ),
        content: Text(
          LocaleKeys.cartRemoveMessage.tr(),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.natural500,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(
              LocaleKeys.commonCancel.tr(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.natural600,
              ),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.darkRed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(
              LocaleKeys.cartRemove.tr(),
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) onRemove();
  }
}

class _TypeChip extends StatelessWidget {
  final String label;
  const _TypeChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary100.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontFamily: BaseConstant.cairoBold,
          color: AppColors.primary700,
        ),
      ),
    );
  }
}

class _RemoveButton extends StatelessWidget {
  final VoidCallback onTap;
  const _RemoveButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.darkRed.withValues(alpha: 0.08),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.all(7),
          child: Icon(
            Icons.delete_outline_rounded,
            size: 20,
            color: AppColors.darkRed,
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: AppColors.natural500),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: AppColors.natural600),
          ),
        ),
      ],
    );
  }
}
