import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String emailText = "lisa1204@gmail.com";
  bool? isEmailEmpty;
  bool? isPasswordEmpty;

  @override
  void initState() {
    emailController.text = "Email";
    isEmailEmpty = false;
    isPasswordEmpty = false;

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
              SizedBox(height: 40),
              const Text(
                'WELCOME TO PARK-ID',
                style: TextStyle(fontSize: 55, color: Color(0xFFA03CDD)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
