import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simple_localization/simple_localization.dart';

class UsefulApiLocalization extends SimpleLocalizations {
  static UsefulApiLocalization of(BuildContext context) {
    UsefulApiLocalization localization = Localizations.of<UsefulApiLocalization>(context, UsefulApiLocalization);
    return localization ?? UsefulApiLocalization(Localizations.localeOf(context));
  }
  
  UsefulApiLocalization(Locale locale) : super(locale);

  @override
  Locale get defaultLocale => Locale('en');

  @override
  Iterable<Locale> get suportedLocales => [
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  @override
  Map<String, Map<dynamic, String>> get localizedValues => {
    'en': {
    },
    'es': {
    },
    'pt': {
    }
  };
}