import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/home/parking_lot/booking/booking_time.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class DetailItem {
  final String label;
  final String value;

  DetailItem({required this.label, required this.value});
}

class AddBooking extends StatefulWidget {
  const AddBooking(this.mall);
  final ParkingLot mall;
  @override
  State<AddBooking> createState() => _AddBookingState();
}

class _AddBookingState extends State<AddBooking> {
  final PageController _controller = PageController();

  int currentPage = 0;
  bool isLoading = false;
  String? date;
  String? time;
  String? floor;
  String? slot;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Scaffold(
      backgroundColor: Color(0xFFEFF1F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: isSmall ? 5 : 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (currentPage == 0) {
                          Navigator.pop(context);
                        } else {
                          _controller.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      icon: Icon(Icons.arrow_back_ios, size: isSmall ? 25 : 30),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Create Booking",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: isSmall ? 20 : 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 700,
                  child: PageView(
                    controller: _controller,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      BookingTime(
                        mall: widget.mall,
                        setDate: (String val) {
                          setState(() {
                            date = val;
                          });
                        },
                        setTime: (String val) {
                          setState(() {
                            time = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Button
                Center(
                  child: ResponsiveButton(
                    isSmall: isSmall,
                    isLoading: isLoading,
                    onPressed: () {
                      if (currentPage == 0) {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    text: "Continue",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
