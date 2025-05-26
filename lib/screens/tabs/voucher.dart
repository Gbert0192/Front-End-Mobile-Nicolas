import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Voucher {
  final String title;
  final String location;
  final String benefit;
  final String maxUse;
  final DateTime? validUntil;
  final String image;

  Voucher({
    required this.title,
    required this.location,
    required this.benefit,
    required this.maxUse,
    this.validUntil,
    required this.image,
  });
}

class VoucherCard extends StatelessWidget {
  final Voucher voucher;

  const VoucherCard({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voucher.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(voucher.location),
                  if (voucher.benefit.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E61),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        voucher.benefit,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  if (voucher.maxUse.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E61),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        voucher.maxUse,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  if (voucher.validUntil != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Valid Until ${DateFormat.yMMMMd().format(voucher.validUntil!)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                voucher.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vouchers = [
      Voucher(
        title: 'Free Parking Voucher',
        location: 'Sun Plaza only',
        benefit: 'Free',
        maxUse: 'Max Uses 6',
        validUntil: DateTime(2025, 12, 25),
        image: 'assets/images/building/Delipark.jpg',
      ),
      Voucher(
        title: 'Free Parking Voucher',
        location: 'Valid at Delipark',
        benefit: 'Disc 50%',
        maxUse: 'Unlimited',
        validUntil: DateTime(2025, 12, 28),
        image: 'assets/images/building/Thambrin Plaza.jpg',
      ),
      Voucher(
        title: 'Free Parking Voucher',
        location: 'Valid at Thamrin Plaza',
        benefit: 'Disc Rp 7,000.00',
        maxUse: 'Max Uses 3',
        validUntil: DateTime(2025, 12, 23),
        image: 'assets/images/building/Thambrin Plaza.jpg',
      ),
      Voucher(
        title: 'Free Parking Voucher',
        location: 'Valid at Centre Point',
        benefit: 'Disc Rp 5,000.00',
        maxUse: 'Max Uses 10',
        validUntil: DateTime(2026, 1, 7),
        image: 'assets/images/building/Centre Point.jpeg',
      ),
      Voucher(
        title: 'Discount 20% Voucher',
        location: 'Valid at Thamrin Plaza',
        benefit: 'Disc Rp 5,000.00',
        maxUse: 'Max Uses 10',
        validUntil: null,
        image: 'assets/images/building/Thambrin Plaza.jpg',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9C4),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Vouchers',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Text(
              'Available Vouchers',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: vouchers.length,
                itemBuilder: (context, index) {
                  return VoucherCard(voucher: vouchers[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
