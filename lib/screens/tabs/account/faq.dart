import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/other/FAQ.png"),
            fit: BoxFit.cover,
            opacity: 0.25,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                "Your Content Here",
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
