import 'package:tugas_front_end_nicolas/model/history.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/model/voucher.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class Parking {
  final User user;
  final ParkingLot lot;
  bool? isMember;
  DateTime? checkinTime;
  DateTime? checkoutTime;
  DateTime createdAt = DateTime.now();
  final String floor;
  final String code;
  HistoryStatus status;

  int? hours;
  double? amount;
  double? tax;
  double? service;
  double? voucher;
  double? total;
  double? unresolvedFee = 0;

  Parking({
    required this.user,
    required this.lot,
    required this.floor,
    required this.code,
    this.status = HistoryStatus.entered,
  });

  Parking exitParking(Voucher? voucher) {
    isMember = user.checkStatusMember();
    status = HistoryStatus.exited;
    hours = calculateHour();
    amount = lot.calculateAmount(hours!);
    tax = amount! * 0.11;
    service = isMember! ? 0 : 6500;

    if (voucher != null) {
      this.voucher = voucher.useVoucher(amount!, hours!);
    } else {
      this.voucher = 0;
    }

    total = amount! + tax! + service! - this.voucher!;
    checkoutTime = DateTime.now();
    return this;
  }

  HistoryStatus checkStatus() {
    if (status == HistoryStatus.entered && calculateHour() >= 20) {
      isMember = user.checkStatusMember();
      status = HistoryStatus.unresolved;
      checkoutTime = checkinTime!.add(Duration(hours: 20));
      unresolvedFee = 10000;
      amount = lot.calculateAmount(20);
      tax = amount! * 0.11;
      service = isMember! ? 0 : 6500;
      total = amount! + tax! + service!;
    }
    return status;
  }

  Parking? resolveUnresolve() {
    if (status == HistoryStatus.unresolved) {
      status = HistoryStatus.exited;
      return this;
    }
    return null;
  }

  int calculateHour() {
    final duration = DateTime.now().difference(checkinTime!);
    final hours = duration.inMinutes / 60;

    return hours.ceil();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'user': user.toJson(),
      'lot': lot.toJson(),
      'floor': floor,
      'code': code,
      'createdAt': createdAt.toIso8601String(),
      'status': historyStatusToString(status),
    };

    if (checkinTime != null) {
      data['checkinTime'] = checkinTime!.toIso8601String();
    }
    if (checkoutTime != null) {
      data['checkoutTime'] = checkoutTime!.toIso8601String();
    }
    if (hours != null) data['hours'] = hours;
    if (amount != null) data['amount'] = amount;
    if (tax != null) data['tax'] = tax;
    if (service != null) data['service'] = service;
    if (voucher != null) data['voucher'] = voucher;
    if (total != null) data['total'] = total;
    if (unresolvedFee != null && unresolvedFee != 0) {
      data['unresolvedFee'] = unresolvedFee;
    }

    return data;
  }

  factory Parking.fromJson(Map<String, dynamic> json) {
    final parking = Parking(
      user: User.fromJson(json['user']),
      lot: ParkingLot.fromJson(json['lot']),
      floor: json['floor'],
      code: json['code'],
    );

    parking.createdAt = DateTime.parse(json['createdAt']);
    parking.checkinTime =
        json['checkinTime'] != null
            ? DateTime.parse(json['checkinTime'])
            : null;
    parking.checkoutTime =
        json['checkoutTime'] != null
            ? DateTime.parse(json['checkoutTime'])
            : null;
    parking.status = historyStatusFromString(json['status']);
    parking.hours = json['hours'];
    parking.amount = (json['amount'] as num?)?.toDouble();
    parking.tax = (json['tax'] as num?)?.toDouble();
    parking.service = (json['service'] as num?)?.toDouble();
    parking.voucher = (json['voucher'] as num?)?.toDouble();
    parking.total = (json['total'] as num?)?.toDouble();
    parking.unresolvedFee = (json['unresolvedFee'] as num?)?.toDouble() ?? 0;

    return parking;
  }
}
