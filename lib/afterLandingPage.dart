import 'dart:math';

import 'package:flutter/material.dart';

class AfterLandingPage extends StatelessWidget {
  const AfterLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: -pi / 10,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: const Color(0x334D5DFA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'THIS IS PARK-ID',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              const Text(
                'The first and the best parking app in Indonesia',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
