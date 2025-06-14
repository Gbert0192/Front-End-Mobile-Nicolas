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
  }) {
    status = HistoryStatus.pending;
  }

  HistoryStatus claimBooking() {
    final now = DateTime.now();
    final diffExpired = now.difference(bookingTime).inMinutes;

    isMember = user.checkStatusMember();
    final expiredThreshold = isMember! ? 45 : 30;

    if ((status == HistoryStatus.pending || status == HistoryStatus.fixed) &&
        diffExpired > expiredThreshold) {
      status = HistoryStatus.expired;
      if (!isMember!) {
        noshowFee = lot.maxTotalEarning() * 0.35;
      }
    } else {
      status = HistoryStatus.entered;
      checkinTime = DateTime.now();
    }

    return status;
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
    } else if (status == HistoryStatus.entered && calculateHour() > 20) {
      super.checkStatus();
    }

    return status;
  }

  HistoryStatus cancelBooking() {
    final now = DateTime.now();
    final diff = bookingTime.difference(now).inMinutes;

    isMember = user.checkStatusMember();
    final canCancel = isMember! ? diff > 15 : diff > 30;

    if (status == HistoryStatus.pending && canCancel) {
      status = HistoryStatus.cancel;
      cancelTime = now;
    } else if (status == HistoryStatus.pending) {
      status = HistoryStatus.fixed;
    }

    return status;
  }
}
