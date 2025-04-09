import 'package:flutter/material.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  bool? isName;
  bool? isPhone;
  bool? isPassword;
  bool? isConfirmPw;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpw = TextEditingController();

  @override
  void initState() {
    isName = false;
    isPhone = false;
    isPassword = false;
    isConfirmPw = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              const Text(
                'USER DATA',
                style: TextStyle(
                  fontSize: 50,
                  color: Color(0xFF2C39B8),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
