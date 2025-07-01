import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/detail_component.dart';
import 'package:tugas_front_end_nicolas/model/history.dart';
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
        label: translate(context, 'Amount', 'Jumlah', '金额'),
        value: formatCurrency(
          nominal: widget.parking.amount ?? 0,
          decimalPlace: 0,
        ),
      ),
      DetailItem(
        label: translate(context, 'Taxes (11%)', 'Pajak (11%)', '税费 (11%)'),
        value: formatCurrency(
          nominal: widget.parking.tax ?? 0,
          decimalPlace: 0,
        ),
      ),
      DetailItem(
        label: translate(context, 'Service Fee', 'Biaya Layanan', '服务费'),
        value: formatCurrency(
          nominal: widget.parking.service ?? 0,
          decimalPlace: 0,
        ),
      ),
      DetailItem(
        label: translate(context, 'Total', 'Total', '总计'),
        value: formatCurrency(
          nominal: widget.parking.total ?? 0,
          decimalPlace: 0,
        ),
      ),
    ];

    final List<DetailItem> cancelInfo = [
      DetailItem(
        label: translate(context, 'Parking Area', 'Area Parkir', '停车场'),
        value: widget.parking.lot.name,
      ),
      DetailItem(
        label: translate(context, 'Address', 'Alamat', '地址'),
        value: widget.parking.lot.address,
      ),
      DetailItem(
        label: translate(context, 'Booking Spot', 'Pesan Tempat', '预订车位'),
        value: "${formatFloorLabel(parts[0])} (${parts[1]})",
      ),
      DetailItem(
        label: translate(context, 'Booking Time', 'Waktu Pemesanan', '预订时间'),
        value:
            widget.parking.checkinTime != null
                ? formatDateTime(widget.parking.checkinTime!)
                : '-',
      ),

      DetailItem(
        label: translate(context, 'Expired Time', 'Waktu Kedaluwarsa', '过期时间'),
        value:
            widget.parking.checkoutTime != null
                ? formatDateTime(widget.parking.checkoutTime!)
                : '-',
      ),
    ];

    final List<DetailItem> cancelDetail = [
      DetailItem(
        label: translate(context, 'Booking Status', 'Status Pemesanan', '预订状态'),
        value: widget.parking.status.toString(),
      ),
      DetailItem(
        label: translate(context, 'Cancel Date', 'Tanggal Pembatalan', '取消日期'),
        value:
            widget.parking.checkinTime != null
                ? formatDate(widget.parking.cancelTime!)
                : '-',
      ),
      DetailItem(
        label: translate(context, 'Cancel Hour', 'Waktu Pembatalan', '取消时间'),
        value:
            widget.parking.checkinTime != null
                ? formatTime(widget.parking.cancelTime!)
                : '-',
      ),
    ];

    final List<DetailItem> expiredDetail = [
      DetailItem(
        label: translate(context, 'Booking Status', 'Status Pemesanan', '预订状态'),
        value: widget.parking.status.toString(),
      ),
      DetailItem(
        label: translate(context, 'Member Status', 'Status Member', '会员状态'),
        value:
            widget.parking.user.isMember
                ? translate(context, 'Active', 'Aktif', '活跃')
                : translate(context, 'Inactive', 'Tidak Aktif', '不活跃'),
      ),
      DetailItem(
        label: translate(context, 'No-Show Fee', 'Denda Tidak Hadir', '未到场费用'),
        value: formatCurrency(
          nominal: widget.parking.unresolvedFee ?? 0,
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
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    if (widget.parking.status == HistoryStatus.cancel) ...[
                      DataCard(listData: cancelInfo),
                      const SizedBox(height: 5),
                      DataCard(listData: cancelDetail),
                      const SizedBox(height: 20),
                    ] else if (widget.parking.status ==
                        HistoryStatus.unresolved) ...[
                      DataCard(listData: cancelInfo),
                      const SizedBox(height: 5),
                      DataCard(listData: expiredDetail),
                      const SizedBox(height: 20),
                    ] else if (widget.parking.status ==
                        HistoryStatus.exited) ...[
                      DataCard(listData: bookInfo),
                      const SizedBox(height: 5),
                      DataCard(listData: prices),
                      const SizedBox(height: 20),
                    ],

                    // button
                    ResponsiveButton(
                      text: translate(
                        context,
                        'View Parking Area',
                        'Lihat Area Parkir',
                        '查看停车场',
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
