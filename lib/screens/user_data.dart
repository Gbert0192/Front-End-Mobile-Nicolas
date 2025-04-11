import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tugas_front_end_nicolas/screens/home.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  bool isName = false;
  bool isPhone = false;
  bool isPassword = false;
  bool isConfirmPw = false;
  bool isButtonEnabled = false;
  bool isObscure = true;
  bool isPasswordMatch = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpwController = TextEditingController();

  @override
  void initState() {
    nameController.addListener(checkTextField);

    super.initState();
  }

  void passwordVisibility() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  void checkTextField() {
    setState(() {
      isButtonEnabled = nameController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: true,
        title: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Colors.white,
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
              SizedBox(height: 20),
              const Text(
                'USER DATA',
                style: TextStyle(
                  fontSize: 50,
                  color: Color(0xFF2C39B8),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person_rounded,
                      size: 100,
                      color: Colors.grey[400],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        constraints: BoxConstraints(
                          minHeight: 16,
                          minWidth: 16,
                        ),
                        icon: Icon(Icons.edit, size: 14),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              //FullName
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  labelText: 'Full Name',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
              SizedBox(height: 20),

              //Phone
              SizedBox(
                child: IntlPhoneField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    hintText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(),
                    ),
                    errorText:
                        isPhone == true ? '*Phone Number must be filled' : null,
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    filled: true,
                    fillColor:
                        isPhone == true ? Color(0xFFFFEDED) : Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                  initialCountryCode: 'ID',
                  disableLengthCheck: true,
                ),
              ),
              SizedBox(height: 20),

              //Password
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: passwordController,
                  obscureText: isObscure,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(),
                    ),
                    errorText:
                        isPassword == true ? '*Password must be filled' : null,
                    filled: true,
                    fillColor:
                        isPassword == true ? Color(0xFFFFEDED) : Colors.white,
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    suffixIcon: IconButton(
                      onPressed: passwordVisibility,
                      icon: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              //Confirm Password
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: confirmpwController,
                  obscureText: isObscure,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(),
                    ),
                    errorText:
                        isConfirmPw == true
                            ? '*Confirm Password must be filled'
                            : (confirmpwController.text !=
                                    passwordController.text
                                ? '*Password is not matched'
                                : null),
                    filled: true,
                    fillColor:
                        (isConfirmPw ||
                                confirmpwController.text !=
                                    passwordController.text)
                            ? Color(0xFFFFEDED)
                            : Colors.white,
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    suffixIcon: IconButton(
                      onPressed: passwordVisibility,
                      icon: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Spacer(),

              //Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      isButtonEnabled
                          ? () {
                            setState(() {
                              isPhone = phoneController.text.isEmpty;
                              isPassword = passwordController.text.isEmpty;
                              isConfirmPw = confirmpwController.text.isEmpty;
                              isPasswordMatch =
                                  confirmpwController.text ==
                                  passwordController.text;
                            });

                            if (!isPhone &&
                                !isPassword &&
                                !isConfirmPw &&
                                isPasswordMatch) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            }
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1F1E5B),
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
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
