import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

enum ParkingStatus { isParking, isExited, bookingCancel, bookingExpired }

class ParkingCard extends StatelessWidget {
  final String imageUrl;
  final String placeName;
  final ParkingStatus statusText;
  final String dateText;
  final double priceText;

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
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F9FF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl,
              width: 95,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeName,
                  style: TextStyle(
                    fontSize: isSmall ? 16 : 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Icon(
                      _getStatusIcon(statusText),
                      color: _getStatusColor(statusText),
                      size: isSmall ? 14 : 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getStatusText(statusText),
                      style: TextStyle(
                        fontSize: 12,
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
                style: TextStyle(
                  color: const Color.fromRGBO(0, 0, 0, 0.75),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                "${formatCurrency(nominal: priceText)}/h",
                style: TextStyle(
                  fontSize: isSmall ? 13 : 15,
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
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
