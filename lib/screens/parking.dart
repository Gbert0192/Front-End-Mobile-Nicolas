import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/bottom_nav.dart';
import 'package:tugas_front_end_nicolas/screens/home.dart';
import 'package:tugas_front_end_nicolas/screens/parking_history.dart';

class Parking extends StatelessWidget {
  const Parking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Notification',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          //Button Parking
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ParkingHistory()),
              );
            },
            child: Container(height: 180, child: Stack()),
          ),
          SizedBox(height: 20),
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
                CircleIconButton(icon: Icons.person, destination: HomeScreen()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
