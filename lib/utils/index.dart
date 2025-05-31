import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/provider/language_provider.dart';

extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

String translate(BuildContext context, String en, String id, String cn) {
  final langProvider = Provider.of<LanguageProvider>(context);
  return langProvider.language == "EN"
      ? en
      : langProvider.language == "ID"
      ? id
      : cn;
}
