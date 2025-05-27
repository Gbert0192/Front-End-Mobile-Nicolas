import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/model/voucher.dart';

class Booking {
  final int user_id;
  final bool isMember;
  final ParkingLot lot;
  DateTime? checkinTime;
  DateTime? checkoutTime;
  final int floor;
  final String code;

  int? hours;
  double? amount;
  double? tax;
  double? service;
  double? voucher;
  double? total;

  Booking({
    required this.user_id,
    required this.isMember,
    required this.lot,
    required this.floor,
    required this.code,
  });

  void exiteParking(Voucher voucher) {
    hours = calculateHour();
    amount = lot.calculateAmount(hours!);
    tax = amount! * 0.11;
    service = isMember ? 0 : 6000;
    this.voucher = voucher.useVoucher(amount! + tax! + service!, hours!);
    total = total! - this.voucher!;
  }

  int calculateHour() {
    final duration = checkoutTime?.difference(checkinTime!);
    final hours = duration!.inMinutes / 60;

    return hours.ceil();
  }
}
