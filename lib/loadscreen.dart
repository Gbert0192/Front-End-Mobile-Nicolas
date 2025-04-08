import 'dart:async';
import 'package:flutter/material.dart';
import 'landing/step1.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({super.key});

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LandingStep()),
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
            Image.asset('assets/Logo.png', height: 150),
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
              'Parkir Lebih Mudah',
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
