import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/bookingParking.dart';
import 'package:tugas_front_end_nicolas/model/history.dart';

enum historyType { parking, booking }

class HistoryList extends StatelessWidget {
  const HistoryList(this.type);
  final historyType type;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    final isBooking = type == historyType.booking;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Material(
                  color: Colors.white,
                  shape: const CircleBorder(),
                  elevation: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(12),
                      elevation: 1,
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
              ),
              elevation: 0,
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: isSmall ? 20.0 : 25.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        isBooking ? "Bookings" : 'Parkings',
                        style: TextStyle(
                          fontSize: isSmall ? 30 : 36,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
