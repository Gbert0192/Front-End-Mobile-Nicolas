import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/model/voucher.dart';
import 'package:tugas_front_end_nicolas/provider/voucher_provider.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class VoucherCard extends StatelessWidget {
  final Voucher voucher;

  const VoucherCard({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: const Color.fromARGB(255, 217, 217, 217)),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voucher.voucherName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmall ? 16 : 18,
                    ),
                  ),
                  Text(
                    "${translate(context, "Valid at", "Berlaku di", "适用于")} ${voucher.lot.name}",
                    style: TextStyle(fontSize: isSmall ? 12 : 14),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E61),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      voucher.type == VoucherFlag.free
                          ? "Free"
                          : "Disc ${voucher.type == VoucherFlag.percent ? "${(voucher.nominal!.toInt())}%" : (formatCurrency(nominal: voucher.nominal!))}",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E61),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          voucher.maxUse == null
                              ? translate(
                                context,
                                "Unlimited",
                                "Tanpa Batas",
                                "无限制",
                              )
                              : translate(
                                context,
                                'Max Uses ${voucher.maxUse!.toString()}',
                                'Maks ${voucher.maxUse!.toString()} Kali',
                                '最多使用${voucher.maxUse!.toString()}次',
                              ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      if (voucher.minHour != null)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1E61),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            translate(
                              context,
                              "Min ${voucher.minHour} Hours",
                              "Min ${voucher.minHour} Jam",
                              "最少${voucher.minHour}小时",
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      translate(
                        context,
                        'Valid Until ${DateFormat.yMMMMd().format(voucher.validUntil)}',
                        'Berlaku Hingga ${DateFormat.yMMMMd().format(voucher.validUntil)}',
                        '有效期至${DateFormat.yMMMMd().format(voucher.validUntil)}',
                      ),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                voucher.lot.image,
                width: isSmall ? 100 : 120,
                height: isSmall ? 100 : 120,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    final voucherProvider = Provider.of<VoucherProvider>(context);
    List<Voucher> voucherList = voucherProvider.getAvailableVoucher();

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Colors.white,
          color: const Color(0xFF1F1E5B),
          onRefresh: () async {
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                voucherList = voucherProvider.getAvailableVoucher();
              });
            });
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text(
                  translate(
                    context,
                    'Available Voucher',
                    'Voucher Tersedia',
                    '可用优惠券',
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: isSmall ? 25 : 30,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children:
                        voucherList
                            .map((voucher) => VoucherCard(voucher: voucher))
                            .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
