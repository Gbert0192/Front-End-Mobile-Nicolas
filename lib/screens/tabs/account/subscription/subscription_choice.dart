import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';

class SubscriptionChoice extends StatefulWidget {
  const SubscriptionChoice(this.onChanged);
  final Function(MemberChoice) onChanged;

  @override
  State<SubscriptionChoice> createState() => _SubscriptionChoiceState();
}

class _SubscriptionChoiceState extends State<SubscriptionChoice> {
  int val = 0;
  String selectedText = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Center(
      child: Column(
        children: [
          Image.asset('assets/others/member.png', width: isSmall ? 220 : 340),
          SizedBox(height: isSmall ? 20 : 40),
          //Radio Button 1
          Container(
            decoration: BoxDecoration(
              color: Color(0x80EAEAF3),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Color(0x804D5DFA)),
            ),

            child: RadioListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: isSmall ? 5 : 10,
                horizontal: 15,
              ),
              value: 1,
              groupValue: val,
              activeColor: Color(0xFF1F1E5B),
              onChanged: (value) {
                setState(() {
                  val = value!;
                  selectedText = 'annual';
                  widget.onChanged.call(
                    MemberChoice(MemberType.annual, 300000),
                  );
                });
              },
              title: Text(
                'Annual',
                style: TextStyle(
                  fontSize: isSmall ? 16 : 20,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                'Pay for a full year',
                style: TextStyle(
                  fontSize: isSmall ? 13 : 18,
                  color: Color(0xFFAAA9A9),
                ),
              ),
              secondary: Text(
                'Rp300.000',
                style: TextStyle(fontSize: isSmall ? 14 : 18),
              ),
              selected: val == 1,
            ),
          ),
          SizedBox(height: isSmall ? 10 : 20),

          //Radio Button 2
          Container(
            decoration: BoxDecoration(
              color: Color(0x80EAEAF3),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Color(0x804D5DFA)),
            ),

            child: RadioListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: isSmall ? 5 : 10,
                horizontal: 15,
              ),
              value: 2,
              groupValue: val,
              activeColor: Color(0xFF1F1E5B),
              onChanged: (value) {
                setState(() {
                  val = value!;
                  selectedText = 'seasonal';
                  widget.onChanged.call(
                    MemberChoice(MemberType.seasonal, 150000),
                  );
                });
              },
              title: Text(
                'Seasonal',
                style: TextStyle(
                  fontSize: isSmall ? 16 : 20,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                'Pay for 3 months',
                style: TextStyle(
                  fontSize: isSmall ? 13 : 18,
                  color: Color(0xFFAAA9A9),
                ),
              ),
              secondary: Text(
                'Rp150.000',
                style: TextStyle(fontSize: isSmall ? 14 : 18),
              ),
              selected: val == 2,
            ),
          ),
          SizedBox(height: isSmall ? 10 : 20),

          //Radio Button 3
          Container(
            decoration: BoxDecoration(
              color: Color(0x80EAEAF3),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Color(0x804D5DFA)),
            ),

            child: RadioListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: isSmall ? 5 : 10,
                horizontal: 15,
              ),
              value: 3,
              groupValue: val,
              activeColor: Color(0xFF1F1E5B),
              onChanged: (value) {
                setState(() {
                  val = value!;
                  selectedText = 'monthly';
                  widget.onChanged.call(
                    MemberChoice(MemberType.monthly, 50000),
                  );
                });
              },
              title: Text(
                'Monthly',
                style: TextStyle(
                  fontSize: isSmall ? 16 : 20,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                'Pay monthly, cancel any time',
                style: TextStyle(
                  fontSize: isSmall ? 13 : 18,
                  color: Color(0xFFAAA9A9),
                ),
              ),
              secondary: Text(
                'Rp50.000',
                style: TextStyle(fontSize: isSmall ? 14 : 18),
              ),
              selected: val == 3,
            ),
          ),
        ],
      ),
    );
  }
}

class MemberChoice {
  MemberType value;
  double price;

  MemberChoice(this.value, this.price);
}
