import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();

  bool? isEmailEmpty;

  @override
  void initState() {
    isEmailEmpty = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Image.asset('assets/starting/forget_pass.png', height: 300),
              const SizedBox(height: 20),
              const Text(
                'Forgot Your Password? Enter Your Email To Get OTP!',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF1879D4),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Email Field
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  errorText: isEmailEmpty! ? '*Email Must be Filled' : null,
                  filled: true,
                  fillColor:
                      isEmailEmpty == true
                          ? const Color(0xFFFFEDED)
                          : Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),

              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Any Questions?',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 5),
                  const Text(
                    'Chat With Us',
                    style: TextStyle(fontSize: 18, color: Color(0xFF1879D4)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              SizedBox(height: 200),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEmailEmpty = emailController.text.isEmpty;
                    });

                    if (!isEmailEmpty!) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Login success!'),
                        ),
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
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
