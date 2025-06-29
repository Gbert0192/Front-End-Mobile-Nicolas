import 'package:tugas_front_end_nicolas/model/history.dart';
import 'package:tugas_front_end_nicolas/model/parking.dart';

class Booking extends Parking {
  final DateTime bookingTime;
  DateTime? cancelTime;

  double? noshowFee = 0;

  Booking({
    required super.user,
    required super.lot,
    required super.floor,
    required super.code,
    required this.bookingTime,
    super.status = HistoryStatus.pending,
  });

  Booking claimBooking() {
    final now = DateTime.now();
    final diffExpired = now.difference(bookingTime).inMinutes;

    final isMember = user.checkStatusMember();
    final expiredThreshold = isMember ? 45 : 30;

    if ((status == HistoryStatus.pending || status == HistoryStatus.fixed) &&
        diffExpired > expiredThreshold) {
      status = HistoryStatus.expired;
      if (!isMember) {
        noshowFee = lot.maxTotalEarning() * 0.35;
      }
    } else {
      status = HistoryStatus.entered;
      checkinTime = DateTime.now();
    }

    return this;
  }

  @override
  HistoryStatus checkStatus() {
    final now = DateTime.now();
    final diffExpired = now.difference(bookingTime).inMinutes;
    final diffFixed = bookingTime.difference(now).inMinutes;

    isMember = user.checkStatusMember();
    final expiredThreshold = isMember! ? 45 : 30;
    final fixedThreshold = isMember! ? 15 : 30;

    if ((status == HistoryStatus.pending || status == HistoryStatus.fixed) &&
        diffExpired > expiredThreshold) {
      status = HistoryStatus.expired;
      if (!isMember!) {
        amount = lot.calculateAmount(hours ?? 1) * 0.35;
      }
    } else if (status == HistoryStatus.pending &&
        diffFixed <= fixedThreshold &&
        diffFixed > 0) {
      status = HistoryStatus.fixed;
    } else if (status == HistoryStatus.entered && calculateHour() >= 20) {
      super.checkStatus();
    }

    return status;
  }

  HistoryStatus cancelBooking() {
    final now = DateTime.now();
    final diff = bookingTime.difference(now).inMinutes;

    final isMember = user.checkStatusMember();
    final canCancel = isMember ? diff > 15 : diff > 30;

    if (status == HistoryStatus.pending && canCancel) {
      status = HistoryStatus.cancel;
      cancelTime = now;
    } else if (status == HistoryStatus.pending) {
      status = HistoryStatus.fixed;
    }

    return status;
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();

    data['bookingTime'] = bookingTime.toIso8601String();
    if (cancelTime != null) data['cancelTime'] = cancelTime!.toIso8601String();
    if (noshowFee != null && noshowFee != 0) {
      data['noshowFee'] = noshowFee;
    }

    return data;
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    final parking = Parking.fromJson(json);

    final booking = Booking(
      user: parking.user,
      lot: parking.lot,
      floor: parking.floor,
      code: parking.code,
      bookingTime: DateTime.parse(json['bookingTime']),
    );

    booking.checkinTime = parking.checkinTime;
    booking.createdAt = parking.createdAt;
    booking.checkoutTime = parking.checkoutTime;
    booking.status = parking.status;
    booking.hours = parking.hours;
    booking.amount = parking.amount;
    booking.tax = parking.tax;
    booking.service = parking.service;
    booking.voucher = parking.voucher;
    booking.total = parking.total;
    booking.unresolvedFee = parking.unresolvedFee;

    if (json['cancelTime'] != null) {
      booking.cancelTime = DateTime.parse(json['cancelTime']);
    }

    booking.noshowFee = (json['noshowFee'] as num?)?.toDouble() ?? 0;

    return booking;
  }
}
