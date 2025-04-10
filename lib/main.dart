import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:tugas_front_end_nicolas/screens/splash_screen.dart';
import 'package:tugas_front_end_nicolas/screens/stepper.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ParKID",
      home: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: SplashScreen(),
      nextScreen: StepperScreens(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.blue[800]!,
    );
  }
}
