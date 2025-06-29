import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_front_end_nicolas/model/booking.dart';
import 'package:tugas_front_end_nicolas/model/history.dart';
import 'package:tugas_front_end_nicolas/model/parking.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/model/voucher.dart';
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

  Parking addParking({
    required User user,
    required ParkingLot lot,
    required String floor,
    required String code,
  }) {
    final index = histories.indexWhere((v) => v.user == user);
    final parking = Parking(user: user, lot: lot, floor: floor, code: code);
    parking.checkinTime = DateTime.now();
    if (index != -1) {
      histories[index].addParking(parking);
      saveHistoriesToPrefs();
      notifyListeners();
      return histories[index].parkings[0];
    } else {
      histories.add(History(user, [parking], []));
      saveHistoriesToPrefs();
      notifyListeners();
      return histories.last.parkings[0];
    }
  }

  Booking addBooking({
    required User user,
    required ParkingLot lot,
    required String floor,
    required String spot,
    required DateTime time,
  }) {
    final index = histories.indexWhere((v) => v.user == user);
    final booking = Booking(
      user: user,
      lot: lot,
      floor: floor,
      code: spot,
      bookingTime: time,
    );
    if (index != -1) {
      histories[index].addBooking(booking);
      saveHistoriesToPrefs();
      notifyListeners();
      return histories[index].bookings[0];
    } else {
      histories.add(History(user, [], [booking]));
      saveHistoriesToPrefs();
      notifyListeners();
      return histories.last.bookings[0];
    }
  }

  List<Parking>? getParking(User user) {
    checkAllStatus(user);
    return histories.firstWhereOrNull((item) => item.user == user)?.parkings;
  }

  List<Parking>? getBooking(User user) {
    checkAllStatus(user);
    return histories.firstWhereOrNull((item) => item.user == user)?.bookings;
  }

  List<ParkingLot>? getFrequentLots(User user) {
    checkAllStatus(user);

    final frequent =
        histories
            .firstWhereOrNull((item) => item.user == user)
            ?.getFrequentLots();

    if (frequent == null || frequent.isEmpty) {
      return null;
    }

    return frequent.take(5).toList();
  }

  void checkAllStatus(User user) {
    histories.firstWhereOrNull((item) => item.user == user)?.checkAllStatus();
    saveHistoriesToPrefs();
    notifyListeners();
  }

  HistoryStatus? checkStatus(User user, Parking history) {
    final userHistory = histories.firstWhereOrNull((item) => item.user == user);
    if (userHistory == null) return null;

    HistoryStatus? status;

    status =
        userHistory.bookings
            .firstWhereOrNull((item) => item == history)
            ?.checkStatus();

    status ??=
        userHistory.parkings
            .firstWhereOrNull((item) => item == history)
            ?.checkStatus();

    saveHistoriesToPrefs();
    notifyListeners();

    return status;
  }

  Booking? claimBooking(User user, Booking history) {
    final userHistory = histories.firstWhereOrNull((item) => item.user == user);
    if (userHistory == null) return null;

    final booking =
        userHistory.bookings
            .firstWhereOrNull((item) => item == history)
            ?.claimBooking();

    saveHistoriesToPrefs();
    notifyListeners();
    return booking;
  }

  Parking? exitParking(User user, Parking history, Voucher? voucher) {
    final userHistory = histories.firstWhereOrNull((item) => item.user == user);
    if (userHistory == null) return null;

    Parking? booking;

    booking = userHistory.bookings
        .firstWhereOrNull((item) => item == history)
        ?.exitParking(voucher);

    booking ??= userHistory.parkings
        .firstWhereOrNull((item) => item == history)
        ?.exitParking(voucher);

    saveHistoriesToPrefs();
    notifyListeners();

    return booking;
  }

  Parking? resolveUnresolve(User user, Parking history) {
    final userHistory = histories.firstWhereOrNull((item) => item.user == user);
    if (userHistory == null) return null;

    Parking? booking;

    booking =
        userHistory.bookings
            .firstWhereOrNull((item) => item == history)
            ?.resolveUnresolve();

    booking ??=
        userHistory.parkings
            .firstWhereOrNull((item) => item == history)
            ?.resolveUnresolve();

    saveHistoriesToPrefs();
    notifyListeners();

    return booking;
  }
}
