import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Handler/auth_handler.dart';
import '../../Helper/locale_storage.dart';
import '../../Routes/app_navigation.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit({
    required LocaleStorage localeStorage,
    required AuthHandlerInterface authHandler,
  }) : _localeStorage = localeStorage,
       _authHandler = authHandler,
       super(const LanguageLoaded(locale: LanguageCubit.defaultLocale));

  static const Locale defaultLocale = Locale('en');

  final LocaleStorage _localeStorage;
  final AuthHandlerInterface _authHandler;

  static LanguageCubit get(BuildContext context) =>
      BlocProvider.of<LanguageCubit>(context);

  Locale get currentLocale => state.locale;

  Future<void> initialize() async {
    String? savedCode = _localeStorage.getLanguageCode();

    if (savedCode == null) {
      savedCode = _authHandler.getLanguageCode();
      if (savedCode != null) {
        await _localeStorage.saveLanguageCode(savedCode);
      }
    }

    final locale = savedCode != null
        ? Locale(savedCode)
        : LanguageCubit.defaultLocale;

    if (savedCode == null) {
      await _localeStorage.saveLanguageCode(locale.languageCode);
    }

    emit(LanguageLoaded(locale: locale));
  }

  Future<void> changeLanguage({required Locale newLocale}) async {
    if (currentLocale == newLocale) return;

    await _localeStorage.saveLanguageCode(newLocale.languageCode);
    emit(LanguageLoaded(locale: newLocale));

    final context = AppNavigation.navigatorKey.currentContext;
    if (context != null && context.mounted) {
      await context.setLocale(newLocale);
    }
  }
}
