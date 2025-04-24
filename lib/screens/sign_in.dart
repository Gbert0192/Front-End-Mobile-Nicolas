import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';
import 'package:tugas_front_end_nicolas/screens/forget_password.dart';
import 'package:tugas_front_end_nicolas/screens/home.dart';
import 'package:tugas_front_end_nicolas/screens/sign_up.dart';
import 'package:tugas_front_end_nicolas/utils/validator.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isSubmitted = false;

  Map<String, TextEditingController> FieldControls = {
    "email": TextEditingController(),
    "password": TextEditingController(),
  };

  Map<String, String?> FieldErrors = {"email": null, "password": null};

  bool validate() {
    final errorEmail = validateEmail(value: FieldControls["email"]!.text);
    setState(() {
      FieldErrors["email"] = errorEmail;
    });
    final errorPassword = validatePassword(
      value: FieldControls["password"]!.text,
    );
    setState(() {
      FieldErrors["password"] = errorPassword;
    });
    return FieldErrors["email"] == null && FieldErrors["password"] == null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/starting/park_spot.png',
                      height: isSmall ? 240 : 360,
                    ),
                    SizedBox(height: isSmall ? 10 : 20),
                    Text(
                      'Back Again! Your Perfect Spot Awaits!',
                      style: TextStyle(
                        fontSize: isSmall ? 18 : 24,
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
                    SizedBox(height: isSmall ? 10 : 20),

                    Column(
                      children: [
                        ResponsiveTextInput(
                          isSmall: isSmall,
                          controller: FieldControls["email"],
                          hint: 'Enter your email',
                          label: 'Email',
                          type: TextInputTypes.email,
                          errorText: FieldErrors["email"],
                          onChanged: () {
                            if (isSubmitted) {
                              validate();
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        ResponsiveTextInput(
                          isSmall: isSmall,
                          controller: FieldControls["password"],
                          hint: 'Enter your password',
                          label: 'Password',
                          type: TextInputTypes.password,
                          errorText: FieldErrors["password"],
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
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Login sukses!')),
                          );
                        }
                      },
                      text: "Sign In",
                    ),

                    // Sign In Button
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
                      'Haven’t Sign Up?',
                      style: TextStyle(color: Color(0xFF10297F)),
                    ),

                    ResponsiveButton(
                      isSmall: isSmall,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      text: "Sign Up",
                      buttonType: ButtonTypes.outline,
                    ),

                    SizedBox(height: isSmall ? 5 : 10),
                    // Forgot password text
                    GestureDetector(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetPassword(),
                            ),
                          ),
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                          color: Color(0xFF10297F),
                          fontSize: isSmall ? 16 : 24,
                        ),
                      ),
                    ),

                    SizedBox(height: isSmall ? 10 : 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
