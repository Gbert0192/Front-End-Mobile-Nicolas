import 'package:flutter/foundation.dart';
import 'package:tugas_front_end_nicolas/factory/voucher_factory.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/model/voucher.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class VoucherProvider with ChangeNotifier {
  List<Voucher> vouchers = voucherFactory.vouchers;
  List<UserVoucher> vouchersHistories = [];

  List<Voucher> getAvailableVoucher() {
    final now = DateTime.now();

    return vouchers
        .where(
          (voucher) =>
              voucher.validUntil.isAfter(now) ||
              voucher.validUntil.isAtSameMomentAs(now),
        )
        .toList();
  }

  List<VoucherRemain> getAvailableRemain(ParkingLot lot, int hour, User user) {
    final allAvailable =
        getAvailableVoucher().where((voucher) {
          return voucher.lot == lot && voucher.minHour! <= hour;
        }).toList();

    final userHistory = vouchersHistories.firstWhereOrNull(
      (history) => history.user == user,
    );

    return allAvailable.map((voucher) {
      final remainEntry = userHistory?.userVoucherhistory.firstWhereOrNull(
        (v) => v.voucher == voucher,
      );

      final remain =
          voucher.maxUse != null ? (remainEntry?.remain ?? voucher.maxUse!) : 1;

      return VoucherRemain(voucher, remain);
    }).toList();
  }

  void useVoucher(Voucher voucher, User user) {
    final index = vouchersHistories.indexWhere((v) => v.user == user);
    vouchersHistories[index].useVoucher(voucher);
  }
}

class UserVoucher {
  final User user;
  final List<VoucherRemain> userVoucherhistory;
  UserVoucher(this.user, this.userVoucherhistory);

  void useVoucher(Voucher voucher) {
    final index = userVoucherhistory.indexWhere((v) => v.voucher == voucher);
    if (voucher.maxUse != null) {
      if (index != -1) {
        userVoucherhistory[index].remain = voucher.maxUse! - 1;
      } else {
        userVoucherhistory.add(VoucherRemain(voucher, voucher.maxUse! - 1));
      }
    }
  }
}

class VoucherRemain {
  final Voucher voucher;
  int remain;
  VoucherRemain(this.voucher, this.remain);
}
