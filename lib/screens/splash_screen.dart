import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: SizedBox(
              height: 300,
              width: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 140,
                    child: Image.asset('assets/logo.png', height: 225),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 130),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'PARK-ID',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          'Easier to Park',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontFamily: 'Cursive',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
            .animate()
            .slideY(begin: 1, end: 0, duration: 800.ms)
            .fadeIn(duration: 800.ms),
      ),
    );
  }
}
