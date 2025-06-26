import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/detail_component.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class ReceiptT extends StatefulWidget {
  // final Parking parking;
  final String spotTypeEn;
  final String spotTypeId;
  final String spotTypeCn;

  const ReceiptT({
    super.key,
    // required this.parking,
    required this.spotTypeEn,
    required this.spotTypeId,
    required this.spotTypeCn,
  });

  @override
  State<ReceiptT> createState() => _ReceiptTState();
}

class _ReceiptTState extends State<ReceiptT> {
  @override
  Widget build(BuildContext context) {
    final List<DetailItem> bookInfo = [
      DetailItem(
        label: translate(context, 'Parking Area', 'Area Parkir', '停车场'),
        value: 'widget.parking.lot.name',
      ),
      DetailItem(
        label: translate(context, 'Address', 'Alamat', '地址'),
        value: 'widget.parking.lot.address',
      ),
      DetailItem(
        label: translate(
          context,
          widget.spotTypeEn,
          widget.spotTypeId,
          widget.spotTypeCn,
        ),
        value: "formatFloorLabel(parts[0])} (parts[1]})",
      ),
      DetailItem(
        label: translate(context, 'Duration', 'Durasi', '持续时间'),
        value: 'widget.parking.calculateHour()} hours',
      ),
      DetailItem(
        label: translate(context, 'Check-in Time', 'Waktu Masuk', '签到时间'),
        value: 'widget.parking.checkoutTime',
      ),

      DetailItem(
        label: translate(context, 'Check-out Time', 'Waktu Keluar', '签出时间'),
        value: 'widget.parking.checkinTime',
      ),
    ];

    final List<DetailItem> prices = [
      DetailItem(label: "Amount", value: 'widget.parking.amount ?? 0'),
      DetailItem(label: "Taxes (11%)", value: 'widget.parking.tax ?? 0'),
      DetailItem(label: "Service Fee", value: 'widget.parking.service ?? 0'),
      DetailItem(label: "Total", value: 'widget.parking.total ?? 0'),
    ];

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
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    DataCard(listData: bookInfo),
                    const SizedBox(height: 5),
                    DataCard(listData: prices),
                    const SizedBox(height: 20),
                    ResponsiveButton(
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
