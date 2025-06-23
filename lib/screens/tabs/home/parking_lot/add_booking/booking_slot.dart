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
    required this.floor,
    this.slot,
  });
  final ParkingLot mall;
  final Function(String) setFloor;
  final Function(String) setSlot;
  final String floor;
  final String? slot;

  @override
  State<BookingSlot> createState() => _BookingSlotState();
}

class _BookingSlotState extends State<BookingSlot> {
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
    Floor slots = allSlots.firstWhere((item) => item.number == widget.floor);
    final List<Widget> children = [];
    final parts = widget.slot?.split("-");
    final String? selectedFloor = parts?.isNotEmpty == true ? parts![0] : null;
    final String? selectedSpot = parts?.length == 2 ? parts![1] : null;
    for (int areaIndex = 0; areaIndex < 2; areaIndex++) {
      final spots = slots.areas[areaIndex].spots;
      bool hasNonFreeSpot = slots.areas[areaIndex].spots.any(
        (spot) => spot.status != SpotStatus.free,
      );

      bool allOccupied = slots.areas[areaIndex].spots.every(
        (spot) => spot.status != SpotStatus.free,
      );

      children.add(
        Positioned(
          right: 15,
          top:
              areaIndex == 0
                  ? allOccupied
                      ? 5
                      : 1
                  : null,
          bottom:
              areaIndex == 1
                  ? allOccupied
                      ? 10
                      : 7
                  : null,
          child: Column(
            children: List.generate((spots.length / 2).ceil(), (index) {
              final start = index * 2;
              final end = (start + 2 > spots.length) ? spots.length : start + 2;
              final rowItems = spots.sublist(start, end);

              return Row(
                children: List.generate(rowItems.length, (i) {
                  return Row(
                    children: [
                      if (i != 0)
                        SizedBox(
                          width:
                              allOccupied
                                  ? 20
                                  : hasNonFreeSpot
                                  ? 25
                                  : 30,
                        ),
                      SpotRender(
                        item: rowItems[i],
                        onTap: widget.setSlot,
                        selectedSlot: widget.slot,
                        currentFloor: widget.floor,
                      ),
                    ],
                  );
                }),
              );
            }),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(
          spacing: isSmall ? 6 : 8,
          runSpacing: isSmall ? 6 : 8,
          children:
              allSlots.map((item) {
                final floorLabel = _formatFloorLabel(item.number);
                return GestureDetector(
                  onTap: () {
                    widget.setFloor(item.number);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color:
                          widget.floor != item.number
                              ? Colors.white
                              : Color(0xFF4D5DFA),
                      border: Border.all(color: Color(0xFF4D5DFA), width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      floorLabel,
                      style: TextStyle(
                        color:
                            widget.floor == item.number
                                ? Colors.white
                                : Color(0xFF4D5DFA),
                        fontSize: isSmall ? 12 : 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.1),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.grey.shade50],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          widget.slot != null
                              ? Colors.green.shade50
                              : Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      widget.slot != null
                          ? Icons.local_parking
                          : Icons.location_searching,
                      color:
                          widget.slot != null
                              ? Colors.green.shade600
                              : Colors.orange.shade600,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selected Parking Spot",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          widget.slot != null
                              ? "${_formatFloorLabel(selectedFloor!)} ($selectedSpot)"
                              : "Pick Your Slot",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:
                                widget.slot != null
                                    ? Colors.grey.shade800
                                    : Colors.orange.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.slot == null)
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.shade400,
                      size: 16,
                    ),
                ],
              ),
            ),
          ),
        ),
        DataCard(
          listInput: [
            DetailItem(
              label: "Entry",
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/others/parking area.png",
                    height: 400,
                  ),
                  ...children,
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SpotRender extends StatelessWidget {
  final Spot item;
  final String? selectedSlot;
  final String currentFloor;
  final Function(String) onTap;

  const SpotRender({
    required this.item,
    this.selectedSlot,
    required this.currentFloor,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child:
          item.status != SpotStatus.free
              ? Image.asset("assets/images/others/car.png", width: 67)
              : GestureDetector(
                onTap: () => onTap("$currentFloor-${item.code}"),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color:
                        selectedSlot != "$currentFloor-${item.code}"
                            ? Colors.white
                            : const Color(0xFF4D5DFA),
                    border: Border.all(
                      color: const Color(0xFF4D5DFA),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    item.code,
                    style: TextStyle(
                      color:
                          selectedSlot == "$currentFloor-${item.code}"
                              ? Colors.white
                              : const Color(0xFF4D5DFA),
                      fontSize: isSmall ? 12 : 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
    );
  }
}
