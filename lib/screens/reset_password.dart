import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
import 'package:tugas_front_end_nicolas/screens/sign_in.dart';
import 'package:tugas_front_end_nicolas/utils/snackbar.dart';
import 'package:tugas_front_end_nicolas/utils/validator.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword(this.user_id);
  final int user_id;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isSubmitted = false;
  bool isLoading = false;

  Map<String, TextEditingController> FieldControls = {
    "password": TextEditingController(),
    "conpassword": TextEditingController(),
  };

  Map<String, String?> FieldErrors = {"password": null, "conpassword": null};

  bool validate() {
    final errorPassword = validatePassword(
      value: FieldControls["password"]!.text,
    );
    setState(() {
      FieldErrors["password"] = errorPassword;
    });
    final errorConPassword = validateBasic(
      key: "Confirm Password",
      match: FieldControls["password"]!.text,
      value: FieldControls["conpassword"]!.text,
    );
    setState(() {
      FieldErrors["conpassword"] = errorConPassword;
    });
    return FieldErrors["password"] == null &&
        FieldErrors["conpassword"] == null;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
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
                Center(
                  child: Text(
                    'Please Input Your New Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isSmall ? 20 : 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA03CDD),
                      shadows: [
                        Shadow(
                          offset: Offset(4, 4),
                          blurRadius: 6.0,
                          color: Color.fromRGBO(117, 53, 166, 0.25),
                        ),
                      ],
                    ),
                  ),
                ),

                Image.asset(
                  'assets/starting/reset_password.png',
                  height: isSmall ? 180 : 300,
                ),
                Center(
                  child: Text(
                    'Your new password must not be the same from previous password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF7B7B7B),
                      shadows: [
                        Shadow(
                          offset: Offset(4, 4),
                          blurRadius: 6.0,
                          color: Color.fromRGBO(100, 100, 100, 0.251),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: isSmall ? 10 : 20),

                Column(
                  children: [
                    ResponsiveTextInput(
                      isSmall: isSmall,
                      controller: FieldControls["password"],
                      hint: 'Enter New Password',
                      label: 'New Password',
                      type: TextInputTypes.password,
                      errorText: FieldErrors["password"],
                      onChanged: () {
                        if (isSubmitted) {
                          validate();
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    ResponsiveTextInput(
                      isSmall: isSmall,
                      controller: FieldControls["conpassword"],
                      hint: 'Confirm New password',
                      label: 'Confirm Password',
                      type: TextInputTypes.password,
                      errorText: FieldErrors["conpassword"],
                      onChanged: () {
                        if (isSubmitted) {
                          validate();
                        }
                      },
                    ),
                  ],
                ),

                SizedBox(
                  height:
                      isSmall
                          ? FieldErrors["password"] == null
                              ? 75
                              : 40
                          : 80,
                ),

                ResponsiveButton(
                  isSmall: isSmall,
                  isLoading: isLoading,
                  onPressed: () {
                    isSubmitted = true;
                    final isValid = validate();
                    if (isValid) {
                      setState(() => isLoading = true);
                      Future.delayed(const Duration(seconds: 2), () {
                        int success = userProvider.resetPassword(
                          widget.user_id,
                          FieldControls["password"]!.text,
                        );
                        if (success == 0) {
                          showFlexibleSnackbar(
                            context,
                            "Password can not be the same!",
                            type: SnackbarType.error,
                          );
                          setState(() => isLoading = false);
                          return;
                        }
                        setState(() => isLoading = false);
                        showFlexibleSnackbar(
                          context,
                          "Password has been reseted!",
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                        );
                      });
                    }
                  },
                  text: "Continue",
                ),
                SizedBox(height: isSmall ? 10 : 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
