import 'dart:math';
import 'package:tugas_front_end_nicolas/model/voucher.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/faker/lot_faker.dart';

class VoucherFaker {
  List<Voucher> vouchers = [];

  final List<String> fallbackNames = [
    "Special Member Voucher",
    "Late Night Voucher",
    "Weekend Saver",
    "Holiday Discount",
    "First Time User",
    "Loyalty Bonus",
    "Rainy Day Promo",
    "Morning Deal",
    "Evening Offer",
    "Pay Less Voucher",
    "Eco-Friendly Parking",
    "Student Discount",
    "Business Hour Voucher",
    "Drive Safe Bonus",
    "Festival Promo",
  ];

  final Random _random = Random();

  VoucherFaker() {
    vouchers = generateVouchers();
  }

  List<Voucher> generateVouchers() {
    final List<ParkingLot> lots = lotFaker.lots;

    return List.generate(18, (index) {
      final randomLot = lots[_random.nextInt(lots.length)];
      final randomType =
          _random.nextBool() ? VoucherFlag.flat : VoucherFlag.percent;
      final validUntil = DateTime.now().add(
        Duration(days: _random.nextInt(30) + 1),
      );

      final nominal =
          randomType == VoucherFlag.flat
              ? generateFlatNominal().toDouble()
              : generatePercentNominal().toDouble();

      final name =
          _random.nextBool()
              ? generateVoucherName(randomType, nominal)
              : fallbackNames[_random.nextInt(fallbackNames.length)];

      return Voucher(
        lot: randomLot,
        voucherName: name,
        validUntil: validUntil,
        nominal: nominal,
        type: randomType,
        minHour: _random.nextBool() ? _random.nextInt(5) + 1 : null,
        maxUse: _random.nextBool() ? _random.nextInt(10) + 1 : null,
      );
    });
  }

  int generateFlatNominal() {
    final validNominals = <int>[];

    for (int i = 2500; i <= 10000; i += 500) {
      validNominals.add(i);
    }

    return validNominals[_random.nextInt(validNominals.length)];
  }

  int generatePercentNominal() {
    final percentOptions = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60];
    return percentOptions[_random.nextInt(percentOptions.length)];
  }

  String generateVoucherName(VoucherFlag type, double nominal) {
    if (type == VoucherFlag.flat && nominal == 0) {
      return "Free Parking Voucher";
    } else if (type == VoucherFlag.percent) {
      return "Discount ${nominal.toInt()}% Voucher";
    } else {
      return "Flat ${nominal.toInt()} Off";
    }
  }
}

final VoucherFaker voucherFaker = VoucherFaker();
