import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/model/booking.dart';
import 'package:tugas_front_end_nicolas/model/history.dart';
import 'package:tugas_front_end_nicolas/model/parking.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/provider/history_provider.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
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
    final userProvider = Provider.of<UserProvider>(context);
    User user = userProvider.currentUser!;
    return Consumer<HistoryProvider>(
      builder: (context, provider, _) {
        final updatedHistory =
            provider.getHistoryDetail(user, widget.history.id)!;

        switch (updatedHistory.status) {
          case HistoryStatus.exited:
          case HistoryStatus.cancel:
          case HistoryStatus.expired:
            return Receipt(updatedHistory, widget.type);

          case HistoryStatus.entered:
          case HistoryStatus.unresolved:
            return PaymentQr(updatedHistory, widget.type);

          case HistoryStatus.pending:
          case HistoryStatus.fixed:
            return ClaimQr(updatedHistory as Booking, widget.type);
        }
      },
    );
  }
}
