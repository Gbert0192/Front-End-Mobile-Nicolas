import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/model/voucher.dart';

enum BookingStatus {
  pending,
  fixed,
  expired,
  entered,
  exited,
  cancel,
  unresolved,
}

class Booking {
  final User user;
  bool? isMember;
  final ParkingLot lot;
  final DateTime bookingTime;
  DateTime? checkinTime;
  DateTime? checkoutTime;
  DateTime? cancelTime;
  final DateTime createdAt = DateTime.now();
  final int floor;
  final String code;
  BookingStatus status;

  int? hours;
  double? amount;
  double? tax;
  double? service;
  double? voucher;
  double? total;
  double? noshowFee = 0;
  double? unresolvedFee = 0;

  Booking({
    required this.user,
    required this.lot,
    required this.bookingTime,
    required this.floor,
    required this.code,
    this.status = BookingStatus.pending,
  });

  int calculateHour() {
    final duration = checkoutTime?.difference(checkinTime!);
    final hours = duration!.inMinutes / 60;

    return hours.ceil();
  }

  BookingStatus claimBooking() {
    final now = DateTime.now();
    final diffExpired = now.difference(bookingTime).inMinutes;

    isMember = user.checkStatusMember();

    final expiredThreshold = isMember! ? 45 : 30;

    if ((status == BookingStatus.pending || status == BookingStatus.fixed) &&
        diffExpired > expiredThreshold) {
      status = BookingStatus.expired;

      if (!isMember!) {
        noshowFee = lot.maxTotalEarning() * 0.35;
      }
    } else {
      status = BookingStatus.entered;
    }

    return status;
  }

  void exitParking(Voucher voucher) {
    if (status == BookingStatus.entered) {
      status = BookingStatus.exited;
      hours = calculateHour();
      amount = lot.calculateAmount(hours!);
      tax = amount! * 0.11;
      service = user.checkStatusMember() ? 0 : 6500;
      this.voucher = voucher.useVoucher(amount!, hours!);
      total = amount! + tax! + service! - this.voucher!;
    }
  }

  BookingStatus checkStatus() {
    final now = DateTime.now();
    final diffExpired = now.difference(bookingTime).inMinutes;
    final diffFixed = bookingTime.difference(now).inMinutes;

    isMember = user.checkStatusMember();

    final expiredThreshold = isMember! ? 45 : 30;
    final fixedThreshold = isMember! ? 15 : 30;

    if ((status == BookingStatus.pending || status == BookingStatus.fixed) &&
        diffExpired > expiredThreshold) {
      status = BookingStatus.expired;

      if (!isMember!) {
        amount = lot.calculateAmount(hours!) * 0.35;
      }
    } else if (status == BookingStatus.pending &&
        diffFixed <= fixedThreshold &&
        diffFixed > 0) {
      status = BookingStatus.fixed;
    } else if (status == BookingStatus.entered && calculateHour() > 20) {
      status = BookingStatus.unresolved;
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
    if (status == BookingStatus.unresolved) {
      status = BookingStatus.exited;
      return total!;
    }
    return null;
  }

  BookingStatus cancelBooking() {
    final now = DateTime.now();
    final diff = bookingTime.difference(now).inMinutes;
    isMember = user.checkStatusMember();

    final isPending = status == BookingStatus.pending;

    if (isPending) {
      final canCancel = isMember! ? diff > 15 : diff > 30;

      if (canCancel) {
        status = BookingStatus.cancel;
        cancelTime = now;
      } else {
        status = BookingStatus.fixed;
      }
    }

    return status;
  }
}
