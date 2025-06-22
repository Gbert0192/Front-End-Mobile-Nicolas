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

  bool _checkBookingClose() {
    final now = DateTime.now();

    final todayOpen = DateTime(
      now.year,
      now.month,
      now.day,
      widget.mall.openTime.hour,
      widget.mall.openTime.minute,
    );

    final todayClose = DateTime(
      now.year,
      now.month,
      now.day,
      widget.mall.closeTime.hour,
      widget.mall.closeTime.minute,
    );

    final oneHourBeforeClose = todayClose.subtract(const Duration(hours: 1));

    final isBeforeOpen = now.isBefore(todayOpen);
    final isAfterClose = now.isAfter(todayClose);
    final isClosing = now.isAfter(oneHourBeforeClose);
    return isBeforeOpen || isAfterClose || isClosing;
  }

  DateTime _getMinDate() {
    final now = DateTime.now();

    if (_checkBookingClose()) {
      return DateTime(
        now.year,
        now.month,
        now.day,
      ).add(const Duration(days: 1));
    }

    return now;
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
        selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;

    if (isToday) {
      final oneHourFromNow = now.add(const Duration(hours: 1));
      return TimeOfDay(
        hour: oneHourFromNow.hour,
        minute: oneHourFromNow.minute,
      );
    } else {
      return widget.mall.openTime;
    }
  }

  DateTime _getSmartDefaultDateTime() {
    DateTime now = DateTime.now();
    int currentMinute = now.minute;
    int roundedMinute;
    int hourOffset = 0;

    if (_checkBookingClose()) {
      return DateTime(
        now.year,
        now.month,
        now.day,
        widget.mall.openTime.hour,
        widget.mall.openTime.minute,
      );
    }

    if (currentMinute <= 30) {
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
          minDate: _getMinDate(),
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
      crossAxisAlignment: CrossAxisAlignment.center,
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
