import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/model/parking.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
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
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final historyProvider = Provider.of<HistoryProvider>(context);
    User user = userProvider.currentUser!;
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

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
                                padding: EdgeInsets.all(isSmall ? 5 : 10),
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
                  const SizedBox(height: 12),
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
    barrierColor: Colors.black.withValues(alpha: 0.5), // Background gelap
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => SafeArea(child: child),
    transitionBuilder: (_, animation, __, child) {
      final offsetAnimation = Tween<Offset>(
        begin: Offset(0, 1), // Mulai dari bawah
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
