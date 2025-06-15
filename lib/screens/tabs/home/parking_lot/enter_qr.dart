import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';

class PaymentQrPage extends StatefulWidget {
  final ParkingLot mall;

  const PaymentQrPage({super.key, required this.mall});

  @override
  State<PaymentQrPage> createState() => _PaymentQrPageState();
}

class _PaymentQrPageState extends State<PaymentQrPage> {
  @override
  Widget build(BuildContext context) {
    String generateUniqueId() {
      final random = Random();
      final randomNumber = random.nextInt(9000) + 1000;
      return 'CPA-$randomNumber';
    }

    final String uniqueId = generateUniqueId();

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                'Parking QR Scan',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: QrImageView(
                    data: uniqueId,
                    version: QrVersions.auto,
                    size: 220.0,
                    gapless: false,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.share_outlined, color: Colors.grey),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Unique ID: $uniqueId',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 30),

            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Parking Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow('Parking Area', widget.mall.name),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      'Address',
                      widget.mall.address.split(',')[0],
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      'Available Spots',
                      widget.mall.spotCount.toString(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }
}
