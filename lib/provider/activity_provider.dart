import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

enum ActivityTypes {
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
  final List<UserActivity> activities = [];

  void addActivity(User user, ActivityItem activity) {
    final index = activities.indexWhere((v) => v.user == user);
    if (index != -1) {
      activities[index].activity.insert(0, activity);
    } else {
      activities.add(UserActivity(user, [activity]));
    }
  }

  UserActivity? getActivity(User user) {
    return activities.firstWhereOrNull((v) => v.user == user);
  }
}

class UserActivity {
  final User user;
  final List<ActivityItem> activity;

  UserActivity(this.user, this.activity);
}

class ActivityItem {
  final ActivityTypes activityTypes;
  final String? mall;
  final String? method;
  final double? nominal;
  final VoidCallback? onPressed;
  final DateTime date;

  ActivityItem({
    required this.activityTypes,
    this.mall,
    this.method,
    this.nominal,
    this.onPressed,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  get length => null;
}
