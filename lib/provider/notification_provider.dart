import 'package:flutter/foundation.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';

enum NotifTypes {
  bookSuccess,
  bookCancel,
  bookExp,
  bookExit,
  verify,
  twoFactor,
  paySuccess,
  topUp,
}

class NotificationProvider with ChangeNotifier {}

class UserNotification {
  final User user;
  final List<NotificationItem> notification;

  UserNotification(this.user, this.notification);
}

class NotificationItem {
  final NotifTypes typeText;
  final String? mall;
  final String? method;
  final double? nominal;
  final DateTime date;

  NotificationItem({
    required this.typeText,
    this.mall,
    this.method,
    this.nominal,
    required this.date,
  });
}
