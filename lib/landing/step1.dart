import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/landing/step2.dart';
import 'package:tugas_front_end_nicolas/signIn/signIn.dart';

class LandingStep extends StatelessWidget {
  const LandingStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Find Parking Easily',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Find parking around you easily and online',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 40),
              Image.asset(
                'assets/starting/toy car turn right blue.png',
                height: 200,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [buildDot(isActive: true), buildDot(), buildDot()],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LandingStep2()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4D5DFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0x334D5DFA),
                    side: const BorderSide(color: Color(0x334D5DFA)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: Color(0xFF4D5DFA)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDot({bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.blueAccent : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }
}
