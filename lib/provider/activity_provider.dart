import 'package:flutter/foundation.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';

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
      activities[index].activity.add(activity);
    } else {
      activities.add(UserActivity(user, [activity]));
    }
  }

  List<UserActivity> getActivity(User user) {
    return activities.where((activity) => activity.user == user).toList();
  }
}

class UserActivity {
  final User user;
  final List<ActivityItem> activity;

  UserActivity(this.user, this.activity);
}

class ActivityItem {
  final ActivityTypes typeText;
  final String? mall;
  final String? method;
  final double? nominal;
  final DateTime date = DateTime.now();

  ActivityItem({required this.typeText, this.mall, this.method, this.nominal});
}
