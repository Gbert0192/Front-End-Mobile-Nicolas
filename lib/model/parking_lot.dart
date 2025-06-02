import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

enum SpotStatus { free, occupied, booked }

class Spot {
  SpotStatus status;
  User? user;
  final String code;
  DateTime? date;

  Spot({this.user, required this.status, required this.code, this.date});
}

class Area {
  final String name;
  final List<Spot> spots;

  Area({required this.name, required this.spots});

  Spot? getFirstAvailableSpot() {
    return spots.firstWhereOrNull((spot) => spot.status == SpotStatus.free);
  }

  Spot? findSpot(String code) {
    return spots.firstWhereOrNull((spot) => spot.code == code);
  }
}

class Floor {
  final String number;
  final List<Area> areas;

  Floor({required this.number, required this.areas});

  Spot? getFirstAvailableSpot() {
    for (final area in areas) {
      final spot = area.getFirstAvailableSpot();
      if (spot != null) return spot;
    }
    return null;
  }

  Spot? findSpot(String code) {
    for (final area in areas) {
      final spot = area.findSpot(code);
      if (spot != null) return spot;
    }
    return null;
  }
}

class ParkingLot {
  final int id;
  final String name;
  final String address;
  final String openTime;
  final String closeTime;
  final double? starterPrice;
  final double hourlyPrice;
  final String image;
  int spotCount;
  final int floor;
  final List<Floor> spots;

  ParkingLot({
    required this.id,
    required this.name,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.hourlyPrice,
    required this.image,
    required this.spotCount,
    required this.floor,
    required this.spots,
    this.starterPrice,
  });

  String? occupyNearestSpot() {
    final sortedFloors = [...spots]
      ..sort((a, b) => a.number.compareTo(b.number));
    for (final floor in sortedFloors) {
      final spot = floor.getFirstAvailableSpot();
      if (spot != null) {
        spot.status = SpotStatus.occupied;
        spot.date = DateTime.now();
        spotCount -= 1;
        return spot.code;
      }
    }
    return null;
  }

  String? occupySpot(int floorNumber, String spotCode) {
    final floor = spots.firstWhereOrNull((f) => f.number == floorNumber);
    final spot = floor?.findSpot(spotCode);
    if (spot != null && spot.status == SpotStatus.free) {
      spot.status = SpotStatus.occupied;
      spot.date = DateTime.now();
      spotCount -= 1;
      return spot.code;
    }
    return null;
  }

  bool freeSpot(int floorNumber, String spotCode) {
    final floor = spots.firstWhereOrNull((f) => f.number == floorNumber);
    final spot = floor?.findSpot(spotCode);
    if (spot != null && spot.status == SpotStatus.occupied) {
      spot.status = SpotStatus.free;
      spot.date = null;
      spotCount += 1;
      return true;
    }
    return false;
  }

  double calculateAmount(int hour) {
    return (starterPrice ?? hourlyPrice) + (hour - 1) * hourlyPrice;
  }

  double maxTotalEarning() {
    final open = _parseTime(openTime);
    final close = _parseTime(closeTime);

    Duration diff = close.difference(open);

    final hours = (diff.inMinutes / 60).ceil();

    return calculateAmount(hours);
  }

  DateTime _parseTime(String timeStr) {
    final parts = timeStr.split(':');
    final now = DateTime.now();
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}
