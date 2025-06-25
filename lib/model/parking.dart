import 'package:tugas_front_end_nicolas/model/history.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/model/voucher.dart';

class Parking {
  final User user;
  bool? isMember;
  final ParkingLot lot;
  DateTime? checkinTime;
  DateTime? checkoutTime;
  final DateTime createdAt = DateTime.now();
  final String floor;
  final String code;
  HistoryStatus status = HistoryStatus.entered;

  int? hours;
  double? amount;
  double? tax;
  double? service;
  double? voucher;
  double? total;
  double? unresolvedFee = 0;

  Parking({
    required this.user,
    required this.lot,
    required this.floor,
    required this.code,
  });

  void exitParking(Voucher voucher) {
    isMember = user.checkStatusMember();
    status = HistoryStatus.exited;
    hours = calculateHour();
    amount = lot.calculateAmount(hours!);
    tax = amount! * 0.11;
    service = isMember! ? 0 : 6500;
    this.voucher = voucher.useVoucher(amount!, hours!);
    total = amount! + tax! + service! - this.voucher!;
  }

  HistoryStatus checkStatus() {
    if (status == HistoryStatus.entered && calculateHour() > 20) {
      isMember = user.checkStatusMember();
      status = HistoryStatus.unresolved;
      checkoutTime = checkinTime!.add(Duration(hours: 20));
      unresolvedFee = 10000;
      amount = lot.calculateAmount(20);
      tax = amount! * 0.11;
      service = isMember! ? 0 : 6500;
      total = amount! + tax! + service!;
    }
    return status;
  }

  double? resolveUnresolve() {
    if (status == HistoryStatus.unresolved) {
      status = HistoryStatus.exited;
      return total!;
    }
    return null;
  }

  int calculateHour() {
    final duration = checkoutTime?.difference(checkinTime!);
    final hours = duration!.inMinutes / 60;

    return hours.ceil();
  }
}
