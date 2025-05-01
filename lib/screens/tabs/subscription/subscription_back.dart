import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/home.dart';

class SubscriptionBack extends StatelessWidget {
  final String title;

  const SubscriptionBack({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(isSmall ? 30 : 50),
            child: (Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/popup/subscription.png',
                    width: isSmall ? 200 : 300,
                  ),
                  SizedBox(height: isSmall ? 20 : 40),
                  Text(
                    'Payment Success',
                    style: TextStyle(
                      color: Color(0xFF1F1E5B),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: isSmall ? 10 : 20),
                  Text(
                    'Congrats, you have become our ${title} member',
                    style: TextStyle(
                      color: Color(0xFF9C9CA0),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: isSmall ? 50 : 110),

                  //Button
                  ResponsiveButton(
                    isSmall: isSmall,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    text: 'Back to Home',
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
