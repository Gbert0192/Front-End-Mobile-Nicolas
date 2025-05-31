import 'package:flutter/foundation.dart';

class LanguageProvider with ChangeNotifier {
  final List<Language> languages = [
    Language('Bahasa Indonesia', 'ID'),
    Language('English', 'EN'),
    Language('中文', 'CN'),
  ];

  String language = "EN";

  void switchLanguage(String lang) {
    language = lang;
    notifyListeners();
  }
}

class Language {
  Language(this.label, this.value);
  final String label;
  final String value;
}
