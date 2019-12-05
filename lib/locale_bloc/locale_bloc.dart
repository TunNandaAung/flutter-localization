import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:localization/app_locale.dart';
import 'package:localization/app_localizations.dart';
import './bloc.dart';

class LocaleBloc extends Bloc<LocaleEvent, AppLocale> {
  @override
  AppLocale get initialState =>
      // Everything is accessible from the appLocaleData Map.
      AppLocale.EN;

  @override
  Stream<AppLocale> mapEventToState(
    LocaleEvent event,
  ) async* {
    if (event is LocaleChanged) {
      yield event.locale;
      print(event.locale.index);
      AppLocalizations.of(event.context).load(appLocaleData[event.locale]);
    }
  }
}
