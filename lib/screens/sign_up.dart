import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';
import 'package:tugas_front_end_nicolas/screens/sign_in.dart';
import 'package:tugas_front_end_nicolas/screens/user_data.dart';
import 'package:tugas_front_end_nicolas/validators/index.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Map<String, dynamic> FormField = {
    "fields": {
      "email": {"controller": TextEditingController(), "errorText": null},
    },
    "isSubmited": false,
  };

  bool validate() {
    bool status = true;
    final errorEmail = validateEmail(
      value: FormField["fields"]["email"]["controller"].text,
    );
    if (errorEmail != null) {
      status = false;
      setState(() {
        FormField["fields"]["email"]["errorText"] = errorEmail;
      });
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
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
                    fontSize: 50,
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
                Image.asset('assets/starting/enter_park.png', height: 360),
                Column(
                  children: [
                    ResponsiveTextInput(
                      controller: FormField["fields"]["email"]["controller"],
                      hint: 'Enter your email',
                      label: 'Email',
                      type: 'email',
                      errorText: FormField["fields"]["email"]["errorText"],
                      onChanged: () {
                        if (FormField["isSubmited"]) {
                          validate();
                        }
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      FormField["isSubmited"] = true;
                      final isValid = validate();
                      if (isValid) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UserData()),
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

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('Or', style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),

                const SizedBox(height: 20),

                const Text(
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
      ),
    );
  }
}
