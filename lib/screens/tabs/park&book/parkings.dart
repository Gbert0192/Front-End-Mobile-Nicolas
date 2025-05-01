import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/parking&booking.dart';

class Parking extends StatelessWidget {
  const Parking({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Parking & Bookings',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
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
                  MaterialPageRoute(builder: (context) => ParkingHistory()),
                );
              },
              child: Container(
                height: screenHeight * 0.35,
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: Color(0xFF1F1E5B),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 15,
                      child: Text(
                        'Parking',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset('assets/others/booking_view.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

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
                  MaterialPageRoute(builder: (context) => ParkingHistory()),
                );
              },
              child: Container(
                height: screenHeight * 0.35,
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: Color(0xFF1F1E5B),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 15,
                      child: Text(
                        'Bookings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Image.asset('assets/others/parking_view.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),

            //bottomNav
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xFF1F1E5B),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  CircleIconButton(icon: Icons.home, destination: HomeScreen()),
                  CircleIconButton(
                    icon: Icons.notifications,
                    destination: HomeScreen(),
                  ),
                  CircleIconButton(
                    icon: Icons.local_parking,
                    color: Colors.deepOrange,
                    destination: Parking(),
                  ),
                  CircleIconButton(
                    icon: Icons.discount,
                    destination: HomeScreen(),
                  ),
                  CircleIconButton(
                    icon: Icons.person,
                    destination: HomeScreen(),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
