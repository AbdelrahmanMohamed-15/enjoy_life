import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../Core/Themes/app_colors.dart';

class NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const NavItem(this.icon, this.activeIcon, this.label);
}

class NavBarItemWidget {
  NavBarItemWidget._();

  static List<NavItem> get userItems => [
    NavItem(
      Icons.home_outlined,
      Icons.home_rounded,
      LocaleKeys.mainNavHome.tr(),
    ),
    NavItem(
      Icons.shopping_bag_outlined,
      Icons.shopping_bag_rounded,
      LocaleKeys.mainNavCart.tr(),
    ),
    NavItem(
      Icons.favorite_border_rounded,
      Icons.favorite_rounded,
      LocaleKeys.mainNavFavorites.tr(),
    ),
    NavItem(
      Icons.person_outline_rounded,
      Icons.person_rounded,
      LocaleKeys.mainNavAccount.tr(),
    ),
  ];

  static List<NavItem> get providerItems => [
    NavItem(
      Icons.home_outlined,
      Icons.home_rounded,
      LocaleKeys.mainNavHome.tr(),
    ),
    NavItem(
      Icons.qr_code_scanner_rounded,
      Icons.qr_code_scanner_rounded,
      LocaleKeys.mainNavScan.tr(),
    ),
    NavItem(
      Icons.event_note_outlined,
      Icons.event_note_rounded,
      LocaleKeys.mainNavReservations.tr(),
    ),
    NavItem(
      Icons.person_outline_rounded,
      Icons.person_rounded,
      LocaleKeys.mainNavAccount.tr(),
    ),
  ];
}

/// Floating bottom bar; the selected tab gets an orange pill with its label.
class AppBottomNav extends StatelessWidget {
  final List<NavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  const AppBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++)
            Expanded(
              flex: i == currentIndex ? 3 : 2,
              child: _NavButton(
                item: items[i],
                selected: i == currentIndex,
                onTap: () => onTap(i),
              ),
            ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final NavItem item;
  final bool selected;
  final VoidCallback onTap;
  const _NavButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      label: item.label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: selected
                ? AppColors.primary100.withValues(alpha: 0.6)
                : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selected ? item.activeIcon : item.icon,
                color: selected ? AppColors.primary600 : AppColors.natural500,
                size: 24,
              ),
              if (selected) ...[
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: const TextStyle(
                      color: AppColors.primary700,
                      fontSize: 13,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
