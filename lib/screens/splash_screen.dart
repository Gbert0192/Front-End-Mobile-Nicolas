import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/screens/stepper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StepperScreens()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5C6BC0), // gradasi ungu ke biru
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
                fontFamily:
                    'Cursive', // Sesuaikan dengan font atau pakai Google Fonts
              ),
            ),
          ],
        ),
      ),
    );
  }
}
