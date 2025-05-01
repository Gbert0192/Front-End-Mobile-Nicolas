import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        ),
      ),
    );
  }
}
