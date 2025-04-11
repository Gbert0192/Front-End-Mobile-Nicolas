import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final size = MediaQuery.of(context).size;

    // You can use these to scale elements
    final isSmallScreen = size.width < 600;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4F4EA2), Color(0xFF9DAFEC), Color(0xFF4F4EA2)],
          ),
        ),
        child: Center(
          child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Adjust logo height based on screen size
                  Image.asset(
                    'assets/logo_no_padding.png',
                    height: isSmallScreen ? 150 : 225,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'PARK-ID',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 28 : 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    'Easier to Park',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 20 : 30,
                      fontFamily: 'Cursive',
                    ),
                  ),
                ],
              )
              .animate()
              .slideY(begin: 1, end: 0, duration: 800.ms)
              .fadeIn(duration: 800.ms),
        ),
      ),
    );
  }
}
