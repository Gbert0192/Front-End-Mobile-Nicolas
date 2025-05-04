import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/subscription/subscription_choice.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
            padding: EdgeInsets.all(isSmall ? 30 : 50),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Get all the facilities by upgrading your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: isSmall ? 15 : 30),

                //Container
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F5FF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xFF4D5DFA)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: isSmall ? 10 : 20),
                      Center(
                        child: Text(
                          'Pro',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: isSmall ? 25 : 50),
                      ...[
                        'All Include',
                        'Unlimited Features',
                        'Discounts every reservation',
                        'All Include',
                        'All Include',
                        'All Include',
                      ].map(
                        (text) => Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: isSmall ? 7 : 10,
                            horizontal: isSmall ? 10 : 20,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_box,
                                size: 20,
                                color: Color(0xFF4D5DFA),
                              ),
                              SizedBox(width: isSmall ? 5 : 10),
                              Text(
                                text,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF1F1E5B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: isSmall ? 25 : 50),
                    ],
                  ),
                ),
                SizedBox(height: isSmall ? 20 : 40),

                // Button
                ResponsiveButton(
                  isSmall: isSmall,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubscriptionChoice(),
                      ),
                    );
                  },
                  text: 'Proceed Member',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
