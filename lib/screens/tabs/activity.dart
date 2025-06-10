import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tugas_front_end_nicolas/provider/activity_provider.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class ActivityItem {
  final ActivityTypes typeText;
  final String? mall;
  final String? method;
  final double? nominal;
  final DateTime date;

  ActivityItem({
    required this.typeText,
    this.mall,
    this.method,
    this.nominal,
    required this.date,
  });
}

class Activity extends StatelessWidget {
  const Activity({super.key});

  List<ActivityItem> _getActivities() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    return [
      // Today's notifications
      ActivityItem(
        mall: 'Medan Mall',
        typeText: ActivityTypes.unresolved,
        date: today.add(Duration(hours: 11, minutes: 2)),
      ),
      ActivityItem(
        mall: 'Sun Plaza',
        typeText: ActivityTypes.bookSuccess,
        date: today.add(Duration(hours: 11, minutes: 2)),
      ),
      ActivityItem(
        mall: 'Centre Point Mall',
        typeText: ActivityTypes.bookCancel,
        date: today.add(Duration(hours: 10, minutes: 15)),
      ),

      // Yesterday's notifications
      ActivityItem(
        mall: 'Thamrin Plaza',
        typeText: ActivityTypes.paySuccess,
        date: yesterday.add(Duration(hours: 16, minutes: 45)),
      ),
      ActivityItem(
        mall: 'Thamrin Plaza',
        typeText: ActivityTypes.exitLot,
        date: yesterday.add(Duration(hours: 15, minutes: 20)),
      ),
      ActivityItem(
        typeText: ActivityTypes.verify,
        date: yesterday.add(Duration(hours: 9, minutes: 30)),
      ),

      // May 27, 2025
      ActivityItem(
        mall: 'Sun Plaza',
        typeText: ActivityTypes.paySuccess,
        date: DateTime(2025, 5, 27, 13, 25),
      ),
      ActivityItem(
        mall: 'Sun Plaza',
        typeText: ActivityTypes.exitLot,
        date: DateTime(2025, 5, 25, 13, 20),
      ),
      ActivityItem(
        mall: 'Sun Plaza',
        typeText: ActivityTypes.enterLot,
        date: DateTime(2025, 5, 25, 13, 20),
      ),

      // May 24, 2025
      ActivityItem(
        mall: 'Medan Mall',
        typeText: ActivityTypes.paySuccess,
        date: DateTime(2025, 5, 6, 13, 40),
      ),
      ActivityItem(
        mall: 'Medan Mall',
        typeText: ActivityTypes.exitLot,
        date: DateTime(2025, 5, 6, 13, 25),
      ),
      ActivityItem(
        mall: 'Medan Mall',
        typeText: ActivityTypes.bookSuccess,
        date: DateTime(2025, 4, 24, 13, 25),
      ),

      // May 6, 2025
      ActivityItem(
        typeText: ActivityTypes.bookExp,
        date: DateTime(2025, 4, 16, 13, 25),
      ),
      ActivityItem(
        mall: 'Medan Mall',
        typeText: ActivityTypes.bookSuccess,
        date: DateTime(2025, 4, 13, 16, 25),
      ),
      ActivityItem(
        nominal: 1000000,
        method: "CIMB",
        typeText: ActivityTypes.topUp,
        date: DateTime(2025, 4, 13, 11, 25),
      ),
    ];
  }

  String _getDateGroup(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return "Today";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "This Week";
    } else if (difference.inDays < 30) {
      return "This Month";
    } else {
      return "Earlier";
    }
  }

  String _getTranslatedDateGroup(BuildContext context, DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return translate(context, "Today", "Hari Ini", "今天");
    } else if (difference.inDays == 1) {
      return translate(context, "Yesterday", "Kemarin", "昨天");
    } else if (difference.inDays < 7) {
      return translate(context, "This Week", "Minggu Ini", "本周");
    } else if (difference.inDays < 30) {
      return translate(context, "This Month", "Bulan Ini", "本月");
    } else {
      return translate(context, "Earlier", "Sebelumnya", "更早");
    }
  }

  Map<String, List<ActivityItem>> _groupActivitiesByDate(
    List<ActivityItem> notifications,
  ) {
    Map<String, List<ActivityItem>> grouped = {};

    for (var notification in notifications) {
      String dateKey = _getDateGroup(notification.date);

      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(notification);
    }

    // Sort notifications within each group by time (newest first)
    grouped.forEach((key, notifications) {
      notifications.sort((a, b) => b.date.compareTo(a.date));
    });

    return grouped;
  }

  List<String> _getSortedDateKeys(Map<String, List<ActivityItem>> grouped) {
    List<String> keys = grouped.keys.toList();

    // Define the order of date groups
    const groupOrder = [
      "Today",
      "Yesterday",
      "This Week",
      "This Month",
      "Earlier",
    ];

    keys.sort((a, b) {
      int indexA = groupOrder.indexOf(a);
      int indexB = groupOrder.indexOf(b);

      if (indexA == -1) indexA = groupOrder.length;
      if (indexB == -1) indexB = groupOrder.length;

      return indexA.compareTo(indexB);
    });

    return keys;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    final notifications = _getActivities();
    final groupedNotifications = _groupActivitiesByDate(notifications);
    final sortedDateKeys = _getSortedDateKeys(groupedNotifications);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Text(
                translate(context, 'Activities', 'Aktivitas', '活动'),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: isSmall ? 25 : 30,
                ),
              ),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  for (String dateKey in sortedDateKeys) ...[
                    NotifTitle(
                      dateTitle: _getTranslatedDateGroup(
                        context,
                        groupedNotifications[dateKey]!.first.date,
                      ),
                    ),
                    ...groupedNotifications[dateKey]!
                        .map(
                          (notification) =>
                              ActivityCard(notification: notification),
                        )
                        .toList(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotifTitle extends StatelessWidget {
  final String dateTitle;

  const NotifTitle({super.key, required this.dateTitle});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Divider(
            color: const Color.fromARGB(255, 214, 214, 214),
            thickness: 1,
            indent: 5,
          ),
          SizedBox(height: isSmall ? 5 : 10),
          Row(
            children: [
              SizedBox(width: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  dateTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isSmall ? 16 : 20,
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

class ActivityCard extends StatelessWidget {
  final ActivityItem notification;

  const ActivityCard({super.key, required this.notification});

  String _getActivityIcon(ActivityTypes type) {
    switch (type) {
      case ActivityTypes.bookSuccess:
        return 'assets/images/icons/booking.png';
      case ActivityTypes.bookCancel:
        return 'assets/images/icons/cancel.png';
      case ActivityTypes.exitLot:
        return 'assets/images/icons/exit.png';
      case ActivityTypes.enterLot:
        return 'assets/images/icons/enter.png';
      case ActivityTypes.bookExp:
        return 'assets/images/icons/expired.png';
      case ActivityTypes.paySuccess:
        return 'assets/images/icons/payment.png';
      case ActivityTypes.verify:
        return 'assets/images/icons/verification.png';
      // case ActivityTypes.twoFactor:
      //   return 'assets/images/icons/locked.png';
      case ActivityTypes.topUp:
        return 'assets/images/icons/topup.png';
      case ActivityTypes.unresolved:
        return 'assets/images/icons/unresolved.png';
    }
  }

  String _cardTitle(BuildContext context, ActivityTypes type) {
    switch (type) {
      case ActivityTypes.bookSuccess:
        return translate(
          context,
          'Booking Successful!',
          'Pemesanan Berhasil!',
          '预订成功！',
        );
      case ActivityTypes.bookCancel:
        return translate(
          context,
          'Booking Booking Canceled',
          'Pemesanan Parkir Dibatalkan',
          '停车预订已取消',
        );
      case ActivityTypes.exitLot:
        return translate(
          context,
          'Exit Parking Lot',
          'Keluar Area Parkir',
          '离开停车场',
        );
      case ActivityTypes.enterLot:
        return translate(
          context,
          'Enter Parking Lot',
          'Masuk Area Parkir',
          '进入停车场',
        );
      case ActivityTypes.bookExp:
        return translate(
          context,
          'Booking Has Been Expired!',
          'Pemesanan Telah Kedaluwarsa!',
          '预订已过期！',
        );
      case ActivityTypes.paySuccess:
        return translate(
          context,
          'Payment Successful!',
          'Pembayaran Berhasil!',
          '付款成功！',
        );
      case ActivityTypes.verify:
        return translate(
          context,
          '2FA Now Set Up!',
          '2FA Terpasang!',
          '2FA 现已设置!',
        );
      // case ActivityTypes.twoFactor:
      //   return translate(
      //     context,
      //     'Protect your account with 2FA.',
      //     'Lindungi akun Anda dengan 2FA.',
      //     '使用 2FA 保护您的账户。',
      //   );
      case ActivityTypes.topUp:
        return translate(
          context,
          'Top Up Successful',
          'Top Up Berhasil',
          '充值成功！',
        );
      case ActivityTypes.unresolved:
        return translate(
          context,
          'Unresolved Parking!',
          'Parkir Tak Selesai!',
          '未解决的停车问题！',
        );
    }
  }

  String _cardDescription(BuildContext context, ActivityTypes type) {
    switch (type) {
      case ActivityTypes.bookSuccess:
        return translate(
          context,
          'Parking booking at ${notification.mall} was successfully booked!',
          'Pemesanan parkir di ${notification.mall} berhasil dipesan!',
          '在 ${notification.mall} 的停车预订已成功预订！',
        );
      case ActivityTypes.bookCancel:
        return translate(
          context,
          'You have canceled booking at ${notification.mall}',
          'Anda telah membatalkan parkir di ${notification.mall}',
          '您已取消在 ${notification.mall} 的停车',
        );
      case ActivityTypes.exitLot:
        return translate(
          context,
          'You have exited parking lot at ${notification.mall}',
          'Anda telah keluar dari area parkir di ${notification.mall}',
          '您已离开 ${notification.mall} 的停车场',
        );
      case ActivityTypes.enterLot:
        return translate(
          context,
          'You have entered parking lot at ${notification.mall}',
          'Anda telah masuk dari area parkir di ${notification.mall}',
          '您已从 ${notification.mall} 的停车场进入',
        );
      case ActivityTypes.bookExp:
        return translate(
          context,
          'You missed your booking, no-show fee was charged.',
          'Anda melewatkan pemesanan, denda akan dikenakan.',
          '您错过了预订，已收取缺席费用。',
        );
      case ActivityTypes.paySuccess:
        return translate(
          context,
          'Parking booking at ${notification.mall} was successfully paid',
          'Pemesanan parkir di ${notification.mall} berhasil dibayar',
          '在 ${notification.mall} 的停车预订已成功付款',
        );
      case ActivityTypes.verify:
        return translate(
          context,
          'Two Factor Authenticator set up successful!',
          'Autentikator Dua Faktor berhasil terpasang!',
          '双重身份验证器设置成功!',
        );
      // case ActivityTypes.twoFactor:
      //   return translate(
      //     context,
      //     'Account will be more secured with 2FA setup!',
      //     'Akun akan lebih aman dengan 2FA terpasang!',
      //     '设置 2FA 后帐户将更加安全!',
      //   );
      case ActivityTypes.topUp:
        return translate(
          context,
          'You have successfully topped up ${formatCurrency(nominal: notification.nominal as num)} via ${notification.method}.',
          'Kamu berhasil melakukan top up sebesar ${formatCurrency(nominal: notification.nominal as num)} melalui ${notification.method}.',
          '您已成功通过 ${notification.method} 充值 ${formatCurrency(nominal: notification.nominal as num)}。',
        );
      case ActivityTypes.unresolved:
        return translate(
          context,
          'Your parking at ${notification.mall} has exceeded 20 hour',
          'Parkir Anda di ${notification.mall} telah melebihi 20 jam',
          '您在 ${notification.mall} 的停车时间已超过20小时',
        );
    }
  }

  String _formatDateTime(BuildContext context, DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return translate(context, "Just now", "Baru saja", "刚刚");
        }
        return "${difference.inMinutes}${translate(context, "m ago", "m lalu", "分钟前")}";
      }
      return "${difference.inHours}${translate(context, "h ago", "j lalu", "小时前")}";
    } else if (difference.inDays == 1) {
      return translate(context, "Yesterday", "Kemarin", "昨天");
    } else if (difference.inDays < 7) {
      return "${difference.inDays}${translate(context, "d ago", "h lalu", "天前")}";
    } else {
      return DateFormat("dd MMM yyyy").format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isSmall ? 15 : 20,
        vertical: isSmall ? 8 : 12,
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(color: const Color.fromARGB(255, 221, 221, 221)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(64),
            blurRadius: 5,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Image.asset(
          _getActivityIcon(notification.typeText),
          width: isSmall ? 35 : 50,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                _cardTitle(context, notification.typeText),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isSmall ? 14 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              _formatDateTime(context, notification.date),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: isSmall ? 10 : 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        subtitle: Text(
          _cardDescription(context, notification.typeText),
          style: TextStyle(color: Colors.grey, fontSize: isSmall ? 12 : 14),
        ),
      ),
    );
  }
}
