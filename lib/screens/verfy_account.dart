import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/pin_input.dart';
import 'package:tugas_front_end_nicolas/provider/forget_pass_provider.dart';
import 'package:tugas_front_end_nicolas/utils/snackbar.dart';

class VerifyOtpEmail extends StatefulWidget {
  const VerifyOtpEmail({super.key});

  @override
  State<VerifyOtpEmail> createState() => _VerifyOtpEmailState();
}

class _VerifyOtpEmailState extends State<VerifyOtpEmail> {
  bool isSubmitted = false;

  TextEditingController otpController = TextEditingController();

  bool? isOtpEmpty;

  @override
  void initState() {
    isOtpEmpty = false;
    super.initState();
  }

  String obscureEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;

    final name = parts[0];
    final domain = parts[1];

    if (name.length <= 2) {
      return '*' * name.length + '@' + domain;
    }

    final lastTwo = name.substring(name.length - 2);
    final obscured = '*' * (name.length - 2) + lastTwo;

    return obscured + '@' + domain;
  }

  @override
  Widget build(BuildContext context) {
    final forgotPassProvider = Provider.of<ForgetPassProvider>(context);
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    String email = obscureEmail(forgotPassProvider.email);

    bool validate() {
      if (forgotPassProvider.validateOTP(otpController.text)) {
        showFlexibleSnackbar(context, "OTP Invalid!");
        return false;
      }
      return true;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            ElevatedButton(
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
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isSmall ? 12 : 24.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/starting/otp_send.png',
                  height: isSmall ? 180 : 300,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Verify',
                      style: TextStyle(fontSize: isSmall ? 20 : 30),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Account',
                      style: TextStyle(
                        fontSize: isSmall ? 20 : 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                Column(
                  children: [
                    Text(
                      'Please enter the code sent to ',
                      style: TextStyle(
                        fontSize: isSmall ? 15 : 18,
                        color: Color(0xFFBABABA),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: isSmall ? 15 : 18,
                        color: Color(0xFFBABABA),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                SizedBox(height: isSmall ? 10 : 20),

                // OTP Field
                ResponsivePINInput(isSmall: isSmall),

                if (isOtpEmpty == true)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Please Enter The Code!',
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                SizedBox(height: isSmall ? 18 : 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'OTP not received?',
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
                      'Resend OTP',
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

                SizedBox(height: isSmall ? 100 : 180),

                ResponsiveButton(
                  isSmall: isSmall,
                  onPressed: () {
                    isSubmitted = true;
                    final isValid = validate();
                    if (isValid) {
                      forgotPassProvider.email = otpController.text;
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
