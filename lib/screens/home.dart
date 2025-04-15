import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String nama;

  const HomePage({super.key, required this.nama});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [const Text('Home Page')]));
  }
}
