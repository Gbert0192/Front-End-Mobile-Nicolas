import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/screens/reset_password.dart';
import 'package:tugas_front_end_nicolas/screens/sign_in.dart';
import 'package:tugas_front_end_nicolas/screens/stepper.dart';
import 'package:tugas_front_end_nicolas/screens/splash_screen.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MainApp()));
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        //this need sincronize with the splash screen
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (_, __, ___) => StepperScreens(),
          transitionsBuilder: (_, animation, __, child) {
            var tween = Tween(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeOut));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
