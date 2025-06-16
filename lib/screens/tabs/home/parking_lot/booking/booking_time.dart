import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/time_picker.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class DetailItem {
  final String label;
  final String value;

  DetailItem({required this.label, required this.value});
}

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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    final List<DetailItem> parkingArea = [
      DetailItem(label: "Parking Area", value: widget.mall.name),
      DetailItem(
        label: "Operate Time",
        value: "${widget.mall.openTime} - ${widget.mall.closeTime}",
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DataCard(title: "Parking Area", listData: parkingArea),
        const SizedBox(height: 12),
        DataCard(title: "Price Booking", listData: rateData),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Select Time",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: isSmall ? 20 : 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Booking Date",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    ResponsiveTimePicker(
                      isSmall: isSmall,
                      onChanged: widget.setDate,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Booking Time",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    ResponsiveTimePicker(
                      isSmall: isSmall,
                      type: DatePickerType.time,
                      onChanged: widget.setTime,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DataCard extends StatelessWidget {
  final List<DetailItem> listData;
  final String title;

  const DataCard({super.key, required this.listData, required this.title});
  final FontWeight fontWeight = FontWeight.w600;
  final double fontSize = 13;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: isSmall ? 25 : 35,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < listData.length; i++) ...[
                  buildDetailRow(
                    label: listData[i].label,
                    value: listData[i].value,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
                  if (i != listData.length - 1) const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
