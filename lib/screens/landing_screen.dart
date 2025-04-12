import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/screens/sign_in.dart';
import 'package:tugas_front_end_nicolas/screens/sign_up.dart';
import 'dart:math' as math;

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

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
                width: size.width * 2,
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
                width: size.width * 2,
                height: 300,
                color: const Color(0xFFD3DEFF),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: isSmall ? 60 : 120),
                  Text(
                    'THIS IS PARK-ID',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmall ? 26 : 40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'The first and the best parking app in Indonesia',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isSmall ? 18 : 24,
                      color: Colors.grey,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/starting/Lot2.png',
                    height: isSmall ? 200 : 280,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  ResponsiveButton(
                    isSmall: isSmall,
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SignIn()),
                        ),
                    text: "Sign In",
                  ),
                  SizedBox(height: (isSmall ? 0 : 10)),
                  ResponsiveButton(
                    isSmall: isSmall,
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SignUp()),
                        ),
                    text: "Sign Up",
                    backgroundColor: Color(0xFF4D5DFA),
                  ),
                  SizedBox(height: isSmall ? 24 : 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
