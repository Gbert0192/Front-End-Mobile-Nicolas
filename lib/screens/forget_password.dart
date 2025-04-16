import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';
import 'package:tugas_front_end_nicolas/screens/verify_otp_email.dart';
import 'package:tugas_front_end_nicolas/utils/validator.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool isSubmitted = false;

  final TextEditingController emailController = TextEditingController();
  String? emailError;

  bool validate() {
    final errorEmail = validateEmail(value: emailController.text);
    setState(() {
      emailError = errorEmail;
    });
    return errorEmail == null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Scaffold(
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
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isSmall ? 12 : 24.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/starting/forget_pass.png',
                  height: isSmall ? 180 : 300,
                ),
                SizedBox(height: isSmall ? 10 : 20),
                Text(
                  'Forgot Your Password? Enter Your Email To Get OTP!',
                  style: TextStyle(
                    fontSize: isSmall ? 20 : 24,
                    color: Color(0xFF1879D4),
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(4, 4),
                        blurRadius: 6.0,
                        color: Color.fromRGBO(24, 45, 163, 0.25),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isSmall ? 15 : 30),
                // Email Field
                Column(
                  children: [
                    ResponsiveTextInput(
                      isSmall: isSmall,
                      controller: emailController,
                      hint: 'Enter your email',
                      label: 'Email',
                      type: TextInputTypes.email,
                      errorText: emailError,
                      onChanged: () {
                        if (isSubmitted) {
                          validate();
                        }
                      },
                    ),
                  ],
                ),

                SizedBox(height: isSmall ? 15 : 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Any Questions?',
                      style: TextStyle(
                        fontSize: isSmall ? 15 : 18,
                        shadows: [
                          Shadow(
                            offset: Offset(4, 4),
                            blurRadius: 6.0,
                            color: Color.fromRGBO(24, 45, 163, 0.25),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Chat With Us',
                      style: TextStyle(
                        fontSize: isSmall ? 15 : 18,
                        color: Color(0xFF1879D4),
                        shadows: [
                          Shadow(
                            offset: Offset(4, 4),
                            blurRadius: 6.0,
                            color: Color.fromRGBO(24, 45, 163, 0.25),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                SizedBox(height: isSmall ? 120 : 200),

                ResponsiveButton(
                  isSmall: isSmall,
                  onPressed: () {
                    isSubmitted = true;
                    final isValid = validate();
                    if (isValid) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerifyOtpEmail(),
                        ),
                      );
                    }
                  },
                  text: "Continue",
                ),
                SizedBox(height: isSmall ? 10 : 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
