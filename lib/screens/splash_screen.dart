import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5C6BC0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 150),
            const SizedBox(height: 30),
            const Text(
              'PARK-ID',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Easier to Park',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Cursive',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
