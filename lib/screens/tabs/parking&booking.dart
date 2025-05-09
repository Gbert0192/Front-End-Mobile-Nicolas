import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/park&book/booking.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/park&book/parkings.dart';

class ParkingHistory extends StatelessWidget {
  const ParkingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Parking & Bookings',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isSmall ? 12 : 24),
            child: Column(
              children: [
                //Button Parking
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Parkings()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1F1E5B),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Image.asset('assets/others/booking_view.png'),
                        ),
                        Positioned(
                          top: 10,
                          left: 15,
                          child: Text(
                            'Parkings',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: isSmall ? 20 : 25,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding:
                                isSmall
                                    ? EdgeInsets.all(10)
                                    : EdgeInsets.only(
                                      top: 50,
                                      left: 20,
                                      right: 20,
                                      bottom: 20,
                                    ),
                            child: Image.asset(
                              'assets/others/booking_view.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: isSmall ? 20 : 30),

                // Button Booking
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Booking()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1F1E5B),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding:
                              isSmall
                                  ? EdgeInsets.all(10)
                                  : EdgeInsets.only(
                                    top: 70,
                                    left: 20,
                                    right: 20,
                                    bottom: 30,
                                  ),
                          child: Image.asset('assets/others/parking_view.png'),
                        ),
                        Positioned(
                          top: 10,
                          left: 15,
                          child: Text(
                            'Bookings',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: isSmall ? 20 : 25,
                            ),
                          ),
                        ),
                      ],
                    ),
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
