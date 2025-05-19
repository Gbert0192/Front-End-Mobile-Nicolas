import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/notif/notif_title.dart';
import 'package:tugas_front_end_nicolas/components/notif/notification.dart';

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
                    notifIcon: 'assets/icons/booking.png',
                    mall: 'Sun Plaza',
                    typeText: NotifTypes.bookSuccess,
                  ),
                  NotifCard(
                    notifIcon: 'assets/icons/cancel.png',
                    mall: 'Centre Point Mall',
                    typeText: NotifTypes.bookCancel,
                  ),

                  //Yesterday
                  NotifTitle(dateTitle: 'Yesterday'),
                  NotifCard(
                    notifIcon: 'assets/icons/payment.png',
                    mall: 'Thamrin Plaza',
                    typeText: NotifTypes.paySuccess,
                  ),
                  NotifCard(
                    notifIcon: 'assets/icons/exit.png',
                    mall: 'Thamrin Plaza',
                    typeText: NotifTypes.bookExit,
                  ),
                  NotifCard(
                    notifIcon: 'assets/icons/locked.png',
                    mall: '',
                    typeText: NotifTypes.verif2Step,
                  ),

                  //December 6, 2024
                  NotifTitle(dateTitle: 'December 6, 2024'),
                  NotifCard(
                    notifIcon: 'assets/icons/payment.png',
                    mall: 'Sun Plaza',
                    typeText: NotifTypes.paySuccess,
                  ),
                  NotifCard(
                    notifIcon: 'assets/icons/exit.png',
                    mall: 'Sun Plaza',
                    typeText: NotifTypes.bookExit,
                  ),

                  //November 28, 2024
                  NotifTitle(dateTitle: 'November 28, 2024'),
                  NotifCard(
                    notifIcon: 'assets/icons/payment.png',
                    mall: 'Medan Mall',
                    typeText: NotifTypes.paySuccess,
                  ),
                  NotifCard(
                    notifIcon: 'assets/icons/exit.png',
                    mall: 'Medan Mall',
                    typeText: NotifTypes.bookExit,
                  ),
                  NotifCard(
                    notifIcon: 'assets/icons/booking.png',
                    mall: 'Medan Mall',
                    typeText: NotifTypes.bookSuccess,
                  ),

                  //November 21, 2024
                  NotifTitle(dateTitle: 'November 21, 2024'),
                  NotifCard(
                    notifIcon: 'assets/icons/expired.png',
                    mall: '',
                    typeText: NotifTypes.bookExp,
                  ),
                  NotifCard(
                    notifIcon: 'assets/icons/booking.png',
                    mall: 'Medan Mall',
                    typeText: NotifTypes.bookSuccess,
                  ),

                  //November 18, 2024
                  NotifTitle(dateTitle: 'November 18, 2024'),
                  NotifCard(
                    notifIcon: 'assets/icons/verification.png',
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
