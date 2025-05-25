import 'package:flutter/material.dart';

class Voucher extends StatelessWidget {
  const Voucher({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Available Vouchers',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: isSmall ? 25 : 30,
          ),
        ),
      ),
    );
  }
}
