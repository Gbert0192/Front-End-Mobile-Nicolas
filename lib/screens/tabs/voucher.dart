import 'package:flutter/material.dart';

class Voucher extends StatelessWidget {
  const Voucher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Vouchers',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        ),
      ),
    );
  }
}
