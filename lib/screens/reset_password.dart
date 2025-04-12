import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isPassword = false;
  bool isConfirmPw = false;
  bool isObscure = false;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpwController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void passwordVisibility() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
