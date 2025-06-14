import 'package:tugas_front_end_nicolas/model/booking.dart';
import 'package:tugas_front_end_nicolas/model/parking.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';

enum HistoryStatus {
  pending,
  fixed,
  expired,
  entered,
  exited,
  cancel,
  unresolved,
}

class History {
  final User user;
  final List<Parking> parkings;
  final List<Booking> bookings;

  History(this.user, this.parkings, this.bookings);

  void checkAllStatus() {
    for (var item in parkings) {
      item.checkStatus();
    }
    for (var item in bookings) {
      item.checkStatus();
    }
  }

  void addParking(Parking parking) {
    parkings.add(parking);
  }

  void addBooking(Booking booking) {
    bookings.add(booking);
  }

  List<ParkingLot> getFrequentLots() {
    final Map<ParkingLot, int> counts = {};

    for (final p in parkings) {
      counts[p.lot] = (counts[p.lot] ?? 0) + 1;
    }

    for (final b in bookings) {
      counts[b.lot] = (counts[b.lot] ?? 0) + 1;
    }

    final entries =
        counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return entries.map((e) => e.key).toList();
  }
}
