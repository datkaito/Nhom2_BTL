import 'dart:collection';

import 'package:doan_clean_achitec/modules/lang/value/en_US.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'value/vi_VN.dart';

class TranslationService extends Translations {
  static Locale? get locale => fallbackLocale;
  static const fallbackLocale = Locale('vi', 'CN');

  static final langCodes = ['en', 'vi'];

  static final locales = [
    const Locale('en', 'US'),
    const Locale('vi', 'VN'),
  ];

  static final langs =
      LinkedHashMap.from({'en': 'English', 'vi': 'Tiếng Việt'});

  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
      };

  static Locale _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ?? Get.deviceLocale?.languageCode;
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return Get.locale!;
  }
}
