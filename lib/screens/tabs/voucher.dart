import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class Voucher {
  final String title;
  final String location;
  final String benefit;
  final int? maxUse;
  final int? minHour;
  final DateTime? validUntil;
  final String image;

  Voucher({
    required this.title,
    required this.location,
    required this.benefit,
    required this.maxUse,
    this.minHour,
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
                    "${translate(context, "Valid at", "Berlaku di", "适用于")} ${voucher.location}",
                    style: TextStyle(fontSize: isSmall ? 12 : 14),
                  ),
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
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Row(
                    children: [
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
                          voucher.maxUse == null
                              ? translate(
                                context,
                                "Unlimited",
                                "Tanpa Batas",
                                "无限制",
                              )
                              : translate(
                                context,
                                'Max Uses ${voucher.maxUse!.toString()}',
                                'Maks ${voucher.maxUse!.toString()} Kali',
                                '最多使用${voucher.maxUse!.toString()}次',
                              ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      if (voucher.minHour != null)
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
                            translate(
                              context,
                              "Min ${voucher.minHour} Hours",
                              "Min ${voucher.minHour} Jam",
                              "最少${voucher.minHour}小时",
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      translate(
                        context,
                        'Valid Until ${DateFormat.yMMMMd().format(voucher.validUntil!)}',
                        'Berlaku Hingga ${DateFormat.yMMMMd().format(voucher.validUntil!)}',
                        '有效期至${DateFormat.yMMMMd().format(voucher.validUntil!)}',
                      ),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
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
        location: 'Sun Plaza',
        benefit: 'Free',
        maxUse: 6,
        minHour: 5,
        validUntil: DateTime(2025, 12, 25),
        image: 'assets/images/building/Sun Plaza.png',
      ),
      Voucher(
        title: 'Free Parking Voucher',
        location: 'Delipark',
        benefit: 'Disc 50%',
        maxUse: null,
        validUntil: DateTime(2025, 12, 28),
        image: 'assets/images/building/Delipark.png',
      ),
      Voucher(
        title: 'Free Parking Voucher',
        location: 'Plaza Medan Fair',
        benefit: 'Disc Rp 7,000.00',
        maxUse: 3,
        minHour: 3,
        validUntil: DateTime(2025, 12, 23),
        image: 'assets/images/building/Plaza Medan Fair.png',
      ),
      Voucher(
        title: 'Free Parking Voucher',
        location: 'Centre Point',
        benefit: 'Disc Rp 5,000.00',
        maxUse: 10,
        validUntil: DateTime(2026, 1, 7),
        image: 'assets/images/building/Centre Point.png',
      ),
      Voucher(
        title: 'Discount 20% Voucher',
        location: 'Lippo Plaza',
        benefit: 'Disc Rp 5,000.00',
        maxUse: 10,
        minHour: 6,
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
                translate(
                  context,
                  'Available Voucher',
                  'Voucher Tersedia',
                  '可用优惠券',
                ),
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
