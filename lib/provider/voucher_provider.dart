import 'package:flutter/foundation.dart';
import 'package:tugas_front_end_nicolas/factory/voucher_factory.dart';
import 'package:tugas_front_end_nicolas/model/voucher.dart';

class VoucherProvider with ChangeNotifier {
  List<Voucher> vouchers = voucherFactory.vouchers;
}
