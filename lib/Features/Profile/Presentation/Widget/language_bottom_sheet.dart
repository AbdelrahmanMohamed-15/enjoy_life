import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Core/main%20cubit/cubit/language_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        final languageCubit = DependencyInjectionHelper().sl<LanguageCubit>();
        final currentCode = state.locale.languageCode;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.natural300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  LocaleKeys.languageChoose.tr(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.black700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _LanguageOption(
                  title: LocaleKeys.languageArabic.tr(),
                  flag: '🇪🇬',
                  isSelected: currentCode == 'ar',
                  onTap: () {
                    Navigator.of(context).pop();
                    if (currentCode != 'ar') {
                      languageCubit.changeLanguage(
                        newLocale: const Locale('ar'),
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                _LanguageOption(
                  title: LocaleKeys.languageEnglish.tr(),
                  flag: '🇬🇧',
                  isSelected: currentCode == 'en',
                  onTap: () {
                    Navigator.of(context).pop();
                    if (currentCode != 'en') {
                      languageCubit.changeLanguage(
                        newLocale: const Locale('en'),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String title;
  final String flag;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.flag,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary100.withValues(alpha: 0.5)
              : AppColors.natural100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary400 : AppColors.natural200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.black700,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primary400),
          ],
        ),
      ),
    );
  }
}
