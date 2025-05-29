import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationItem {
  final String notifIcon;
  final NotifTypes typeText;
  final String mall;
  final DateTime date;

  NotificationItem({
    required this.notifIcon,
    required this.typeText,
    required this.mall,
    required this.date,
  });
}

class Notification_ extends StatelessWidget {
  const Notification_({super.key});

  List<NotificationItem> _getNotifications() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    return [
      // Today's notifications
      NotificationItem(
        notifIcon: 'assets/images/icons/booking.png',
        mall: 'Sun Plaza',
        typeText: NotifTypes.bookSuccess,
        date: today.add(Duration(hours: 11, minutes: 2)),
      ),
      NotificationItem(
        notifIcon: 'assets/images/icons/cancel.png',
        mall: 'Centre Point Mall',
        typeText: NotifTypes.bookCancel,
        date: today.add(Duration(hours: 10, minutes: 15)),
      ),

      // Yesterday's notifications
      NotificationItem(
        notifIcon: 'assets/images/icons/payment.png',
        mall: 'Thamrin Plaza',
        typeText: NotifTypes.paySuccess,
        date: yesterday.add(Duration(hours: 16, minutes: 45)),
      ),
      NotificationItem(
        notifIcon: 'assets/images/icons/exit.png',
        mall: 'Thamrin Plaza',
        typeText: NotifTypes.bookExit,
        date: yesterday.add(Duration(hours: 15, minutes: 20)),
      ),
      NotificationItem(
        notifIcon: 'assets/images/icons/locked.png',
        mall: '',
        typeText: NotifTypes.verif2Step,
        date: yesterday.add(Duration(hours: 9, minutes: 30)),
      ),

      // December 6, 2024
      NotificationItem(
        notifIcon: 'assets/images/icons/payment.png',
        mall: 'Sun Plaza',
        typeText: NotifTypes.paySuccess,
        date: DateTime(2024, 12, 6, 13, 25),
      ),
      NotificationItem(
        notifIcon: 'assets/images/icons/exit.png',
        mall: 'Sun Plaza',
        typeText: NotifTypes.bookExit,
        date: DateTime(2024, 12, 6, 12, 45),
      ),

      // November 28, 2024
      NotificationItem(
        notifIcon: 'assets/images/icons/payment.png',
        mall: 'Medan Mall',
        typeText: NotifTypes.paySuccess,
        date: DateTime(2024, 11, 28, 17, 10),
      ),
      NotificationItem(
        notifIcon: 'assets/images/icons/exit.png',
        mall: 'Medan Mall',
        typeText: NotifTypes.bookExit,
        date: DateTime(2024, 11, 28, 16, 30),
      ),
      NotificationItem(
        notifIcon: 'assets/images/icons/booking.png',
        mall: 'Medan Mall',
        typeText: NotifTypes.bookSuccess,
        date: DateTime(2024, 11, 28, 14, 20),
      ),

      // November 21, 2024
      NotificationItem(
        notifIcon: 'assets/images/icons/expired.png',
        mall: '',
        typeText: NotifTypes.bookExp,
        date: DateTime(2024, 11, 21, 11, 0),
      ),
      NotificationItem(
        notifIcon: 'assets/images/icons/booking.png',
        mall: 'Medan Mall',
        typeText: NotifTypes.bookSuccess,
        date: DateTime(2024, 11, 21, 8, 45),
      ),

      // November 18, 2024
      NotificationItem(
        notifIcon: 'assets/images/icons/verification.png',
        mall: '',
        typeText: NotifTypes.verif,
        date: DateTime(2024, 11, 18, 19, 30),
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

  Map<String, List<NotificationItem>> _groupNotificationsByDate(
    List<NotificationItem> notifications,
  ) {
    Map<String, List<NotificationItem>> grouped = {};

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

  List<String> _getSortedDateKeys(Map<String, List<NotificationItem>> grouped) {
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

    final notifications = _getNotifications();
    final groupedNotifications = _groupNotificationsByDate(notifications);
    final sortedDateKeys = _getSortedDateKeys(groupedNotifications);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Text(
                'Notifications',
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
                    NotifTitle(dateTitle: dateKey),
                    ...groupedNotifications[dateKey]!
                        .map(
                          (notification) => NotifCard(
                            notifIcon: notification.notifIcon,
                            mall: notification.mall,
                            typeText: notification.typeText,
                            date: notification.date,
                          ),
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
  final DateTime date;

  const NotifCard({
    super.key,
    required this.notifIcon,
    this.typeText = NotifTypes.bookSuccess,
    required this.mall,
    required this.date,
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

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return "Just now";
        }
        return "${difference.inMinutes}m ago";
      }
      return "${difference.inHours}h ago";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
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
        leading: Image.asset(notifIcon, width: isSmall ? 35 : 50),
        title: Row(
          children: [
            Expanded(
              child: Text(
                _cardTitle(typeText),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isSmall ? 14 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              _formatDateTime(date),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: isSmall ? 10 : 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        subtitle: Text(
          _cardDescription(typeText),
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ),
    );
  }
}
