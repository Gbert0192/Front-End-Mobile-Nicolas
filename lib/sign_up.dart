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
              // SizedBox(height: 40),
              const Text(
                'WELCOME TO PARK-ID',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFA03CDD),
                ),
              ),
              SizedBox(height: 40),
              Image.asset('assets/starting/Enter Park.png', height: 300),
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
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // onPressed: () {
                  //   if (emailController.text.isEmpty) {
                  //     isEmailEmpty = true;
                  //   } else {
                  //     setState(() {
                  //       isEmailEmpty = false;
                  //     });
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => SignIn()),
                  //     );
                  //   }
                  // },
                  onPressed: () {
                    setState(() {
                      isEmailEmpty = emailController.text.isEmpty;
                    });
                    if (!isEmailEmpty!) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sign Up Success!')),
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
