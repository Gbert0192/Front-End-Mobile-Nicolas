import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';
import 'package:tugas_front_end_nicolas/screens/sign_in.dart';
import 'package:tugas_front_end_nicolas/screens/user_data.dart';
import 'package:tugas_front_end_nicolas/utils/validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Text(
                  'WELCOME TO PARK-ID',
                  style: TextStyle(
                    fontSize: isSmall ? 30 : 50,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFA03CDD),
                    shadows: [
                      Shadow(
                        offset: Offset(4, 4),
                        blurRadius: 6.0,
                        color: Color.fromARGB(90, 11, 145, 255),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/starting/enter_park.png',
                  height: isSmall ? 240 : 360,
                ),
                SizedBox(height: isSmall ? 10 : 20),
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

                SizedBox(height: isSmall ? 10 : 20),

                ResponsiveButton(
                  isSmall: isSmall,
                  onPressed: () {
                    isSubmitted = true;
                    final isValid = validate();
                    if (isValid) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserData()),
                      );
                    }
                  },
                  text: "Sign Up",
                ),
                SizedBox(height: isSmall ? 10 : 20),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Or',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),

                SizedBox(height: isSmall ? 10 : 20),

                const Text(
                  'Already Sign Up?',
                  style: TextStyle(color: Color(0xFF10297F)),
                ),

                ResponsiveButton(
                  isSmall: isSmall,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  buttonType: ButtonTypes.outline,
                  text: "Sign In",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
