import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/model/voucher.dart';

enum BookingStatus { pending, fixed, expired, entered, exited, cancel }

class Booking {
  final int user_id;
  final bool isMember;
  final ParkingLot lot;
  final DateTime bookingTime;
  DateTime? checkinTime;
  DateTime? checkoutTime;
  DateTime? cancelTime;
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

  Booking({
    required this.user_id,
    required this.isMember,
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
    if ((status == BookingStatus.pending || status == BookingStatus.fixed) &&
        diffExpired > 30) {
      status = BookingStatus.expired;
      if (!isMember) {
        noshowFee = 10000;
      }
    } else {
      status = BookingStatus.entered;
    }
    return status;
  }

  void exiteParking(Voucher voucher) {
    if (status == BookingStatus.entered) {
      status = BookingStatus.exited;
      hours = calculateHour();
      amount = lot.calculateAmount(hours!);
      tax = amount! * 0.11;
      service = isMember ? 0 : 6000;
      this.voucher = voucher.useVoucher(amount! + tax! + service!, hours!);
      total = total! - this.voucher!;
    }
  }

  BookingStatus checkStatus() {
    final now = DateTime.now();
    final diffExpired = now.difference(bookingTime).inMinutes;
    final diffFixed = bookingTime.difference(now).inMinutes;
    if ((status == BookingStatus.pending || status == BookingStatus.fixed) &&
        diffExpired > 30) {
      status = BookingStatus.expired;
      if (!isMember) {
        noshowFee = 10000;
      }
    } else if (status == BookingStatus.pending &&
        diffFixed <= 30 &&
        diffFixed > 0) {
      status = BookingStatus.fixed;
    }
    return status;
  }

  BookingStatus cancelBooking() {
    final now = DateTime.now();
    final diff = bookingTime.difference(now).inMinutes;

    if (diff > 30 && status == BookingStatus.pending) {
      status = BookingStatus.cancel;
      cancelTime = now;
    } else {
      status = BookingStatus.fixed;
    }
    return status;
  }
}
