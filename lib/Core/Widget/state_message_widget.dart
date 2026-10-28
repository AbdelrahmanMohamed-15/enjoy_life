import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Constant/assets_strings.dart';
import '../Constant/base_constant.dart';
import '../L10n/locale_keys.dart';
import '../Themes/app_colors.dart';

/// Shown when a screen has no data, or when loading its data failed.
class StateMessageWidget extends StatelessWidget {
  final String message;
  final bool isError;
  final VoidCallback? onRetry;
  const StateMessageWidget({
    super.key,
    required this.message,
    this.isError = false,
    this.onRetry,
  });

  /// Empty data, e.g. no items in a list
  factory StateMessageWidget.empty({String? message, VoidCallback? onRetry}) {
    return StateMessageWidget(
      message: message ?? LocaleKeys.commonNoData.tr(),
      onRetry: onRetry,
    );
  }

  /// The request failed
  factory StateMessageWidget.error({String? message, VoidCallback? onRetry}) {
    return StateMessageWidget(
      message: message ?? LocaleKeys.commonErrorOccurred.tr(),
      isError: true,
      onRetry: onRetry,
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isError
                ? const Icon(
                    Icons.cloud_off_rounded,
                    size: 90,
                    color: AppColors.primary400,
                  )
                : SvgPicture.asset(AssetsStrings.empty, height: 180),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontFamily: BaseConstant.cairoBold,
                color: AppColors.primary400,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, color: AppColors.primary400),
                label: Text(
                  LocaleKeys.commonRetry.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary400,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
