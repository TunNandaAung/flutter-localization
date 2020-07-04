import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:localization/app_locale.dart';
import 'package:localization/app_localizations.dart';
import 'package:localization/preferences/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_event.dart';
part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, AppLocale> {
  LocaleBloc() : super(AppLocale.values[Prefer.localeIndexPref]);

  @override
  Stream<AppLocale> mapEventToState(
    LocaleEvent event,
  ) async* {
    if (event is LocaleChanged) {
      yield event.locale;
      print(event.locale.index);

      Prefer.prefs = await SharedPreferences.getInstance();
      Prefer.prefs.setInt('locale', event.locale.index);
      Prefer.localeIndexPref = event.locale.index;

      AppLocalizations.of(event.context).load(appLocaleData[event.locale]);
    }
  }
}
