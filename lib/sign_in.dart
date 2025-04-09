import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/user_data.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
      appBar: AppBar(title: Text('Sign In')),
      //batas hpus
      body: SafeArea(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserData()),
            );
          },
          child: const Text('Next'),
        ),
      ),
      //batas hpus
    );
  }
}
