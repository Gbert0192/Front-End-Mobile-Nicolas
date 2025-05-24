import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/countdown.dart';
import 'package:tugas_front_end_nicolas/components/pin_input.dart';
import 'package:tugas_front_end_nicolas/provider/forget_pass_provider.dart';
import 'package:tugas_front_end_nicolas/screens/starting/reset_password.dart';
import 'package:tugas_front_end_nicolas/utils/snackbar.dart';

class VerifyAccount extends StatefulWidget {
  const VerifyAccount(this.user_id, {super.key});
  final int user_id;

  @override
  State<VerifyAccount> createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  bool isSubmitted = false;
  bool resending = false;
  bool isLoading = false;
  int count = 0;

  TextEditingController otpController = TextEditingController();

  String? otpError;

  String obscureEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;

    final name = parts[0];
    final domain = parts[1];

    if (name.length <= 2) {
      return '${'*' * name.length}@$domain';
    }

    final lastTwo = name.substring(name.length - 2);
    final obscured = '*' * (name.length - 2) + lastTwo;

    return '$obscured@$domain';
  }

  @override
  Widget build(BuildContext context) {
    final forgotPassProvider = Provider.of<ForgetPassProvider>(context);
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    String email = obscureEmail(forgotPassProvider.email);

    bool validate() {
      final errorOtp = otpController.text == "" ? "OTP must be filled" : null;
      setState(() {
        otpError = errorOtp;
      });

      return errorOtp == null;
    }

    return Scaffold(
      appBar: AppBar(
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
                      style: TextStyle(
                        fontSize: isSmall ? 20 : 30,
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
                      'Account',
                      style: TextStyle(
                        fontSize: isSmall ? 20 : 30,
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
                ResponsivePINInput(
                  isSmall: isSmall,
                  errorText: otpError,
                  controller: otpController,
                  inputType: PinInputType.number,
                  onChanged: () {
                    if (isSubmitted) {
                      validate();
                    }
                  },
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

                    GestureDetector(
                      onTap: () {
                        if (!resending && count == 0) {
                          setState(() => resending = true);
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              resending = false;
                              count = 10;
                            });
                            showFlexibleSnackbar(
                              context,
                              "Your OTP is ${forgotPassProvider.generateOTP()}",
                            );
                          });
                        }
                      },
                      child:
                          resending
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: isSmall ? 16 : 20,
                                    height: isSmall ? 16 : 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF1879D4),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Resending...",
                                    style: TextStyle(
                                      fontSize: isSmall ? 15 : 18,
                                      color: Color(0xFF1879D4),
                                      shadows: [
                                        Shadow(
                                          offset: Offset(4, 4),
                                          blurRadius: 6.0,
                                          color: Color.fromRGBO(
                                            24,
                                            45,
                                            163,
                                            0.25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                              : count == 0
                              ? Text(
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
                              )
                              : CountdownTimer(
                                isSmall: isSmall,
                                countLong: count,
                                countDownFunction:
                                    (int remain) => setState(() {
                                      count = remain;
                                    }),
                                color: Color(0xFF1879D4),
                              ),
                    ),
                  ],
                ),

                SizedBox(
                  height:
                      isSmall
                          ? otpError != null
                              ? 95
                              : 100
                          : otpError != null
                          ? 170
                          : 180,
                ),

                ResponsiveButton(
                  isSmall: isSmall,
                  isLoading: isLoading,
                  onPressed: () {
                    setState(() {
                      isSubmitted = true;
                    });
                    final isValid = validate();
                    if (isValid) {
                      setState(() => isLoading = true);
                      Future.delayed(const Duration(seconds: 2), () {
                        final otpValid = forgotPassProvider.validateOTP(
                          otpController.text,
                        );
                        setState(() {
                          isLoading = false;
                        });
                        if (otpValid) {
                          showFlexibleSnackbar(context, "OTP Valid!");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ResetPassword(widget.user_id),
                            ),
                          );
                        } else {
                          showFlexibleSnackbar(
                            context,
                            "OTP Invalid!",
                            type: SnackbarType.error,
                          );
                        }
                      });
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
