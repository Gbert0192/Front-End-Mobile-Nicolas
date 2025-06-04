import 'package:flutter/foundation.dart';
import 'package:tugas_front_end_nicolas/faker/voucher_faker.dart';
import 'package:tugas_front_end_nicolas/model/voucher.dart';

class VoucherProvider with ChangeNotifier {
  List<Voucher> vouchers = voucherFaker.vouchers;
}
