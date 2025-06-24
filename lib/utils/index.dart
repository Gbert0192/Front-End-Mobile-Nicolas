import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/provider/language_provider.dart';
import 'package:encrypt/encrypt.dart' as enc;

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

DateTime stringToDate(String date, [TimeOfDay? time]) {
  final parts = date.split("/");
  final day = int.parse(parts[0]);
  final month = int.parse(parts[1]);
  final year = int.parse(parts[2]);
  return DateTime(year, month, day, time?.hour ?? 0, time?.minute ?? 0);
}

String formatDate(DateTime date) {
  return DateFormat('MMMM dd, yyyy', 'en_US').format(date);
}

String formatDateTime(DateTime date) {
  final datePart = DateFormat('dd MMMM yyyy, hh:mm', 'id_ID').format(date);
  return datePart;
}

final key = enc.Key.fromUtf8('CYNVBEITS3E2VJYFAZEWSDEPKSF2V2TB');
final iv = enc.IV.fromLength(16);

String encryptQR(String plainText) {
  final encrypter = enc.Encrypter(enc.AES(key));
  final encrypted = encrypter.encrypt(plainText, iv: iv);
  return encrypted.base64;
}

String decryptQR(String encryptedBase64) {
  final encrypter = enc.Encrypter(enc.AES(key));
  final decrypted = encrypter.decrypt64(encryptedBase64, iv: iv);
  return decrypted;
}

String formatFloorLabel(String floor) {
  if (floor.startsWith('G')) {
    return "$floor Floor";
  }

  final num = int.tryParse(floor);
  if (num == null) return "$floor Floor";

  String suffix;
  if (num >= 11 && num <= 13) {
    suffix = "th";
  } else {
    switch (num % 10) {
      case 1:
        suffix = "st";
        break;
      case 2:
        suffix = "nd";
        break;
      case 3:
        suffix = "rd";
        break;
      default:
        suffix = "th";
    }
  }

  return "$num$suffix Floor";
}
