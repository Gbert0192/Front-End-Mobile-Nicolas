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
    for (final floor in spots..sort((a, b) => a.number.compareTo(b.number))) {
      if (floor.availableSpots.isNotEmpty) {
        final spot = floor.availableSpots.removeAt(0);
        return 'Occupied spot $spot at floor ${floor.number}';
      }
    }
    return null;
  }

  bool occupySpot(int floorNumber, String spot) {
    final floor = spots.firstWhere(
      (f) => f.number == floorNumber,
      orElse: () => throw Exception('Floor $floorNumber not found'),
    );
    if (floor.availableSpots.contains(spot)) {
      floor.availableSpots.remove(spot);
      return true;
    }
    return false;
  }

  bool freeSpot(int floorNumber, String spot) {
    final floor = spots.firstWhere(
      (f) => f.number == floorNumber,
      orElse: () => throw Exception('Floor $floorNumber not found'),
    );
    if (!floor.availableSpots.contains(spot)) {
      floor.availableSpots.add(spot);
      floor.availableSpots.sort();
      return true;
    }
    return false;
  }
}

class Floor {
  final int number;
  final int totalSpots;
  final List<String> availableSpots;

  Floor({
    required this.number,
    required this.totalSpots,
    required this.availableSpots,
  });
}
