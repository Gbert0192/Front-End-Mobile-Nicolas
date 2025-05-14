import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    final List<FAQItem> faqList = [
      FAQItem(
        title: '🚗 About Us',
        content: [
          'Park-ID is a smart parking app that lets you book a spot in advance or park right away. '
              'Pay only for the time you use — simple, fast, and reliable.',
        ],
      ),
      FAQItem(
        title: '🅿️ Parking & Booking',
        content: [
          '• You can book in advance or park on the spot (walk-in).',
          '• Always check slot availability in the parking area before coming.',
          '• Parking fees start from the time you enter, not the booked time.',
          '• You may arrive up to 30 minutes early, but we cannot guarantee availability before your booked time.',
          '',
          '🔸 Tip: We recommend arriving on time to avoid confusion.',
          '🔸 If you plan to come early, check availability on your booking QR page first.',
        ],
      ),
      FAQItem(
        title: '❌ Cancel & Expired Booking',
        content: [
          '• You can cancel up to 1 hour before your booking starts — no fee.',
          '• If you don’t check in within 30 minutes after your booking starts, it will expire automatically.',
          '• A no-show fee of 10,000 will be charged from your balance.',
          '• If your balance isn’t enough, it may go negative and you\'ll need to top up before your next booking.',
        ],
      ),
      FAQItem(
        title: '⭐ Become a Member',
        content: [
          'Subscribe to a Monthly, Seasonal, or Annual Plan and enjoy these benefits:',
          '',
          '✅ Current Member Benefits',
          '• No service fee',
          '• No-show fee waived',
          '• Extended early arrival time (up to 45 minutes before booking)',
          '• Extended late check-in window (up to 45 minutes late)',
          '• Shorter cancellation deadline (cancel up to 15 minutes before)',
          '',
          '🔜 Coming Soon for Members',
          '• Discounted hourly parking rates',
          '• Exclusive promos and offers',
          '',
          '🎁 Being a member gives you more flexibility, savings, and fewer penalties.',
        ],
      ),
      FAQItem(
        title: '💳 Top Up Balance',
        content: [
          '• Top up via bank transfer, e-wallet, or credit card.',
          '• Your balance is used for parking fees and no-show charges.',
          '• If your balance goes negative, top up is required to book again.',
        ],
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Static Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/others/FAQ.png",
              fit: BoxFit.cover,
              color: Colors.white.withOpacity(0.1),
              colorBlendMode: BlendMode.dstATop,
            ),
          ),

          CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                title: Text(
                  'FAQ',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: isSmall ? 25 : 30,
                  ),
                ),
                leading: Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    elevation: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(12),
                        elevation: 1,
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "(Frequently Asked Questions)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: isSmall ? 24 : 30,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        padding: EdgeInsets.only(bottom: 0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: faqList.length,
                        itemBuilder: (context, index) {
                          final item = faqList[index];
                          return Card(
                            margin: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: isSmall ? 6 : 16,
                            ),
                            elevation: 3,
                            color: const Color(0xFFF2F5FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: isSmall ? 2 : 8,
                              ),
                              childrenPadding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 5,
                              ),
                              title: Text(
                                item.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSmall ? 16 : 20,
                                ),
                              ),
                              // Remove divider color and behavior by overriding theme
                              backgroundColor: Colors.transparent,
                              collapsedBackgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide.none,
                              ),
                              collapsedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide.none,
                              ),
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isSmall ? 12 : 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(),
                                      ...item.content.map(
                                        (text) => Padding(
                                          padding: EdgeInsets.only(
                                            bottom: isSmall ? 4 : 8,
                                          ),
                                          child: Text(
                                            text,
                                            style: TextStyle(
                                              fontSize: isSmall ? 14 : 16,
                                              height: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Image.asset(
                          "assets/starting/toy car turn right blue.png",
                          width: isSmall ? 150 : 250,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FAQItem {
  final String title;
  final List<String> content;

  FAQItem({required this.title, required this.content});
}
