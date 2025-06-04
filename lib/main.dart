import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/provider/booking_provider.dart';
import 'package:tugas_front_end_nicolas/provider/language_provider.dart';
import 'package:tugas_front_end_nicolas/provider/notification_provider.dart';
import 'package:tugas_front_end_nicolas/provider/otp_provider.dart';
import 'package:tugas_front_end_nicolas/provider/parking_lot_provider.dart';
import 'package:tugas_front_end_nicolas/provider/parking_provider.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
import 'package:tugas_front_end_nicolas/provider/voucher_provider.dart';
import 'package:tugas_front_end_nicolas/screens/starting/splash_screen.dart';
import 'package:tugas_front_end_nicolas/screens/starting/stepper.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/search/search_tes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OTPProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ParkingLotProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => VoucherProvider()),
        ChangeNotifierProvider(create: (_) => ParkingProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            },
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
          fontFamily: 'Poppins',
          popupMenuTheme: PopupMenuThemeData(color: Colors.white),
        ),
        debugShowCheckedModeBanner: false,
        home: MainApp(),
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
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
