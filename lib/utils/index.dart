import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final langProvider = Provider.of<LanguageProvider>(context, listen: false);
  return langProvider.language == "EN"
      ? en
      : langProvider.language == "ID"
      ? id
      : cn;
}

String formatCurrency({
  required num nominal,
  int decimalPlace = 0,
  String symbol = "Rp.",
}) {
  final currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: symbol,
    decimalDigits: decimalPlace,
  );
  return currencyFormat.format(nominal);
}

String timeToString(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return "$hour:$minute";
}

TimeOfDay stringToTime(String hhmm) {
  final parts = hhmm.split(":");
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}
