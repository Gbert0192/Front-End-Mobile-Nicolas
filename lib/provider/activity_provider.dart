import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';
import 'package:tugas_front_end_nicolas/utils/snackbar.dart';

enum ActivityType {
  bookSuccess,
  bookCancel,
  bookExp,
  unresolved,
  exitLot,
  enterLot,
  verify,
  // twoFactor,
  paySuccess,
  topUp,
}

class ActivityProvider with ChangeNotifier {
  List<UserActivity> activities = [];
  bool isLoading = false;

  ActivityProvider() {
    loadActivitiesFromPrefs();
  }

  Future<void> saveActivitiesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = activities.map((s) => jsonEncode(s.toJson())).toList();
    await prefs.setStringList('Activities', encoded);
  }

  Future<void> loadActivitiesFromPrefs() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getStringList('Activities');

    if (encoded != null) {
      activities =
          encoded.map((s) {
            final json = jsonDecode(s);
            return UserActivity.fromJson(json);
          }).toList();
    }
    isLoading = false;
    notifyListeners();
  }

  void addActivity(User user, ActivityItem activity) {
    final index = activities.indexWhere((v) => v.user == user);
    if (index != -1) {
      activities[index].activity.insert(0, activity);
    } else {
      activities.add(UserActivity(user, [activity]));
    }
    saveActivitiesToPrefs();
    notifyListeners();
  }

  UserActivity? getActivity(User user) {
    return activities.firstWhereOrNull((v) => v.user == user);
  }
}

class UserActivity {
  final User user;
  final List<ActivityItem> activity;

  UserActivity(this.user, this.activity);

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'activity': activity.map((e) => e.toJson()).toList(),
    };
  }

  factory UserActivity.fromJson(Map<String, dynamic> json) {
    final user = User.fromJson(json['user']);
    final activityList =
        (json['activity'] as List<dynamic>)
            .map((e) => ActivityItem.fromJson(e))
            .toList();

    return UserActivity(user, activityList);
  }
}

class ActivityItem {
  final ActivityType activityType;
  final String? mall;
  final String? method;
  final double? nominal;
  final DateTime date;

  ActivityItem({
    required this.activityType,
    this.mall,
    this.method,
    this.nominal,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  void onPressed(BuildContext context) {
    switch (activityType) {
      case ActivityType.topUp:
        showFlexibleSnackbar(
          context,
          "Top-up of ${formatCurrency(nominal: nominal!)} via $method",
        );
        break;

      case ActivityType.paySuccess:
        showFlexibleSnackbar(
          context,
          "Payment of ${formatCurrency(nominal: nominal!)} at $mall was successful",
        );
        break;

      case ActivityType.bookSuccess:
        showFlexibleSnackbar(context, "Successfully booked parking at $mall");
        break;

      case ActivityType.bookCancel:
        showFlexibleSnackbar(context, "Parking booking at $mall was canceled");
        break;

      case ActivityType.bookExp:
        showFlexibleSnackbar(context, "Parking booking at $mall has expired");
        break;

      case ActivityType.unresolved:
        showFlexibleSnackbar(
          context,
          "Unresolved parking session detected at $mall",
        );
        break;

      case ActivityType.exitLot:
        showFlexibleSnackbar(context, "Exited the parking lot at $mall");
        break;

      case ActivityType.enterLot:
        showFlexibleSnackbar(context, "Entered the parking lot at $mall");
        break;

      case ActivityType.verify:
        showFlexibleSnackbar(
          context,
          "Two-factor authentication has been set up",
        );
        break;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'activityTypes': activityTypeToString(activityType),
      'date': date.toIso8601String(),
    };

    if (mall != null) data['mall'] = mall;
    if (method != null) data['method'] = method;
    if (nominal != null) data['nominal'] = nominal;

    return data;
  }

  factory ActivityItem.fromJson(Map<String, dynamic> json) {
    return ActivityItem(
      activityType: activityTypeFromString(json['activityType']),
      mall: json['mall'],
      method: json['method'],
      nominal: (json['nominal'] as num?)?.toDouble(),
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }
}
