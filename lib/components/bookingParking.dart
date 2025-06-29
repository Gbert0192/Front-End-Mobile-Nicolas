import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/model/history.dart';
import 'package:tugas_front_end_nicolas/model/parking.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/park&book/history_list.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/park&book/payment_qr.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class HistoryCard extends StatelessWidget {
  final Parking history;
  final HistoryType type;

  const HistoryCard(this.history, this.type);

  String _getStatusText(HistoryStatus status) {
    switch (status) {
      case HistoryStatus.pending:
      case HistoryStatus.fixed:
        return "Booking Succeed";
      case HistoryStatus.entered:
      case HistoryStatus.unresolved:
        return "Currently Parking";
      case HistoryStatus.exited:
        return "Parking Completed";
      case HistoryStatus.cancel:
        return "Booking Canceled";
      case HistoryStatus.expired:
        return "Booking Expired";
    }
  }

  IconData _getStatusIcon(HistoryStatus status) {
    switch (status) {
      case HistoryStatus.pending:
      case HistoryStatus.fixed:
        return Icons.check_circle_outline;
      case HistoryStatus.entered:
      case HistoryStatus.unresolved:
        return Icons.local_parking_outlined;
      case HistoryStatus.exited:
        return Icons.exit_to_app;
      case HistoryStatus.cancel:
        return Icons.cancel_outlined;
      case HistoryStatus.expired:
        return Icons.schedule;
    }
  }

  Color _getStatusColor(HistoryStatus status) {
    switch (status) {
      case HistoryStatus.pending:
      case HistoryStatus.fixed:
        return const Color(0xFF4CAF50);
      case HistoryStatus.entered:
      case HistoryStatus.unresolved:
        return const Color(0xFF2196F3);
      case HistoryStatus.exited:
        return const Color(0xFF9C27B0);
      case HistoryStatus.cancel:
        return const Color(0xFFF44336);
      case HistoryStatus.expired:
        return const Color(0xFFFF9800);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => PaymentQr(
                        history: history,
                        type: HistoryType.parking,
                      ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        history.lot.image,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Content section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Place name and date row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                history.lot.name,
                                style: TextStyle(
                                  fontSize: isSmall ? 16 : 18,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1A1A1A),
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                            Text(
                              formatDateTimeLabel(context, history.createdAt),
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color(0xFF6B7280),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        // Price section (right aligned)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "${formatCurrency(nominal: history.lot.hourlyPrice)}/h",
                              style: TextStyle(
                                fontSize: isSmall ? 14 : 16,
                                color: const Color(0xFF374151),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),

                        // Status with icon (bottom)
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(
                              history.status,
                            ).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getStatusIcon(history.status),
                                color: _getStatusColor(history.status),
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _getStatusText(history.status),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getStatusColor(history.status),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
