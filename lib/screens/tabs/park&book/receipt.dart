import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/detail_component.dart';
import 'package:tugas_front_end_nicolas/components/receipt.dart';
import 'package:tugas_front_end_nicolas/model/parking_lot.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class Receipt extends StatefulWidget {
  final ParkingLot mall;
  final String spotTypeEn;
  final String spotTypeId;
  final String spotTypeCn;
  final String? slot;

  const Receipt({
    super.key,
    required this.mall,
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
        value: widget.mall.name,
      ),
      DetailItem(
        label: translate(context, 'Address', 'Alamat', '地址'),
        value: widget.mall.address,
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
        value: widget.mall.address,
      ),
      DetailItem(
        label: translate(context, 'Address', 'Alamat', '地址'),
        value: widget.mall.address,
      ),
      DetailItem(
        label: translate(context, 'Address', 'Alamat', '地址'),
        value: widget.mall.address,
      ),
    ];

    final List<DetailItem> prices = [
      DetailItem(
        label: "Amount",
        value: "${formatFloorLabel(parts[0])} (${parts[1]})",
      ),
      DetailItem(
        label: "Booking Date",
        value: formatDate(stringToDate(widget.date!)),
      ),
      DetailItem(
        label: "Booking Date",
        value: formatDate(stringToDate(widget.date!)),
      ),
      DetailItem(
        label: "Total",
        value: formatCurrency(
          nominal: widget.mall.hourlyPrice,
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
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          DataCard(listData: bookInfo),
                          DataCard(listData: prices),

                          ReceiptText(
                            left: translate(
                              context,
                              widget.spotTypeEn,
                              widget.spotTypeId,
                              widget.spotTypeCn,
                            ),
                            right:
                                "${formatFloorLabel(parts[0])} (${parts[1]})",
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
                            right: '${widget.mall.hourlyPrice}',
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
                            right: 'totalPrice',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 70),
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
