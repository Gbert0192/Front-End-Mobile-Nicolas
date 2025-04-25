import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/provider/forget_pass_provider.dart';
import 'package:tugas_front_end_nicolas/utils/snackbar.dart';

class VerifyOtpEmail extends StatefulWidget {
  const VerifyOtpEmail({super.key});

  @override
  State<VerifyOtpEmail> createState() => _VerifyOtpEmailState();
}

class _VerifyOtpEmailState extends State<VerifyOtpEmail> {
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
                    const Text(
                      'Verify',
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 5),
                    const Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                Column(
                  children: [
                    const Text(
                      'Please enter the code sent to ',
                      style: TextStyle(fontSize: 18, color: Color(0xFFBABABA)),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFBABABA),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                SizedBox(height: isSmall ? 10 : 20),

                // OTP Field
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: otpController,
                  autoDisposeControllers: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor:
                        isOtpEmpty == true
                            ? const Color(0xFFFFEDED)
                            : Colors.white,
                    selectedFillColor:
                        isOtpEmpty == true
                            ? const Color(0xFFFFEDED)
                            : Colors.white,
                    inactiveFillColor:
                        isOtpEmpty == true
                            ? const Color(0xFFFFEDED)
                            : Colors.white,
                    activeColor: isOtpEmpty == true ? Colors.red : Colors.blue,
                    selectedColor:
                        isOtpEmpty == true ? Colors.red : Colors.blue,
                    inactiveColor:
                        isOtpEmpty == true ? Colors.red : Colors.grey,
                  ),
                  enableActiveFill: true,
                  onChanged: (value) {
                    setState(() {
                      isOtpEmpty = false;
                    });
                  },
                  beforeTextPaste: (text) {
                    return false;
                  },
                ),
                if (isOtpEmpty == true)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Please Enter The Code!',
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Didn\'t Receive OTP?',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 5),
                    const Text(
                      'Resend OTP',
                      style: TextStyle(fontSize: 18, color: Color(0xFF1879D4)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                SizedBox(height: isSmall ? 90 : 180),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isOtpEmpty = otpController.text.length < 6;
                      });

                      if (!isOtpEmpty!) {
                        showFlexibleSnackbar(
                          context,
                          "OTP is invalid",
                          type: SnackbarType.error,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F1E5B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Verify OTP',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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
