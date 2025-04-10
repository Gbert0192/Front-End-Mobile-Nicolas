import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/screens/sign_in.dart';
import 'package:tugas_front_end_nicolas/screens/sign_up.dart';
import 'dart:math' as math;

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Top Rotated Box
          Positioned(
            top: -240,
            left: -100,
            child: Transform.rotate(
              angle: -15 * math.pi / 180,
              child: Container(
                width: MediaQuery.of(context).size.width * 2,
                height: 300,
                color: const Color(0xFFD3DEFF),
              ),
            ),
          ),

          // Bottom Rotated Box
          Positioned(
            bottom: -240,
            right: -100,
            child: Transform.rotate(
              angle: -15 * math.pi / 180,
              child: Container(
                width: MediaQuery.of(context).size.width * 2,
                height: 300,
                color: const Color(0xFFD3DEFF),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 90.0),
              child: Column(
                children: [
                  const Text(
                    'THIS IS PARK-ID',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'The first and the best parking app in Indonesia',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Image.asset('assets/starting/lot2.png', height: 220),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 240,
                    child: Container(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1F1E5B),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 240,
                    child: Container(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4D5DFA),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
