import 'package:flutter/foundation.dart';
import 'package:tugas_front_end_nicolas/model/booking.dart';
import 'package:tugas_front_end_nicolas/model/history.dart';
import 'package:tugas_front_end_nicolas/model/parking.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class HistoryProvider with ChangeNotifier {
  final List<History> histories = [];

  void addParking(User user, ParkingLot lot, String floor, String spot) {
    final index = histories.indexWhere((v) => v.user == user);
    final parking = Parking(user: user, lot: lot, floor: floor, code: spot);
    if (index != -1) {
      histories[index].parkings.insert(0, parking);
    } else {
      histories.add(History(user, [parking], []));
    }
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
  }

  List<Parking>? getParking(User user) {
    return histories.firstWhereOrNull((item) => item.user == user)?.parkings;
  }

  List<Parking>? getBooking(User user) {
    return histories.firstWhereOrNull((item) => item.user == user)?.bookings;
  }

  List<ParkingLot>? getFrequentLots(User user) {
    return histories
        .firstWhereOrNull((item) => item.user == user)
        ?.getFrequentLots()
        .take(5)
        .toList();
  }

  void chackAllStatus(User user) {
    histories.firstWhereOrNull((item) => item.user == user)?.checkAllStatus();
    notifyListeners();
  }
}
