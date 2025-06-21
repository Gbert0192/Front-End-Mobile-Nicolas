import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/detail_component.dart';
import 'package:tugas_front_end_nicolas/components/time_picker.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';
import 'package:tugas_front_end_nicolas/utils/useform.dart';

class BookingTime extends StatefulWidget {
  const BookingTime({
    required this.mall,
    required this.setDate,
    required this.setTime,
    required this.date,
    required this.time,
  });
  final ParkingLot mall;
  final Function(String) setDate;
  final Function(String) setTime;
  final String? date;
  final String? time;

  @override
  State<BookingTime> createState() => _BookingTimeState();
}

class _BookingTimeState extends State<BookingTime> {
  final form = UseForm(fields: ["date", "time"]);

  @override
  void initState() {
    super.initState();
    form.control('date').text = (widget.date ?? "");
    form.control('time').text = (widget.time ?? "");
  }

  DateTime _getSmartDefaultDateTime() {
    DateTime now = DateTime.now();
    int currentMinute = now.minute;
    int roundedMinute;
    int hourOffset = 0;

    if (currentMinute <= 15) {
      roundedMinute = 0;
      hourOffset = 1;
    } else if (currentMinute <= 45) {
      roundedMinute = 30;
      hourOffset = 1;
    } else {
      roundedMinute = 0;
      hourOffset = 2;
    }

    return DateTime(
      now.year,
      now.month,
      now.day,
      now.hour + hourOffset,
      roundedMinute,
    );
  }

  TimeOfDay _calculateMinTime() {
    if (widget.date == null || widget.date!.isEmpty) {
      return widget.mall.openTime;
    }

    final parts = widget.date!.split('/');

    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    final selectedDate = DateTime(year, month, day);
    final now = DateTime.now();

    final isToday =
        now.year == selectedDate.year &&
        now.month == selectedDate.month &&
        now.day == selectedDate.day;

    if (isToday) {
      final nowTime = TimeOfDay.fromDateTime(now);
      final openTime = widget.mall.openTime;
      final closeTime = widget.mall.closeTime;

      final isAfterOpen =
          nowTime.hour > openTime.hour ||
          (nowTime.hour == openTime.hour && nowTime.minute >= openTime.minute);

      if (isAfterOpen) {
        final futureTime = now.add(Duration(hours: 1));

        final closeDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          closeTime.hour,
          closeTime.minute,
        );

        final oneHourBeforeClose = closeDateTime.subtract(Duration(hours: 1));

        if (futureTime.isAfter(oneHourBeforeClose)) {
          return openTime;
        }

        return TimeOfDay.fromDateTime(futureTime);
      }
    }

    return widget.mall.openTime;
  }

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
          controller: form.control("date"),
          onChanged: widget.setDate,
          minDate: DateTime.now(),
        ),
      ),
      DetailItem(
        label: "Booking Time",
        child: ResponsiveTimePicker(
          controller: form.control("time"),
          disabled: widget.date == null || widget.date!.isEmpty,
          minTime: _calculateMinTime(),
          initialTime: _getSmartDefaultDateTime(),
          maxTime: TimeOfDay(
            hour: widget.mall.closeTime.hour - 1,
            minute: widget.mall.closeTime.minute,
          ),
          onChanged: widget.setTime,
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
        DataCard(title: "Select Time", listInput: timeInput),
      ],
    );
  }
}
