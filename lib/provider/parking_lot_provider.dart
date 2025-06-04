import 'package:flutter/foundation.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';
import 'package:tugas_front_end_nicolas/factory/lot_factory.dart';

class ParkingLotProvider with ChangeNotifier {
  List<ParkingLot> lots = lotFactory.lots;
  List<UserSearchHistory> searches = [];

  UserSearchHistory? loadHistory(int user_id) {
    return searches.firstWhereOrNull((item) => item.user_id == user_id);
  }

  List<ParkingLot>? searchLot(int user_id, String key) {
    final filterLots =
        lots
            .where(
              (item) => item.name.toLowerCase().contains(key.toLowerCase()),
            )
            .toList();

    final history = searches.firstWhereOrNull(
      (item) => item.user_id == user_id,
    );

    if (history == null) return null;

    history.searchHistory.remove(key.trim());

    history.searchHistory.insert(0, key.trim());
    notifyListeners();
    return filterLots;
  }

  void deleteHistory(int user_id, String key) {
    final history = searches.firstWhereOrNull(
      (item) => item.user_id == user_id,
    );

    if (history == null) return null;

    history.searchHistory.remove(key.trim());
    notifyListeners();
  }
}

class UserSearchHistory {
  final int user_id;
  final List<String> searchHistory;

  UserSearchHistory(this.user_id, this.searchHistory);
}
