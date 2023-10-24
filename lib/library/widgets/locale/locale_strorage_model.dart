import 'package:flutter/material.dart';

class LocaleStorageModel {
  String _localeTag = '';
  String get localeTag => _localeTag;

  bool updateLocale(Locale locale) {
    final localeTag = locale.toLanguageTag();
    if (_localeTag == localeTag) return false;
    _localeTag = localeTag;
    return true;
  }
}
