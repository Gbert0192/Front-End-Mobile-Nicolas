class ParkingLot {
  final int id;
  final String name;
  final String address;
  final String openTime;
  final String closeTime;
  final double starterPrice;
  final double hourlyPrice;
  final String image;
  final List<String> availableSlot;

  ParkingLot({
    required this.id,
    required this.name,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.starterPrice,
    required this.hourlyPrice,
    required this.image,
    required this.availableSlot,
  });
}
