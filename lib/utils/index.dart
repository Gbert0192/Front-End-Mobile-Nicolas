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

Widget buildDetailRow({
  required String label,
  required String value,
  Color? valueColor,
  FontWeight? fontWeight,
  double? fontSize,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize ?? 15,
              color: Colors.grey,
              fontWeight: fontWeight,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: fontSize ?? 15,
              color: valueColor ?? Colors.black,
              fontWeight: fontWeight,
            ),
            textAlign: TextAlign.end,
            softWrap: true,
          ),
        ),
      ],
    ),
  );
}
