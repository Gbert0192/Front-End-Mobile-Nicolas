import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/model/booking.dart';
import 'package:tugas_front_end_nicolas/model/history.dart';
import 'package:tugas_front_end_nicolas/model/parking.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/park&book/history_detail/claim_qr.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/park&book/history_detail/payment_qr.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/park&book/history_detail/receipt.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/park&book/history_list.dart';

class HistoryDetail extends StatefulWidget {
  final Parking history;
  final HistoryType type;

  const HistoryDetail(this.history, this.type);

  @override
  State<HistoryDetail> createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  @override
  Widget build(BuildContext context) {
    switch (widget.history.status) {
      case HistoryStatus.exited:
      case HistoryStatus.cancel:
      case HistoryStatus.expired:
        return Receipt(widget.history, widget.type);

      case HistoryStatus.entered:
      case HistoryStatus.unresolved:
        return PaymentQr(widget.history, widget.type);

      case HistoryStatus.pending:
      case HistoryStatus.fixed:
        return ClaimQr(widget.history as Booking, widget.type);
    }
  }
}
