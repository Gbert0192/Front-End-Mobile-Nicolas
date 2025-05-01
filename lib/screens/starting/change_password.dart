import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';
import 'package:tugas_front_end_nicolas/utils/useform.dart';
import 'package:tugas_front_end_nicolas/utils/validator.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late final UseForm form = UseForm(
    fields: ["password", "newPassword", "confirmPassword"],
    validators: {
      'password':
          (value) => validateBasic(key: 'Password', value: value, minLength: 8),
      'newPassword':
          (value) =>
              validateBasic(key: 'New Password', value: value, minLength: 8),
      'confirmPassword': (value) {
        final newPassword = form.control("newPassword").text;
        if (value != newPassword) return "Passwords do not match";
        return null;
      },
    },
  );
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Scaffold(
      appBar: AppBar(
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isSmall ? 12 : 24.0),
            child: Column(
              children: [
                Text(
                  'Please Input Both Old and New Password!',
                  style: TextStyle(
                    fontSize: isSmall ? 20 : 24,
                    color: Color(0xFF91AFFF),
                    fontWeight: FontWeight.w800,
                    fontFamily: "Poppins",
                    shadows: [
                      Shadow(
                        offset: Offset(0, 3.5),
                        blurRadius: 2.0,
                        color: Color(0x3E182DA3),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                Image.asset(
                  "assets/starting/change_pass 1.png",
                  height: isSmall ? 180 : 300,
                ),
                SizedBox(height: isSmall ? 10 : 20),
                ResponsiveTextInput(
                  isSmall: isSmall,
                  controller: form.control("password"),
                  hint: 'Enter your Current password',
                  label: 'Current Password',
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
                SizedBox(height: isSmall ? 10 : 20),
                ResponsiveTextInput(
                  isSmall: isSmall,
                  controller: form.control("newPassword"),
                  hint: 'Enter your New password',
                  label: 'New Password',
                  type: TextInputTypes.password,
                  errorText: form.error("newPassword"),
                  onChanged: () {
                    if (form.isSubmitted) {
                      setState(() {
                        form.validate();
                      });
                    }
                  },
                ),
                SizedBox(height: isSmall ? 10 : 20),
                ResponsiveTextInput(
                  isSmall: isSmall,
                  controller: form.control("confirmPassword"),
                  hint: 'Confirm password',
                  label: 'Confirm Password',
                  type: TextInputTypes.password,
                  errorText: form.error("confirmPassword"),
                  onChanged: () {
                    if (form.isSubmitted) {
                      setState(() {
                        form.validate();
                      });
                    }
                  },
                ),
                SizedBox(height: isSmall ? 40 : 70),

                ResponsiveButton(
                  backgroundColor: const Color(0xFF1F1E5B),
                  isSmall: isSmall,
                  isLoading: form.isLoading,
                  onPressed: () {
                    final isValid = form.validate();
                    if (isValid) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password berhasil diubah!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      setState(() {});
                    }
                  },
                  text: "Change Password",
                  buttonType: ButtonTypes.outline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
