import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../app_locale.dart';

abstract class LocaleEvent extends Equatable {
  const LocaleEvent();
}

class AppStarted extends LocaleEvent {
  final BuildContext context;

  AppStarted(this.context);

  @override
  List<Object> get props => [context];
}

class LocaleChanged extends LocaleEvent {
  final AppLocale locale;
  final BuildContext context;

  const LocaleChanged(this.locale, this.context);

  @override
  List<Object> get props => [locale, context];
}
