import 'package:flutter/material.dart';

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
