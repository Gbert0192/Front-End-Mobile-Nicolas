import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/screens/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool? isEmailEmpty;
  bool? isPasswordEmpty;
  bool _obscureText = true;

  @override
  void initState() {
    isEmailEmpty = false;
    isPasswordEmpty = false;
    super.initState();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(width: 10),
          ],
        ),
      ),

      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Image.asset('assets/starting/park_spot.png', height: 350),
                const SizedBox(height: 20),
                const Text(
                  'Back Again! Your Perfect Spot Awaits!',
                  style: TextStyle(fontSize: 24, color: Color(0xFF1879D4)),
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
                const SizedBox(height: 20),

                // Password Field
                TextField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    errorText:
                        isPasswordEmpty == true
                            ? '*Password Must be Filled'
                            : null,
                    filled: true,
                    fillColor:
                        isPasswordEmpty == true
                            ? const Color(0xFFFFEDED)
                            : Colors.white,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEmailEmpty = emailController.text.isEmpty;
                        isPasswordEmpty = passwordController.text.isEmpty;
                      });

                      if (!isEmailEmpty! && !isPasswordEmpty!) {
                        // NI JANGAN DIGANTI DLU YA, W MASI TES KIRIM MESSAGE SUCCESS
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login sukses!')),
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
                      'Sign In',
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
                      child: Text(
                        'Or',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),

                const SizedBox(height: 20),

                const Text(
                  'Haven’t Sign Up?',
                  style: TextStyle(color: Color(0xFF10297F)),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      //ini jg janggan diganti dl ya
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const SignUp()),
                      // );
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text('Navigasi ke Sign Up')),
                      // );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Color(0xFF1F1E5B)),
                    ),
                  ),
                ),

                // Forgot password text
                const Text(
                  'Forget Password?',
                  style: TextStyle(color: Color(0xFF10297F)),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
