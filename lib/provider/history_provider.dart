import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_front_end_nicolas/model/booking.dart';
import 'package:tugas_front_end_nicolas/model/history.dart';
import 'package:tugas_front_end_nicolas/model/parking.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class HistoryProvider with ChangeNotifier {
  List<History> histories = [];
  bool isLoading = false;

  HistoryProvider() {
    loadHistoriesFromPrefs();
  }

  Future<void> saveHistoriesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = histories.map((s) => jsonEncode(s.toJson())).toList();
    await prefs.setStringList('histories', encoded);
  }

  Future<void> loadHistoriesFromPrefs() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getStringList('histories');

    if (encoded != null) {
      histories =
          encoded.map((s) {
            final json = jsonDecode(s);
            return History.fromJson(json);
          }).toList();
    }
    isLoading = false;
    notifyListeners();
  }

  void addParking(User user, ParkingLot lot, String floor, String spot) {
    final index = histories.indexWhere((v) => v.user == user);
    final parking = Parking(user: user, lot: lot, floor: floor, code: spot);
    if (index != -1) {
      histories[index].parkings.insert(0, parking);
    } else {
      histories.add(History(user, [parking], []));
    }
    saveHistoriesToPrefs();
    notifyListeners();
  }

  void addBooking(
    User user,
    ParkingLot lot,
    String floor,
    String spot,
    DateTime time,
  ) {
    final index = histories.indexWhere((v) => v.user == user);
    final booking = Booking(
      user: user,
      lot: lot,
      floor: floor,
      code: spot,
      bookingTime: time,
    );
    if (index != -1) {
      histories[index].bookings.insert(0, booking);
    } else {
      histories.add(History(user, [], [booking]));
    }
    saveHistoriesToPrefs();
    notifyListeners();
  }

  List<Parking>? getParking(User user) {
    chackAllStatus(user);
    return histories.firstWhereOrNull((item) => item.user == user)?.parkings;
  }

  List<Parking>? getBooking(User user) {
    chackAllStatus(user);
    return histories.firstWhereOrNull((item) => item.user == user)?.bookings;
  }

  List<ParkingLot>? getFrequentLots(User user) {
    chackAllStatus(user);
    final frequent =
        histories
            .firstWhereOrNull((item) => item.user == user)
            ?.getFrequentLots();
    return (frequent ?? []).isNotEmpty ? frequent!.take(5).toList() : null;
  }

  void chackAllStatus(User user) {
    histories.firstWhereOrNull((item) => item.user == user)?.checkAllStatus();
    saveHistoriesToPrefs();
    notifyListeners();
  }
}
