import 'package:flutter/material.dart';

enum AppLocale { en, my }

final appLocaleData = {
  AppLocale.en: const Locale('en', 'US'),
  AppLocale.my: const Locale('my', 'MY')
};
