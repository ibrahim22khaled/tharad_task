import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'locale_state.dart';

@injectable
class LocaleCubit extends Cubit<LocaleState> {
  final SharedPreferences _prefs;
  static const _key = 'selected_locale';

  LocaleCubit(this._prefs)
      : super(LocaleState(
          locale: Locale(_prefs.getString(_key) ?? 'ar'),
        ));

  Future<void> changeLocale(String languageCode) async {
    await _prefs.setString(_key, languageCode);
    emit(LocaleState(locale: Locale(languageCode)));
  }

  void toArabic() => changeLocale('ar');
  void toEnglish() => changeLocale('en');

  bool get isArabic => state.locale.languageCode == 'ar';
}