import 'package:flutter/material.dart';

enum ParkingStatus { isParking, isExited, bookingCancel, bookingExpired }

class ParkingCard extends StatelessWidget {
  final String imageUrl;
  final String placeName;
  final ParkingStatus statusText;
  final String dateText;
  final String priceText;

  const ParkingCard({
    super.key,
    required this.imageUrl,
    required this.placeName,
    this.statusText = ParkingStatus.isParking,
    required this.dateText,
    required this.priceText,
  });

  String _getStatusText(ParkingStatus status) {
    switch (status) {
      case ParkingStatus.isParking:
        return "Is Parking";
      case ParkingStatus.isExited:
        return "Exited Parking Lot";
      case ParkingStatus.bookingCancel:
        return "Booking Canceled";
      case ParkingStatus.bookingExpired:
        return "Booking Expired";
    }
  }

  IconData _getStatusIcon(ParkingStatus status) {
    switch (status) {
      case ParkingStatus.isParking:
        return Icons.local_parking;
      case ParkingStatus.isExited:
        return Icons.directions_car;
      case ParkingStatus.bookingCancel:
        return Icons.cancel;
      case ParkingStatus.bookingExpired:
        return Icons.cancel_presentation;
    }
  }

  Color _getStatusColor(ParkingStatus status) {
    switch (status) {
      case ParkingStatus.isParking:
        return Colors.green;
      case ParkingStatus.isExited:
        return Colors.blue;
      case ParkingStatus.bookingCancel:
        return Colors.red;
      case ParkingStatus.bookingExpired:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F9FF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      _getStatusIcon(statusText),
                      color: _getStatusColor(statusText),
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getStatusText(statusText),
                      style: TextStyle(
                        fontSize: 13,
                        color: _getStatusColor(statusText),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                dateText,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 28),
              Text(
                priceText,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
