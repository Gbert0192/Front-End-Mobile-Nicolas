import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();

  String emailText = "lisa1204@gmail.com";
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(height: 40),
              const Text(
                'WELCOME TO PARK-ID',
                style: TextStyle(fontSize: 50, color: Color(0xFFA03CDD)),
              ),
              SizedBox(height: 40),
              Image.asset('assets/starting/Enter Park.png', height: 300),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelText: 'Email',
                  errorText:
                      isEmailEmpty == true ? '*Email Must be Filled' : null,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (emailController.text.isEmpty) {
                      isEmailEmpty = true;
                    } else {
                      setState(() {
                        isEmailEmpty = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1F1E5B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 2,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Or',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 2,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Already Sign Up?',
                style: TextStyle(color: Color(0xFF10297F)),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Color(0xFF1F1E5B)),
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
