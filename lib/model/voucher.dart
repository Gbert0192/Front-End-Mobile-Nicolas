import 'package:tugas_front_end_nicolas/model/parking_lot.dart';

enum VoucherFlag { flat, percent, free }

class Voucher {
  final ParkingLot lot;
  final int? minHour;
  final String voucherName;
  final DateTime validUntil;
  final double? nominal;
  final VoucherFlag type;
  int? maxUse;

  Voucher({
    required this.lot,
    this.minHour,
    required this.voucherName,
    required this.validUntil,
    required this.nominal,
    this.type = VoucherFlag.flat,
    this.maxUse,
  });

  double useVoucher(double total, int hours) {
    if (DateTime.now().isAfter(validUntil)) {
      return 0;
    }

    if (minHour != null && hours < minHour!) {
      return 0;
    }

    if (maxUse != null && maxUse! <= 0) {
      return 0;
    }

    double discount = 0;
    switch (type) {
      case VoucherFlag.flat:
        discount = nominal ?? 0;
        break;
      case VoucherFlag.percent:
        discount = total * ((nominal ?? 0) / 100);
        break;
      case VoucherFlag.free:
        discount = total;
        break;
    }

    discount = discount > total ? total : discount;

    if (maxUse != null) {
      maxUse = maxUse! - 1;
    }

    return discount;
  }
}
