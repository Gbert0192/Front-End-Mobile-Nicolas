import 'package:tugas_front_end_nicolas/utils/index.dart';

enum SpotStatus { free, occupied, booked }

class Spot {
  SpotStatus status;
  final String code;

  Spot({required this.status, required this.code});
}

class Floor {
  final int number;
  final int totalSpots;
  final List<Spot> spots;

  Floor({required this.number, required this.totalSpots, required this.spots});

  Spot? getFirstAvailableSpot() {
    return spots.firstWhereOrNull((spot) => spot.status == SpotStatus.free);
  }

  Spot? findSpot(String code) {
    return spots.firstWhereOrNull((spot) => spot.code == code);
  }
}

class ParkingLot {
  final int id;
  final String name;
  final String address;
  final String openTime;
  final String closeTime;
  final double starterPrice;
  final double hourlyPrice;
  final String image;
  final int spotCount;
  final int floor;
  final List<Floor> spots;

  ParkingLot({
    required this.id,
    required this.name,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.starterPrice,
    required this.hourlyPrice,
    required this.image,
    required this.spotCount,
    required this.floor,
    required this.spots,
  });

  String? occupyNearestSpot() {
    final sortedFloors = [...spots]
      ..sort((a, b) => a.number.compareTo(b.number));
    for (final floor in sortedFloors) {
      final spot = floor.getFirstAvailableSpot();
      if (spot != null) {
        spot.status = SpotStatus.occupied;
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
      return spot.code;
    }
    return null;
  }

  bool freeSpot(int floorNumber, String spotCode) {
    final floor = spots.firstWhereOrNull((f) => f.number == floorNumber);
    final spot = floor?.findSpot(spotCode);
    if (spot != null && spot.status == SpotStatus.occupied) {
      spot.status = SpotStatus.free;
      return true;
    }
    return false;
  }
}
