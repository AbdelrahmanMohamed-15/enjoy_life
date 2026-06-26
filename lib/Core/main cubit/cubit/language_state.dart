part of 'language_cubit.dart';

sealed class LanguageState extends Equatable {
  final Locale locale;

  const LanguageState({required this.locale});

  @override
  List<Object> get props => [locale];
}

final class LanguageLoaded extends LanguageState {
  const LanguageLoaded({required super.locale});
}
