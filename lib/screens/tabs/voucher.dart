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
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: const Color.fromARGB(255, 217, 217, 217)),
      ),
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmall ? 16 : 18,
                    ),
                  ),
                  Text(
                    voucher.location,
                    style: TextStyle(fontSize: isSmall ? 12 : 14),
                  ),
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
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                voucher.image,
                width: isSmall ? 100 : 120,
                height: isSmall ? 100 : 120,
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
  VoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    final vouchers = [
      Voucher(
        title: 'Free Parking Voucher',
        location: 'Sun Plaza only',
        benefit: 'Free',
        maxUse: 'Max Uses 6',
        validUntil: DateTime(2025, 12, 25),
        image: 'assets/images/building/Sun Plaza.png',
      ),
      Voucher(
        title: 'Free Parking Voucher',
        location: 'Valid at Delipark',
        benefit: 'Disc 50%',
        maxUse: 'Unlimited',
        validUntil: DateTime(2025, 12, 28),
        image: 'assets/images/building/Delipark.png',
      ),
      Voucher(
        title: 'Free Parking Voucher',
        location: 'Valid at Plaza Medan Fair',
        benefit: 'Disc Rp 7,000.00',
        maxUse: 'Max Uses 3',
        validUntil: DateTime(2025, 12, 23),
        image: 'assets/images/building/Plaza Medan Fair.png',
      ),
      Voucher(
        title: 'Free Parking Voucher',
        location: 'Valid at Centre Point',
        benefit: 'Disc Rp 5,000.00',
        maxUse: 'Max Uses 10',
        validUntil: DateTime(2026, 1, 7),
        image: 'assets/images/building/Centre Point.png',
      ),
      Voucher(
        title: 'Discount 20% Voucher',
        location: 'Valid at Lippo Plaza',
        benefit: 'Disc Rp 5,000.00',
        maxUse: 'Max Uses 10',
        validUntil: DateTime(2025, 10, 7),
        image: 'assets/images/building/Lippo Plaza.png',
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                'Available Voucher',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: isSmall ? 25 : 30,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children:
                      vouchers
                          .map((voucher) => VoucherCard(voucher: voucher))
                          .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
