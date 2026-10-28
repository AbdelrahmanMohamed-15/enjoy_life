import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Constant/base_constant.dart';
import '../../cubit/vendor_service_cubit.dart';

/// Arabic / English switch for the bilingual fields. Each side shows a check
/// once its fields are filled, so it is clear which language is missing.
class LanguageWidget extends StatelessWidget {
  /// Also require the description for a language to count as complete
  final bool withDescription;
  const LanguageWidget({super.key, this.withDescription = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var cubit = VendorServiceCubit.get(context);
        return ListenableBuilder(
          listenable: Listenable.merge([
            cubit.nameArController,
            cubit.nameEnController,
            cubit.descriptionArController,
            cubit.descriptionEnController,
          ]),
          builder: (context, _) {
            final arDone =
                cubit.nameArController.text.trim().isNotEmpty &&
                (!withDescription ||
                    cubit.descriptionArController.text.trim().isNotEmpty);
            final enDone =
                cubit.nameEnController.text.trim().isNotEmpty &&
                (!withDescription ||
                    cubit.descriptionEnController.text.trim().isNotEmpty);
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.natural200.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        _LanguageTab(
                          label: LocaleKeys.languageArabic.tr(),
                          isSelected: cubit.language == 'ar',
                          isDone: arDone,
                          onTap: () => cubit.setLanguage(lang: 'ar'),
                        ),
                        _LanguageTab(
                          label: LocaleKeys.languageEnglish.tr(),
                          isSelected: cubit.language == 'en',
                          isDone: enDone,
                          onTap: () => cubit.setLanguage(lang: 'en'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        size: 14,
                        color: AppColors.natural500,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          LocaleKeys.vendorLanguageHint.tr(),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.natural500,
                                fontSize: 11,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _LanguageTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isDone;
  final VoidCallback onTap;
  const _LanguageTab({
    required this.label,
    required this.isSelected,
    required this.isDone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.white : AppColors.natural600;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: isSelected
                ? const LinearGradient(
                    colors: [AppColors.primary400, AppColors.primary600],
                  )
                : null,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary500.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: BaseConstant.cairoBold,
                  color: color,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                isDone
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                size: 16,
                color: isDone
                    ? (isSelected ? Colors.white : const Color(0xFF2EAD5B))
                    : color.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
