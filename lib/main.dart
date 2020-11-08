import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/app_locale.dart';
import 'package:localization/cubit/locale_cubit.dart';
import 'package:localization/locale_bloc/bloc.dart';
import 'package:localization/preferences/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Prefer.prefs = await SharedPreferences.getInstance();
  Prefer.localeIndexPref = Prefer.prefs.getInt('locale') ?? 0;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocaleCubit(),
      child: _buildWithLocale(context),
    );
  }

  Widget _buildWithLocale(BuildContext context) {
    return BlocBuilder<LocaleCubit, AppLocale>(builder: (context, appLocale) {
      return MaterialApp(
        title: 'Flutter Localizations',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // List all of the app's supported locales here
        supportedLocales: [
          Locale('en', 'US'),
          Locale('my', 'MY'),
        ],
        // These delegates make sure that the localization data for the proper language is loaded
        localizationsDelegates: [
          // A class which loads the translations from JSON files
          AppLocalizations.delegate,
          // Built-in localization of basic text for Material widgets
          GlobalMaterialLocalizations.delegate,
          // Built-in localization for text direction LTR/RTL
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: appLocaleData[appLocale],
        // Returns a locale which will be used by the app
        // localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        // for (var supportedLocale in supportedLocales) {
        //   if (supportedLocale.languageCode == locale.languageCode &&
        //       supportedLocale.countryCode == locale.countryCode) {
        //     return supportedLocale;
        //   }
        // }
        // // If the locale of the device is not supported, use the first one
        // // from the list (English, in this case).
        // return supportedLocales.first;

        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        //return appLocaleData[appLocale];
        // },
        home: MyHomePage(),
      );
    });
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      BlocProvider.of<LocaleBloc>(context)
                          .add(LocaleChanged(AppLocale.MY, context));
                    },
                    color: Colors.black.withOpacity(.80),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text('Myanmar',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  FlatButton(
                    onPressed: () {
                      BlocProvider.of<LocaleBloc>(context)
                          .add(LocaleChanged(AppLocale.EN, context));
                    },
                    color: Colors.black.withOpacity(.80),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text('English',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.white)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                AppLocalizations.of(context).translate('first_string'),
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              // Text(
              //   AppLocalizations.of(context).translate('second_string'),
              //   style: TextStyle(fontSize: 25),
              //   textAlign: TextAlign.center,
              // ),
              SizedBox(height: 10),
              Text(
                'This will not be translated.',
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
