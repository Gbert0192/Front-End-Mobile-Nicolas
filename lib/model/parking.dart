import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/model/voucher.dart';

enum ParkingStatus { entered, exited, unresolved }

class Booking {
  final User user;
  bool? isMember;
  final ParkingLot lot;
  DateTime? checkinTime;
  DateTime? checkoutTime;
  DateTime? createdAt;
  final int floor;
  final String code;
  ParkingStatus status = ParkingStatus.entered;

  int? hours;
  double? amount;
  double? tax;
  double? service;
  double? voucher;
  double? total;
  double? unresolvedFee = 0;

  Booking({
    required this.user,
    required this.lot,
    required this.floor,
    required this.code,
  });

  void exitParking(Voucher voucher) {
    isMember = user.checkStatusMember();
    status = ParkingStatus.exited;
    hours = calculateHour();
    amount = lot.calculateAmount(hours!);
    tax = amount! * 0.11;
    service = isMember ? 0 : 6500;
    this.voucher = voucher.useVoucher(amount!, hours!);
    total = amount! + tax! + service! - this.voucher!;
  }

  ParkingStatus checkStatus() {
    if (status == ParkingStatus.entered && calculateHour() >= 20) {
      this.isMember = isMember;
      status = ParkingStatus.unresolved;
      checkoutTime = checkinTime!.add(Duration(hours: 20));
      unresolvedFee = 10000;
      hours = calculateHour();
      amount = lot.calculateAmount(20);
      tax = amount! * 0.11;
      service = isMember ? 0 : 6500;
      total = amount! + tax! + service!;
    }
    return status;
  }

  int calculateHour() {
    final duration = checkoutTime?.difference(checkinTime!);
    final hours = duration!.inMinutes / 60;

    return hours.ceil();
  }
}
