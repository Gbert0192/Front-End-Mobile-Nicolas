import 'package:flutter/material.dart';

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
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _cardDescription(typeText),
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
