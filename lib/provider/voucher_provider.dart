import 'package:flutter/foundation.dart';
import 'package:tugas_front_end_nicolas/factory/voucher_factory.dart';
import 'package:tugas_front_end_nicolas/model/voucher.dart';

class VoucherProvider with ChangeNotifier {
  List<Voucher> vouchers = voucherFactory.vouchers;

  List<Voucher> getAvailableVoucher() {
    final now = DateTime.now();

    // Filter vouchers where validUntil is in the future (or today)
    return vouchers
        .where(
          (voucher) =>
              voucher.validUntil.isAfter(now) ||
              voucher.validUntil.isAtSameMomentAs(now),
        )
        .toList();
  }
}

class UserVoucher {
  final int user_id;
  final List<VoucherRemain> voucherhistory;
  UserVoucher(this.user_id, this.voucherhistory);

  void useVoucher(int voucher_id, int remain) {
    voucherhistory.add(VoucherRemain(voucher_id, remain));
  }
}

class VoucherRemain {
  final int voucher_id;
  int remain;
  VoucherRemain(this.voucher_id, this.remain);
}
