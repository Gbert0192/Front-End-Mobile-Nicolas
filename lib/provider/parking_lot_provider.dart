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
    final keyword = key.trim().toLowerCase();

    final mallKeywords = [
      'mall',
      'malls',
      'mal',
      'shopping',
      'pusat perbelanjaan',
      'shopping center',
      'shopping centre',
      'shopping mall',
      'plaza',
    ];

    final hotelKeywords = [
      'hotel',
      'hotels',
      'penginapan',
      'akomodasi',
      'inap',
      'resort',
      'motel',
    ];

    final filterLots =
        lots.where((item) {
          final nameMatch = item.name.toLowerCase().contains(keyword);

          final buildingTypeMatch =
              (mallKeywords.contains(keyword) &&
                  item.buildingType == BuildingType.mall) ||
              (hotelKeywords.contains(keyword) &&
                  item.buildingType == BuildingType.hotel);

          return nameMatch || buildingTypeMatch;
        }).toList();

    var history = searches.firstWhereOrNull((item) => item.user == user);

    if (history == null) {
      history = UserSearchHistory(user, []);
      searches.add(history);
    }

    // Update search history
    history.searchHistory.remove(keyword);
    history.searchHistory.insert(0, keyword);

    notifyListeners();
    return filterLots;
  }

  void deleteHistory(User user, String key) {
    final history = searches.firstWhereOrNull((item) => item.user == user);

    if (history == null) return;

    history.searchHistory.remove(key.trim());
    notifyListeners();
  }

  List<Floor> getAvailableSpot(ParkingLot lot) {
    final index = lots.indexWhere((item) => item == lot);
    return lots[index].renderAllSlot();
  }

  String? occupyNearestSpot(ParkingLot lot, User user) {
    final index = lots.indexWhere((item) => item == lot);
    return lots[index].occupyNearestSpot(user);
  }

  String? bookSpot({
    required ParkingLot lot,
    required User user,
    required String floorNumber,
    required String spotCode,
  }) {
    final index = lots.indexWhere((item) => item == lot);
    return lots[index].bookSpot(floorNumber, spotCode, user);
  }

  String? claimSpot({
    required ParkingLot lot,
    required User user,
    required String floorNumber,
    required String spotCode,
  }) {
    final index = lots.indexWhere((item) => item == lot);
    return lots[index].claimSpot(floorNumber, spotCode, user);
  }

  bool freeSpot({
    required ParkingLot lot,
    required String floorNumber,
    required String spotCode,
  }) {
    final index = lots.indexWhere((item) => item == lot);
    return lots[index].freeSpot(floorNumber, spotCode);
  }
}

class UserSearchHistory {
  final User user;
  final List<String> searchHistory;

  UserSearchHistory(this.user, this.searchHistory);
}
