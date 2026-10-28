import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// A small fact shown under the item title, e.g. capacity or floor.
class ItemFact {
  final IconData icon;
  final String text;
  const ItemFact(this.icon, this.text);
}

/// Table / room / trip schedule / service row with an "Add to cart" button
/// that shows progress and then a check once added.
class BookableItemCard extends StatefulWidget {
  final Widget leading;
  final String title;
  final String? subtitle;
  final List<ItemFact> facts;
  final String price;

  /// Original price shown struck through when there is a discount
  final String? oldPrice;

  /// Returns whether the item was added
  final Future<bool> Function() onAdd;
  const BookableItemCard({
    super.key,
    required this.leading,
    required this.title,
    required this.price,
    required this.onAdd,
    this.subtitle,
    this.facts = const [],
    this.oldPrice,
  });

  @override
  State<BookableItemCard> createState() => _BookableItemCardState();
}

class _BookableItemCardState extends State<BookableItemCard> {
  bool _busy = false;
  bool _added = false;

  Future<void> _add() async {
    if (_busy) return;
    setState(() => _busy = true);
    final ok = await widget.onAdd();
    if (!mounted) return;
    setState(() {
      _busy = false;
      if (ok) _added = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final currency = LocaleKeys.commonCurrencyEgp.tr();
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.leading,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: BaseConstant.cairoBold,
                    color: AppColors.black700,
                    fontSize: 15,
                  ),
                ),
                if ((widget.subtitle ?? '').isNotEmpty)
                  Text(
                    widget.subtitle!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.natural500,
                    ),
                  ),
                if (widget.facts.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final fact in widget.facts)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.natural50,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.natural200),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                fact.icon,
                                size: 13,
                                color: AppColors.primary500,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                fact.text,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.natural600,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        spacing: 6,
                        children: [
                          Text(
                            '${widget.price} $currency',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: BaseConstant.cairoBold,
                              color: AppColors.primary500,
                            ),
                          ),
                          if ((widget.oldPrice ?? '').isNotEmpty)
                            Text(
                              '${widget.oldPrice} $currency',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.natural400,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                    ),
                    _AddButton(busy: _busy, added: _added, onTap: _add),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final bool busy;
  final bool added;
  final VoidCallback onTap;
  const _AddButton({
    required this.busy,
    required this.added,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF2EAD5B);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: added
            ? null
            : const LinearGradient(
                colors: [AppColors.primary400, AppColors.primary600],
              ),
        color: added ? green.withValues(alpha: 0.12) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          // Adding again is allowed (e.g. a second service), but not while
          // a request is running
          onTap: busy ? null : onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (busy)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                else
                  Icon(
                    added
                        ? Icons.check_circle_rounded
                        : Icons.add_shopping_cart_rounded,
                    size: 18,
                    color: added ? green : Colors.white,
                  ),
                const SizedBox(width: 6),
                Text(
                  added
                      ? LocaleKeys.servicesAdded.tr()
                      : LocaleKeys.servicesAddToCart.tr(),
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: BaseConstant.cairoBold,
                    color: added ? green : Colors.white,
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
