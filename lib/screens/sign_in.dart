import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
import 'package:tugas_front_end_nicolas/screens/forget_password.dart';
import 'package:tugas_front_end_nicolas/screens/home.dart';
import 'package:tugas_front_end_nicolas/screens/sign_up.dart';
import 'package:tugas_front_end_nicolas/utils/snackbar.dart';
import 'package:tugas_front_end_nicolas/utils/useform.dart';
import 'package:tugas_front_end_nicolas/utils/validator.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final form = UseForm(
    fields: ["email", "password"],
    validators: {
      'email': (value) => validateEmail(value: value),
      'password':
          (value) => validateBasic(key: 'Password', value: value, minLength: 8),
    },
  );

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
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
                        const SizedBox(height: 12),
                        ResponsiveTextInput(
                          isSmall: isSmall,
                          controller: form.control("password"),
                          hint: 'Enter your password',
                          label: 'Password',
                          type: TextInputTypes.password,
                          errorText: form.error("password"),
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

                    SizedBox(height: isSmall ? 10 : 20),

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
                            int user_id = userProvider.findUser(
                              form.control("email").text,
                            );
                            if (user_id == -1 ||
                                userProvider.login(
                                      user_id,
                                      form.control("password").text,
                                    ) ==
                                    -1) {
                              showFlexibleSnackbar(
                                context,
                                "Invalid Credential!",
                                type: SnackbarType.error,
                              );
                              setState(() => form.isLoading = false);
                              return;
                            }
                            setState(() => form.isLoading = false);
                            showFlexibleSnackbar(
                              context,
                              "Welcome Back, ${userProvider.userList[user_id].fullname.split(" ")[0]}!",
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          });
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
                      isLoading: form.isLoading,
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
