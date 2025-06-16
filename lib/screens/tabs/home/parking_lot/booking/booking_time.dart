import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class BookingTime extends StatefulWidget {
  const BookingTime({super.key});

  @override
  State<BookingTime> createState() => _BookingTimeState();
}

class _BookingTimeState extends State<BookingTime> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Column(children: [Text("Booking Time")]);
  }
}
