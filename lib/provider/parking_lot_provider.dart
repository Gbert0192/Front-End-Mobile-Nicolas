import 'package:flutter/foundation.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';
import 'package:tugas_front_end_nicolas/factory/lot_factory.dart';

class ParkingLotProvider with ChangeNotifier {
  List<ParkingLot> lots = lotFactory.lots;
  List<UserSearchHistory> searches = [];

  UserSearchHistory? loadHistory(User user) {
    return searches.firstWhereOrNull((item) => item.user == user);
  }

  List<ParkingLot>? searchLot(User user, String key) {
    final filterLots =
        lots
            .where(
              (item) => item.name.toLowerCase().contains(key.toLowerCase()),
            )
            .toList();

    var history = searches.firstWhereOrNull((item) => item.user == user);

    if (history == null) {
      history = UserSearchHistory(user, []);
      searches.add(history);
    }

    history.searchHistory.remove(key.trim());

    history.searchHistory.insert(0, key.trim());
    notifyListeners();
    return filterLots;
  }

  void deleteHistory(User user, String key) {
    final history = searches.firstWhereOrNull((item) => item.user == user);

    if (history == null) return null;

    history.searchHistory.remove(key.trim());
    notifyListeners();
  }

  List<Floor> getAvailableSpot(ParkingLot lot) {
    final index = lots.indexWhere((item) => item == lot);
    return lots[index].renderAllSlot();
  }
}

class UserSearchHistory {
  final User user;
  final List<String> searchHistory;

  UserSearchHistory(this.user, this.searchHistory);
}
