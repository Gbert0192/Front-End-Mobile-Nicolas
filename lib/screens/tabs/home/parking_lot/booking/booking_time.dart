import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/detail_component.dart';
import 'package:tugas_front_end_nicolas/components/time_picker.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class BookingTime extends StatefulWidget {
  const BookingTime({
    required this.mall,
    required this.setDate,
    required this.setTime,
  });
  final ParkingLot mall;
  final Function(String) setDate;
  final Function(String) setTime;

  @override
  State<BookingTime> createState() => _BookingTimeState();
}

class _BookingTimeState extends State<BookingTime> {
  String? date;
  @override
  Widget build(BuildContext context) {
    final List<DetailItem> parkingArea = [
      DetailItem(label: "Parking Area", value: widget.mall.name),
      DetailItem(
        label: "Operate Time",
        value:
            "${timeToString(widget.mall.openTime)} - ${timeToString(widget.mall.closeTime)}",
      ),
      DetailItem(label: "Address", value: widget.mall.address),
      DetailItem(
        label: "Available Slots",
        value: widget.mall.getFreeCount().toString(),
      ),
    ];

    final List<DetailItem> rateData = [
      DetailItem(
        label: "Hourly Rate",
        value:
            "${formatCurrency(nominal: widget.mall.hourlyPrice, decimalPlace: 0)} / hour",
      ),
      DetailItem(
        label: "Entry Price",
        value: formatCurrency(
          nominal: widget.mall.starterPrice ?? widget.mall.hourlyPrice,
          decimalPlace: 0,
        ),
      ),
    ];

    final List<DetailItem> timeInput = [
      DetailItem(
        label: "Booking Date",
        child: ResponsiveTimePicker(
          onChanged: (val) {
            widget.setDate(val);
            setState(() {
              date = val;
            });
          },
          minDate: DateTime.now(),
        ),
      ),
      DetailItem(
        label: "Booking Time",
        child: ResponsiveTimePicker(
          disabled: date == null,
          minTime: widget.mall.openTime,
          maxTime: widget.mall.closeTime,
          onChanged: widget.setDate,
          type: DatePickerType.time,
        ),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DataCard(title: "Parking Area", listData: parkingArea),
        const SizedBox(height: 12),
        DataCard(title: "Price Booking", listData: rateData),
        const SizedBox(height: 12),
        DataCard(title: "Select Time", children: timeInput),
      ],
    );
  }
}
