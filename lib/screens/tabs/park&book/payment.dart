import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/components/detail_component.dart';
import 'package:tugas_front_end_nicolas/components/history_card.dart';
import 'package:tugas_front_end_nicolas/model/parking.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/model/voucher.dart';
import 'package:tugas_front_end_nicolas/provider/history_provider.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/home/topup/topup.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/park&book/history_list.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class PaymentDetail extends StatefulWidget {
  final Parking history;
  final HistoryType type;

  const PaymentDetail(this.history, this.type);

  @override
  State<PaymentDetail> createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  Voucher? voucher;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final historyProvider = Provider.of<HistoryProvider>(context);
    User user = userProvider.currentUser!;
    final isMember = user.checkStatusMember();
    final isBooking = widget.type == HistoryType.booking;
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    final hour = widget.history.calculateHour();
    final amount = widget.history.lot.calculateAmount(hour);
    final discount =
        voucher != null ? voucher!.calculateDiscount(amount, hour) : 0;
    final tax = amount * 0.11;
    final service = isMember ? 0 : 6500;

    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F8),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: const Color(0xFF1F1E5B),
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
          historyProvider.checkStatus(user, widget.history);
        },
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: isSmall ? 5 : 10,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: isSmall ? 25 : 30,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Booking Summary",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: isSmall ? 20 : 25,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(isSmall ? 12 : 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: isSmall ? 40 : 60,
                                  height: isSmall ? 40 : 60,
                                  decoration: BoxDecoration(
                                    color: Colors.indigoAccent.withValues(
                                      alpha: 0.2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/icons/wallet.png',
                                  width: isSmall ? 20 : 30,
                                ),
                              ],
                            ),
                            SizedBox(width: isSmall ? 10 : 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  translate(context, "Balance", "Saldo", "平衡"),
                                  style: TextStyle(
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.3,
                                        ),
                                        blurRadius: 3,
                                        offset: const Offset(2, 2),
                                      ),
                                    ],
                                    color: Color(0xFF0F1654),
                                    fontSize: isSmall ? 16 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  formatCurrency(nominal: user.balance),
                                  style: TextStyle(
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.3,
                                        ),
                                        blurRadius: 3,
                                        offset: const Offset(2, 2),
                                      ),
                                    ],
                                    overflow: TextOverflow.ellipsis,
                                    color: Color(0xFF566FC6),
                                    fontSize: isSmall ? 16 : 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TopUpPage(),
                                ),
                              ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Color(0xFF98A5FD),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.2,
                                      ),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white.withValues(alpha: 0.6),
                                  size: isSmall ? 24 : 30,
                                ),
                              ),
                              Text(
                                "Top Up",
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: isSmall ? 12 : 14,
                                  fontWeight: FontWeight.w600,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 3,
                                      offset: const Offset(0, 1),
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
                  SizedBox(height: isSmall ? 10 : 20),
                  DataCard(
                    listData: [
                      DetailItem(
                        label: "Parking Area",
                        value: widget.history.lot.name,
                      ),
                      DetailItem(
                        label: "Address",
                        value: widget.history.lot.address,
                      ),
                      DetailItem(
                        label: "${isBooking ? "Booked" : "Parking"} Spot",
                        value:
                            '${formatFloorLabel(widget.history.floor)} (${widget.history.code})',
                      ),
                      DetailItem(
                        label: "Check-in Time",
                        value: formatDateTime(widget.history.checkinTime!),
                      ),
                      DetailItem(
                        label: "Current Duration",
                        value: "hour ${hour == 1 ? 'hour' : 'hours'}",
                      ),
                      DetailItem(
                        label: "Current Status",
                        child: StatusDisplay(widget.history.status),
                      ),
                    ],
                  ),
                  SizedBox(height: isSmall ? 10 : 20),
                  DataCard(
                    listInput: [
                      DetailItem(
                        label: "Voucher",
                        child: VoucherDisplay(
                          selectedVoucher: voucher,
                          onVoucherSelect: (val) {
                            setState(() {
                              voucher = val;
                            });
                          },
                          onVoucherRemove: () {
                            setState(() {
                              voucher = null;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isSmall ? 10 : 20),
                  DataCard(
                    listData: [
                      DetailItem(
                        label: "Amount",
                        value: formatCurrency(nominal: amount),
                      ),
                      if (voucher != null)
                        DetailItem(
                          label: "Voucher",
                          value: formatCurrency(nominal: discount),
                          color: Colors.red,
                        ),
                      DetailItem(
                        label: "Taxes (11%)",
                        value: formatCurrency(nominal: tax),
                      ),
                      DetailItem(
                        label: "Service Fee",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (isMember)
                              Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Text(
                                        formatCurrency(nominal: 6500),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: isSmall ? 13 : 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: CustomPaint(
                                          painter: StrikeThroughPainter(
                                            color: Colors.red,
                                            strokeWidth: 2.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    formatCurrency(nominal: 0),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: isSmall ? 13 : 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
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
                      DetailItem(
                        label: "Total",
                        value: formatCurrency(
                          nominal: amount + tax + service - discount,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showFullscreenDialog(BuildContext context, Widget child) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Dismiss",
    barrierColor: Colors.black.withValues(alpha: 0.5),
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => SafeArea(child: child),
    transitionBuilder: (_, animation, __, child) {
      final offsetAnimation = Tween<Offset>(
        begin: Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

class VoucherDisplay extends StatelessWidget {
  const VoucherDisplay({
    super.key,
    required this.onVoucherSelect,
    this.selectedVoucher,
    this.onVoucherRemove,
  });

  final Function(Voucher) onVoucherSelect;
  final Voucher? selectedVoucher;
  final VoidCallback? onVoucherRemove;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (selectedVoucher == null) {
          // Buka dialog pilih voucher di sini
          // Contoh pemanggilan:
          // onVoucherSelect(Voucher(...));
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset("assets/images/others/voucher_plat.png"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Voucher name or placeholder
                Expanded(
                  child: Text(
                    selectedVoucher?.voucherName ?? "Choose a voucher",
                    style: TextStyle(
                      color:
                          selectedVoucher != null ? Colors.black : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Action button
                if (selectedVoucher == null)
                  TextButton(
                    onPressed: () {
                      // Misal buka dialog pilih voucher
                      // atau panggil callback
                      // onVoucherSelect(...)
                    },
                    child: const Text(
                      "Choose",
                      style: TextStyle(
                        color: Color(0xFF6487EE),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                else
                  TextButton(
                    onPressed: onVoucherRemove,
                    child: const Text(
                      "Remove",
                      style: TextStyle(
                        color: Color(0xFF6487EE),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
