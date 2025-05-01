import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

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
                  Image.asset(
                    'assets/logo_no_padding.png',
                    height: isSmall ? 150 : 225,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'PARK-ID',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmall ? 32 : 48,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4.0,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Parking Made Easier',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmall ? 40 : 60,
                      fontFamily: 'Cursive',
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 6.0,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ],
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
