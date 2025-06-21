import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/components/detail_component.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/provider/parking_lot_provider.dart';

class BookingSlot extends StatefulWidget {
  const BookingSlot({
    required this.mall,
    required this.setFloor,
    required this.setSlot,
  });
  final ParkingLot mall;
  final Function(String) setFloor;
  final Function(String) setSlot;

  @override
  State<BookingSlot> createState() => _BookingSlotState();
}

class _BookingSlotState extends State<BookingSlot> {
  int currentFloor = 0;
  String _formatFloorLabel(String floor) {
    if (floor.startsWith('G')) {
      return "$floor Floor";
    }

    final num = int.tryParse(floor);
    if (num == null) return "$floor Floor";

    String suffix;
    if (num >= 11 && num <= 13) {
      suffix = "th";
    } else {
      switch (num % 10) {
        case 1:
          suffix = "st";
          break;
        case 2:
          suffix = "nd";
          break;
        case 3:
          suffix = "rd";
          break;
        default:
          suffix = "th";
      }
    }

    return "$num$suffix Floor";
  }

  @override
  Widget build(BuildContext context) {
    final lotProvider = Provider.of<ParkingLotProvider>(context);
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    final List<Floor> allSlots = lotProvider.getAvailableSpot(widget.mall);
    Floor slots = allSlots[currentFloor];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              allSlots.map((item) {
                final floorLabel = _formatFloorLabel(item.number);

                return ElevatedButton(
                  onPressed: () {
                    // TODO: handle click
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF4D5DFA), // text color
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Color(0xFF4D5DFA), width: 2),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    floorLabel,
                    style: TextStyle(
                      fontSize: isSmall ? 12 : 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
        ),

        DataCard(title: "Entry", listInput: []),
      ],
    );
  }
}
