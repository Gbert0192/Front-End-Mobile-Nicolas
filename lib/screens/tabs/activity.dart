import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/provider/activity_provider.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';

class Activity extends StatelessWidget {
  const Activity({super.key});

  String _getDateGroup(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (date == today) {
      return "Today";
    } else if (date == today.subtract(Duration(days: 1))) {
      return "Yesterday";
    } else if (date.isAfter(today.subtract(Duration(days: now.weekday - 1)))) {
      return "This Week";
    } else if (date.month == now.month && date.year == now.year) {
      return "This Month";
    } else {
      return "Earlier";
    }
  }

  String _getTranslatedDateGroup(BuildContext context, DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (date == today) {
      return translate(context, "Today", "Hari Ini", "今天");
    } else if (date == today.subtract(Duration(days: 1))) {
      return translate(context, "Yesterday", "Kemarin", "昨天");
    } else if (date.isAfter(today.subtract(Duration(days: now.weekday - 1)))) {
      return translate(context, "This Week", "Minggu Ini", "本周");
    } else if (date.month == now.month && date.year == now.year) {
      return translate(context, "This Month", "Bulan Ini", "本月");
    } else {
      return translate(context, "Earlier", "Sebelumnya", "更早");
    }
  }

  Map<String, List<ActivityItem>> _groupActivitiesByDate(
    List<ActivityItem> activitys,
  ) {
    Map<String, List<ActivityItem>> grouped = {};

    for (var activity in activitys) {
      String dateKey = _getDateGroup(activity.date);

      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(activity);
    }

    // Sort activitys within each group by time (newest first)
    grouped.forEach((key, activitys) {
      activitys.sort((a, b) => b.date.compareTo(a.date));
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
    final userProvider = Provider.of<UserProvider>(context);
    User user = userProvider.currentUser!;
    final activityProvider = Provider.of<ActivityProvider>(context);

    final activities = activityProvider.getActivity(user);
    final groupedactivitys = _groupActivitiesByDate(activities?.activity ?? []);
    final sortedDateKeys = _getSortedDateKeys(groupedactivitys);

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
                children:
                    activities != null && activities.activity.isNotEmpty
                        ? [
                          for (String dateKey in sortedDateKeys) ...[
                            NotifTitle(
                              dateTitle: _getTranslatedDateGroup(
                                context,
                                groupedactivitys[dateKey]!.first.date,
                              ),
                            ),
                            ...groupedactivitys[dateKey]!.map(
                              (activity) => ActivityCard(activity: activity),
                            ),
                          ],
                        ]
                        : [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Transform.translate(
                                    offset: Offset(0, 10),
                                    child: Opacity(
                                      opacity: 0.5,
                                      child: Image.asset(
                                        'assets/images/empty/activity_empty.png',
                                        width: isSmall ? 240 : 320,
                                        height: isSmall ? 240 : 320,
                                      ),
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(0, -5),
                                    child: Text(
                                      translate(
                                        context,
                                        'No activities done yet!',
                                        'Belum ada aktivitas dilakukan!',
                                        '尚未完成任何活动！',
                                      ),
                                      style: TextStyle(
                                        color: Color(0xFFD3D3D3),
                                        fontWeight: FontWeight.w700,
                                        fontSize: isSmall ? 20 : 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
  final ActivityItem activity;

  const ActivityCard({super.key, required this.activity});

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
          'Parking booking at ${activity.mall} was successfully booked!',
          'Pemesanan parkir di ${activity.mall} berhasil dipesan!',
          '在 ${activity.mall} 的停车预订已成功预订！',
        );
      case ActivityTypes.bookCancel:
        return translate(
          context,
          'You have canceled booking at ${activity.mall}',
          'Anda telah membatalkan parkir di ${activity.mall}',
          '您已取消在 ${activity.mall} 的停车',
        );
      case ActivityTypes.exitLot:
        return translate(
          context,
          'You have exited parking lot at ${activity.mall}',
          'Anda telah keluar dari area parkir di ${activity.mall}',
          '您已离开 ${activity.mall} 的停车场',
        );
      case ActivityTypes.enterLot:
        return translate(
          context,
          'You have entered parking lot at ${activity.mall}',
          'Anda telah masuk dari area parkir di ${activity.mall}',
          '您已从 ${activity.mall} 的停车场进入',
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
          'Parking booking at ${activity.mall} was successfully paid',
          'Pemesanan parkir di ${activity.mall} berhasil dibayar',
          '在 ${activity.mall} 的停车预订已成功付款',
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
          'You have successfully topped up ${formatCurrency(nominal: activity.nominal as num)} via ${activity.method}.',
          'Kamu berhasil melakukan top up sebesar ${formatCurrency(nominal: activity.nominal as num)} melalui ${activity.method}.',
          '您已成功通过 ${activity.method} 充值 ${formatCurrency(nominal: activity.nominal as num)}。',
        );
      case ActivityTypes.unresolved:
        return translate(
          context,
          'Your parking at ${activity.mall} has exceeded 20 hour',
          'Parkir Anda di ${activity.mall} telah melebihi 20 jam',
          '您在 ${activity.mall} 的停车时间已超过20小时',
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
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 5,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Image.asset(
          _getActivityIcon(activity.activityTypes),
          width: isSmall ? 35 : 50,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                _cardTitle(context, activity.activityTypes),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isSmall ? 14 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              _formatDateTime(context, activity.date),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: isSmall ? 10 : 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        subtitle: Text(
          _cardDescription(context, activity.activityTypes),
          style: TextStyle(color: Colors.grey, fontSize: isSmall ? 12 : 14),
        ),
      ),
    );
  }
}
