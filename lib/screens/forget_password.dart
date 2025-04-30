import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';
import 'package:tugas_front_end_nicolas/provider/forget_pass_provider.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
import 'package:tugas_front_end_nicolas/screens/verfy_account.dart';
import 'package:tugas_front_end_nicolas/utils/snackbar.dart';
import 'package:tugas_front_end_nicolas/utils/useform.dart';
import 'package:tugas_front_end_nicolas/utils/validator.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final form = UseForm(
    fields: ["email"],
    validators: {'email': (value) => validateEmail(value: value)},
  );
  @override
  Widget build(BuildContext context) {
    final forgotPassProvider = Provider.of<ForgetPassProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
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
                      controller: form.control("email"),
                      hint: 'Enter your email',
                      label: 'Email',
                      type: TextInputTypes.email,
                      errorText: form.error("email"),
                      onChanged: () {
                        if (form.isSubmitted) {
                          setState(() {
                            form.validate();
                          });
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
                  isLoading: form.isLoading,
                  onPressed: () {
                    bool isValid = false;
                    setState(() {
                      form.isSubmitted = true;
                      isValid = form.validate();
                    });
                    if (isValid) {
                      setState(() => form.isLoading = true);
                      Future.delayed(const Duration(seconds: 2), () {
                        int userId = userProvider.findUser(
                          form.control("email").text,
                        );
                        if (userId == -1) {
                          showFlexibleSnackbar(
                            context,
                            "Email not found",
                            type: SnackbarType.error,
                          );
                          setState(() => form.isLoading = false);
                          return;
                        }
                        forgotPassProvider.email = form.control("email").text;
                        forgotPassProvider.generateOTP();
                        setState(() => form.isLoading = false);
                        showFlexibleSnackbar(
                          context,
                          "Your OTP is ${forgotPassProvider.OTP}",
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyAccount(userId),
                          ),
                        );
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
