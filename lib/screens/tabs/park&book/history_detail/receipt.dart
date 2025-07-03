import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/detail_component.dart';
import 'package:tugas_front_end_nicolas/components/history_card.dart';
import 'package:tugas_front_end_nicolas/model/booking.dart';
import 'package:tugas_front_end_nicolas/model/history.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/home/parking_lot/lot_detail.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/park&book/history_list.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';
import 'package:tugas_front_end_nicolas/model/parking.dart';

class Receipt extends StatefulWidget {
  final Parking history;
  final HistoryType type;

  const Receipt(this.history, this.type);

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  @override
  Widget build(BuildContext context) {
    final isBooking = widget.type == HistoryType.booking;
    final isMember = widget.history.isMember;
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    final List<DetailItem> historyInfo = [
      DetailItem(label: 'Parking Area', value: widget.history.lot.name),
      DetailItem(label: 'Address', value: widget.history.lot.address),
      DetailItem(
        label: "${isBooking ? "Booked" : "Parking"} Spot",
        value:
            "${formatFloorLabel(widget.history.floor)} (${widget.history.code})",
      ),
      DetailItem(
        label: 'Check-in Time',
        value: formatDateTime(widget.history.checkinTime!),
      ),
      DetailItem(
        label: 'Check-out Time',
        value: formatDateTime(widget.history.checkoutTime!),
        color: Colors.red,
      ),
      DetailItem(
        label: 'Duration',
        value:
            '${widget.history.hours} ${widget.history.hours == 1 ? 'hour' : 'hours'}',
      ),
      DetailItem(label: "Status", child: StatusDisplay(widget.history.status)),
    ];

    final List<DetailItem> prices = [
      DetailItem(
        label: 'Amount',
        value: formatCurrency(nominal: widget.history.amount!),
      ),
      if (widget.history.voucher != null)
        DetailItem(
          label: "Voucher",
          value: formatCurrency(nominal: widget.history.voucher!),
          color: Colors.red,
        ),
      DetailItem(
        label: 'Taxes (11%)',
        value: formatCurrency(nominal: widget.history.tax!),
      ),
      DetailItem(
        label: 'Service Fee',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (isMember!)
              DiscountDisplay(6500, 0)
            else
              Text(
                formatCurrency(nominal: 6500),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isSmall ? 13 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        bottomBorder: true,
      ),
      if (widget.history.unresolvedFee != null)
        DetailItem(
          label: "Unresolved Fee",
          value: formatCurrency(nominal: widget.history.unresolvedFee!),
          color: Colors.red,
        ),
      DetailItem(
        label: 'Total',
        value: formatCurrency(nominal: widget.history.total!),
      ),
    ];

    final List<DetailItem> cancelInfo = [
      DetailItem(label: 'Parking Area', value: widget.history.lot.name),
      DetailItem(label: 'Address', value: widget.history.lot.address),
      DetailItem(
        label: 'Booking Spot',
        value:
            "${formatFloorLabel(widget.history.floor)} (${widget.history.code})",
      ),
      DetailItem(
        label: 'Booking Time',
        value: formatDateTime((widget.history as Booking).bookingTime),
      ),
      DetailItem(
        label: 'Expired Time',
        value: formatDateTime(
          (widget.history as Booking).bookingTime.add(
            Duration(minutes: isMember ? 45 : 30),
          ),
        ),
        color: Colors.red,
      ),
      DetailItem(
        label: 'Cancel Date',
        value: formatDate(widget.history.cancelTime!),
        color: Colors.red,
      ),
    ];

    final List<DetailItem> expiredDetail = [
      DetailItem(
        label: 'Member Status',
        value: isMember ? 'Active' : 'Inactive',
      ),
      DetailItem(
        label: 'No-Show Fee',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (isMember)
              DiscountDisplay((widget.history as Booking).noshowFee!, 0)
            else
              Text(
                formatCurrency(nominal: (widget.history as Booking).noshowFee!),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isSmall ? 13 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
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
                '${isBooking ? "Booking" : "parking"} Receipt',
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
                    if (widget.history.status == HistoryStatus.cancel) ...[
                      DataCard(listData: cancelInfo),
                      const SizedBox(height: 20),
                    ] else if (widget.history.status ==
                        HistoryStatus.unresolved) ...[
                      DataCard(listData: cancelInfo),
                      const SizedBox(height: 5),
                      DataCard(listData: expiredDetail),
                      const SizedBox(height: 20),
                    ] else if (widget.history.status ==
                        HistoryStatus.exited) ...[
                      DataCard(listData: historyInfo),
                      const SizedBox(height: 5),
                      DataCard(listData: prices),
                      const SizedBox(height: 20),
                    ],

                    // button
                    ResponsiveButton(
                      text: 'View Parking Area',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    LotDetail(mall: widget.history.lot),
                          ),
                        );
                      },
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
