import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/receipt.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class Booking extends StatefulWidget {
  final String spotTypeEn;
  final String spotTypeId;
  final String spotTypeCn;

  const Booking({
    super.key,
    required this.spotTypeEn,
    required this.spotTypeId,
    required this.spotTypeCn,
  });

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F8),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color(0xFFEFF1F8),
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
              centerTitle: true,
              title: Text(
                translate(context, 'Receipt', 'Kuintansi', '收据'),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          ReceiptText(
                            left: translate(
                              context,
                              'Parking Area',
                              'Area Parkir',
                              '停车场',
                            ),
                            right: 'mall.name',
                            isRed: false,
                          ),
                          ReceiptText(
                            left: translate(context, 'Address', 'Alamat', '地址'),
                            right: 'mall.address',
                            isRed: false,
                          ),
                          // ReceiptText(
                          //   left: translate(
                          //     context,
                          //     spotTypeEn,
                          //     spotTypeId,
                          //     spotTypeCn,
                          //   ),
                          //   right: 'mall.spot',
                          //   isRed: false,
                          // ),
                          ReceiptText(
                            left: translate(
                              context,
                              'Duration',
                              'Durasi',
                              '持续时间',
                            ),
                            right: 'mall',
                            isRed: false,
                          ),
                          ReceiptText(
                            left: translate(
                              context,
                              'Check-in Time',
                              'Waktu Masuk',
                              '签到时间',
                            ),
                            right: 'checkInTime',
                            isRed: false,
                          ),
                          ReceiptText(
                            left: translate(
                              context,
                              'Check-out Time',
                              'Waktu Keluar',
                              '签出时间',
                            ),
                            right: 'checkOutTime',
                            isRed: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          ReceiptText(
                            left: translate(context, 'Amount', 'Jumlah', '停车场'),
                            right: 'mall.price',
                            isRed: false,
                          ),
                          ReceiptText(
                            left: translate(context, 'Address', 'Alamat', '地址'),
                            right: 'mall.address',
                            isRed: false,
                          ),
                          ReceiptText(
                            left: translate(
                              context,
                              'Taxes (11%)',
                              'Tempat Pemesanan',
                              '预订地点',
                            ),
                            right: 'mall.spot',
                            isRed: false,
                          ),
                          ReceiptText(
                            left: translate(
                              context,
                              'Duration',
                              'Durasi',
                              '持续时间',
                            ),
                            right: 'mall',
                            isRed: false,
                          ),

                          ReceiptText(
                            left: translate(
                              context,
                              'Service Fee',
                              'Biaya Pelayanan',
                              '签出时间',
                            ),
                            right: 'checkOutTime',
                            isRed: true,
                          ),
                          Divider(indent: 5),
                          ReceiptText(
                            left: translate(context, 'Total', 'Total', ''),
                            right: 'totalProce',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 70),
                    ResponsiveButton(
                      isSmall: isSmall,

                      text: translate(
                        context,
                        'View Parking Area',
                        'Lihat Area Parkir',
                        '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
