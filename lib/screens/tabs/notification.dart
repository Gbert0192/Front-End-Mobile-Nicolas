import 'package:flutter/material.dart';

class Notification_ extends StatelessWidget {
  const Notification_({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        ),
      ),
    );
  }
}
