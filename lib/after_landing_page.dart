import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/sign_in.dart';
import 'package:tugas_front_end_nicolas/sign_up.dart';

class AfterLandingPage extends StatelessWidget {
  const AfterLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // Transform.rotate(
              //   angle: -pi / 10,
              //   child: Container(
              //     width: MediaQuery.of(context).size.width * 1,
              //     height: MediaQuery.of(context).size.height * 0.3,
              //     decoration: BoxDecoration(
              //       color: const Color(0x334D5DFA),
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 40),
              const Text(
                'THIS IS PARK-ID',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
              ),
              const Text(
                'The first and the best parking app in Indonesia',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              Image.asset('starting/lot2.png', height: 250),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1F1E5B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4D5DFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
