import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Core/Handler/auth_handler.dart';
import '../../Helper/dependency_injection_helper.dart';
import '../../Routes/app_navigation.dart';
import '../../Routes/app_routes.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final BuildContext context;
  LanguageCubit({required this.context}) : super(LanguageInitial());

  static LanguageCubit get(BuildContext context) =>
      BlocProvider.of<LanguageCubit>(context);
  Locale currentLocale = Locale('ar');
  String? languageCode = DependencyInjectionHelper()
      .sl<AuthHandlerInterface>()
      .getLanguageCode();

  initialCubit() async {
    debugPrint('LanguageCubit initialCubit languageCode: $languageCode');
    if (languageCode != null) {
      currentLocale = Locale(languageCode!);
      emit(SetLanguageState(locale: currentLocale));
      await context.setLocale(Locale(languageCode!));
    } else {
      DependencyInjectionHelper().sl<AuthHandlerInterface>().setLanguageCode(
        'ar',
      );
      currentLocale = Locale('ar');
      emit(SetLanguageState(locale: currentLocale));
      await context.setLocale(Locale(currentLocale.languageCode));
    }
  }

  void changeLanguage({required Locale newLocale}) async {
    await context.setLocale(newLocale);
    currentLocale = newLocale;
    emit(SetLanguageState(locale: newLocale));
    await DependencyInjectionHelper()
        .sl<AuthHandlerInterface>()
        .setLanguageCode(newLocale.languageCode);
    AppNavigation.pushNamedAndRemoveUntil(AppRoutes.splash);
  }
}
