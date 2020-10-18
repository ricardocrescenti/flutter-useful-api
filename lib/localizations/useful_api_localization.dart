import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:useful_api/useful_api.dart';
import 'package:simple_localization/simple_localization.dart';

class SimpleAppLocalization extends SimpleLocalizations {
  static SimpleAppLocalization of(BuildContext context) {
    SimpleAppLocalization localization = Localizations.of<SimpleAppLocalization>(context, SimpleAppLocalization);
    return localization ?? SimpleAppLocalization(Localizations.localeOf(context));
  }
  
  SimpleAppLocalization(Locale locale) : super(locale);

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
      // standard_form
      StandardFormMessages.savingText: 'Saving'
    },
    'es': {
      // standard_form
      StandardFormMessages.savingText: 'Guardando'
    },
    'pt': {
      // standard_form
      StandardFormMessages.savingText: 'Salvando'
    }
  };
}