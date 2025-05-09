import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/account/subscription/subscription_back.dart';

class SubscriptionChoice extends StatefulWidget {
  const SubscriptionChoice({super.key});

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Member',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isSmall ? 20 : 40),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/others/member.png',
                    width: isSmall ? 220 : 300,
                  ),
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
                  SizedBox(height: isSmall ? 10 : 30),

                  // Button
                  ResponsiveButton(
                    isSmall: isSmall,
                    onPressed: () {
                      if (val == 0) {
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  SubscriptionBack(title: selectedText),
                        ),
                      );
                    },
                    text: 'Payment',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
