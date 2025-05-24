import 'package:flutter/material.dart';

class Notification_ extends StatelessWidget {
  const Notification_({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: isSmall ? 30 : 40,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F1E5B),
                  fontFamily: 'Poppins',
                ),
              ),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  //Today
                  NotifTitle(dateTitle: 'Today'),
                  NotifCard(
                    notifIcon: 'assets/images/icons/booking.png',
                    mall: 'Sun Plaza',
                    typeText: NotifTypes.bookSuccess,
                  ),
                  NotifCard(
                    notifIcon: 'assets/images/icons/cancel.png',
                    mall: 'Centre Point Mall',
                    typeText: NotifTypes.bookCancel,
                  ),

                  //Yesterday
                  NotifTitle(dateTitle: 'Yesterday'),
                  NotifCard(
                    notifIcon: 'assets/images/icons/payment.png',
                    mall: 'Thamrin Plaza',
                    typeText: NotifTypes.paySuccess,
                  ),
                  NotifCard(
                    notifIcon: 'assets/images/icons/exit.png',
                    mall: 'Thamrin Plaza',
                    typeText: NotifTypes.bookExit,
                  ),
                  NotifCard(
                    notifIcon: 'assets/images/icons/locked.png',
                    mall: '',
                    typeText: NotifTypes.verif2Step,
                  ),

                  //December 6, 2024
                  NotifTitle(dateTitle: 'December 6, 2024'),
                  NotifCard(
                    notifIcon: 'assets/images/icons/payment.png',
                    mall: 'Sun Plaza',
                    typeText: NotifTypes.paySuccess,
                  ),
                  NotifCard(
                    notifIcon: 'assets/images/icons/exit.png',
                    mall: 'Sun Plaza',
                    typeText: NotifTypes.bookExit,
                  ),

                  //November 28, 2024
                  NotifTitle(dateTitle: 'November 28, 2024'),
                  NotifCard(
                    notifIcon: 'assets/images/icons/payment.png',
                    mall: 'Medan Mall',
                    typeText: NotifTypes.paySuccess,
                  ),
                  NotifCard(
                    notifIcon: 'assets/images/icons/exit.png',
                    mall: 'Medan Mall',
                    typeText: NotifTypes.bookExit,
                  ),
                  NotifCard(
                    notifIcon: 'assets/images/icons/booking.png',
                    mall: 'Medan Mall',
                    typeText: NotifTypes.bookSuccess,
                  ),

                  //November 21, 2024
                  NotifTitle(dateTitle: 'November 21, 2024'),
                  NotifCard(
                    notifIcon: 'assets/images/icons/expired.png',
                    mall: '',
                    typeText: NotifTypes.bookExp,
                  ),
                  NotifCard(
                    notifIcon: 'assets/images/icons/booking.png',
                    mall: 'Medan Mall',
                    typeText: NotifTypes.bookSuccess,
                  ),

                  //November 18, 2024
                  NotifTitle(dateTitle: 'November 18, 2024'),
                  NotifCard(
                    notifIcon: 'assets/images/icons/verification.png',
                    mall: '',
                    typeText: NotifTypes.verif,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//ini gabung aja soalnya cuma dipake di satu page ini
class NotifTitle extends StatelessWidget {
  final String dateTitle;

  const NotifTitle({super.key, required this.dateTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Divider(color: Colors.grey, thickness: 1, indent: 5, endIndent: 5),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  dateTitle,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum NotifTypes {
  bookSuccess,
  bookCancel,
  bookExp,
  bookExit,
  verif,
  verif2Step,
  paySuccess,
}

class NotifCard extends StatelessWidget {
  final String notifIcon;
  final NotifTypes typeText;
  final String mall;

  const NotifCard({
    super.key,
    required this.notifIcon,
    this.typeText = NotifTypes.bookSuccess,
    required this.mall,
  });

  String _cardTitle(NotifTypes type) {
    switch (type) {
      case NotifTypes.bookSuccess:
        return 'Booking Successful!';
      case NotifTypes.bookCancel:
        return 'Parking Booking Canceled';
      case NotifTypes.bookExit:
        return 'Exit Parking Lot';
      case NotifTypes.bookExp:
        return 'Booking Has Been Expired!';
      case NotifTypes.paySuccess:
        return 'Payment Successful!';
      case NotifTypes.verif:
        return 'Verification Successful!';
      case NotifTypes.verif2Step:
        return '2 Step Verification Successful!';
    }
  }

  String _cardDescription(NotifTypes type) {
    switch (type) {
      case NotifTypes.bookSuccess:
        return 'Parking booking at ${mall} was successfully booked!';
      case NotifTypes.bookCancel:
        return 'You have canceled parking at ${mall}';
      case NotifTypes.bookExit:
        return 'You have exit parking lot at ${mall}';
      case NotifTypes.bookExp:
        return 'You missed your booking, no-show fee was charged.';
      case NotifTypes.paySuccess:
        return 'Parking booking at ${mall} was successfully paid';
      case NotifTypes.verif:
        return 'Account verification complete!';
      case NotifTypes.verif2Step:
        return 'Google Authenticator set successful!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(notifIcon, width: 50, height: 50),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _cardTitle(typeText),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _cardDescription(typeText),
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
