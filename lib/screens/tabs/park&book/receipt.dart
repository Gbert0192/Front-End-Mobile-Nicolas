import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/detail_component.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';
import 'package:tugas_front_end_nicolas/model/parking.dart';

class Receipt extends StatefulWidget {
  final Parking parking;
  final String spotTypeEn;
  final String spotTypeId;
  final String spotTypeCn;
  final String? slot;

  const Receipt({
    super.key,
    required this.parking,
    required this.spotTypeEn,
    required this.spotTypeId,
    required this.spotTypeCn,
    required this.slot,
  });

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  @override
  Widget build(BuildContext context) {
    final parts = widget.slot!.split("-");
    final List<DetailItem> bookInfo = [
      DetailItem(
        label: translate(context, 'Parking Area', 'Area Parkir', '停车场'),
        value: widget.parking.lot.name,
      ),
      DetailItem(
        label: translate(context, 'Address', 'Alamat', '地址'),
        value: widget.parking.lot.address,
      ),
      DetailItem(
        label: translate(
          context,
          widget.spotTypeEn,
          widget.spotTypeId,
          widget.spotTypeCn,
        ),
        value: "${formatFloorLabel(parts[0])} (${parts[1]})",
      ),
      DetailItem(
        label: translate(context, 'Duration', 'Durasi', '持续时间'),
        value: '${widget.parking.calculateHour()} hours',
      ),
      DetailItem(
        label: translate(context, 'Check-in Time', 'Waktu Masuk', '签到时间'),
        value:
            widget.parking.checkoutTime != null
                ? formatDateTime(widget.parking.checkoutTime!)
                : '-',
      ),

      DetailItem(
        label: translate(context, 'Check-out Time', 'Waktu Keluar', '签出时间'),
        value:
            widget.parking.checkinTime != null
                ? formatDateTime(widget.parking.checkinTime!)
                : '-',
      ),
    ];

    final List<DetailItem> prices = [
      DetailItem(
        label: "Amount",
        value: formatCurrency(
          nominal: widget.parking.amount ?? 0,
          decimalPlace: 0,
        ),
      ),
      DetailItem(
        label: "Taxes (11%)",
        value: formatCurrency(
          nominal: widget.parking.tax ?? 0,
          decimalPlace: 0,
        ),
      ),
      DetailItem(
        label: "Service Fee",
        value: formatCurrency(
          nominal: widget.parking.service ?? 0,
          decimalPlace: 0,
        ),
      ),
      DetailItem(
        label: "Total",
        value: formatCurrency(
          nominal: widget.parking.total ?? 0,
          decimalPlace: 0,
        ),
      ),
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
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    DataCard(listData: bookInfo),
                    const SizedBox(height: 20),
                    DataCard(listData: prices),

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
