import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/screens/home.dart';
import 'package:tugas_front_end_nicolas/screens/parking.dart';

class ResponsiveBottomNav extends StatefulWidget {
  const ResponsiveBottomNav({super.key});

  @override
  State<ResponsiveBottomNav> createState() => _ResponsiveBottomNavState();
}

class _ResponsiveBottomNavState extends State<ResponsiveBottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1E5B),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleIconButton(
            icon: Icons.home,
            color: Colors.deepOrange,
            destination: HomeScreen(),
          ),
          CircleIconButton(
            icon: Icons.notifications,
            destination: HomeScreen(),
          ),
          CircleIconButton(icon: Icons.local_parking, destination: Parking()),
          CircleIconButton(icon: Icons.discount, destination: HomeScreen()),
          CircleIconButton(icon: Icons.person, destination: HomeScreen()),
        ],
      ),
    );
  }
}

// CircleIconButton widget
class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Widget destination;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.destination,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
      },
      icon: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.grey.shade200,
        child: Icon(icon, color: color),
      ),
      iconSize: 50,
    );
  }
}
