import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/app_locale.dart';
import 'package:localization/app_localizations.dart';
import 'package:localization/preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<AppLocale> {
  LocaleCubit() : super(AppLocale.values[Prefer.localeIndexPref]);

  Future<void> changeLocale(
    AppLocale locale,
    BuildContext context,
  ) async {
    emit(locale);

    Prefer.prefs = await SharedPreferences.getInstance();
    Prefer.prefs!.setInt('locale', locale.index);
    Prefer.localeIndexPref = locale.index;

    AppLocalizations.delegate.load(appLocaleData[locale] as Locale);
  }
}
