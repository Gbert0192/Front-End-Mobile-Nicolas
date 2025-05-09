import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/phone_input.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
import 'package:tugas_front_end_nicolas/screens/main_layout.dart';
import 'package:tugas_front_end_nicolas/utils/snackbar.dart';
import 'package:tugas_front_end_nicolas/utils/useform.dart';
import 'package:tugas_front_end_nicolas/utils/validator.dart';

class UserData extends StatefulWidget {
  const UserData(this.email, {super.key});
  final String email;

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  String country_code = "ID";

  final form = UseForm(
    fields: ["fullname", "phone", "password", "conpassword"],
    validators: {
      "fullname": (value) => validateBasic(key: "Fullname", value: value),
      "phone":
          (value) => validateBasic(
            key: "Phone Number",
            value: value,
            minLength: 7,
            maxLength: 12,
          ),
      "password": (value) => validatePassword(value: value),
    },
    match: {
      "password": [
        {"key": "conpassword", "label": "Confirm Password"},
      ],
    },
  );

  int choice = -1;

  List<String> userPP = [
    "assets/users/female 1.jpg",
    "assets/users/female 2.jpg",
    "assets/users/male 2.jpg",
    "assets/users/female 4.jpg",
    "assets/users/male 5.jpg",
    "assets/users/female 5.jpg",
    "assets/users/male 1.jpg",
    "assets/users/female 3.jpg",
    "assets/users/male 4.jpg",
    "assets/users/male 3.jpg",
  ];

  void changeAvatar() {
    setState(() {
      choice += 1;
      if (choice == 10) {
        choice = -1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
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
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isSmall ? 12 : 24.0),
                child: Column(
                  children: [
                    Text(
                      'USER DATA',
                      style: TextStyle(
                        fontSize: isSmall ? 35 : 50,
                        color: Color(0xFF2C39B8),
                        shadows: [
                          Shadow(
                            offset: Offset(4, 4),
                            blurRadius: 6.0,
                            color: Color.fromRGBO(24, 45, 163, 0.25),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: isSmall ? 70 : 100,
                          backgroundColor: Colors.grey[300],
                          backgroundImage:
                              choice != -1 ? AssetImage(userPP[choice]) : null,
                          child:
                              choice == -1
                                  ? Icon(
                                    Icons.person,
                                    size: 100,
                                    color: Colors.grey[400],
                                  )
                                  : null,
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            height: isSmall ? 30 : 45,
                            width: isSmall ? 30 : 45,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1F1E5B),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 16,
                              onPressed: () {
                                changeAvatar();
                              },
                              icon: Icon(Icons.edit),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    Column(
                      children: [
                        ResponsiveTextInput(
                          isSmall: isSmall,
                          controller: form.control('fullname'),
                          hint: 'Enter Fullname',
                          label: 'Fullname',
                          type: TextInputTypes.text,
                          errorText: form.error('fullname'),
                          onChanged: () {
                            if (form.isSubmitted) {
                              setState(() {
                                form.validate();
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        ResponsivePhoneInput(
                          isSmall: isSmall,
                          country_code: country_code,
                          controller: form.control("phone"),
                          hint: 'Enter Phone Number',
                          errorText: form.error('phone'),
                          onChanged: () {
                            if (form.isSubmitted) {
                              setState(() {
                                form.validate();
                              });
                            }
                          },
                          onCountryChanged:
                              (value) => setState(() {
                                country_code = value.code;
                              }),
                        ),
                        const SizedBox(height: 10),
                        ResponsiveTextInput(
                          isSmall: isSmall,
                          controller: form.control("password"),
                          hint: 'Enter Password',
                          label: 'Password',
                          type: TextInputTypes.password,
                          errorText: form.error('password'),
                          onChanged: () {
                            if (form.isSubmitted) {
                              setState(() {
                                form.validate();
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        ResponsiveTextInput(
                          isSmall: isSmall,
                          controller: form.control("conpassword"),
                          hint: 'Enter Confirm Password',
                          label: 'Confirm Password',
                          type: TextInputTypes.password,
                          errorText: form.error('conpassword'),
                          onChanged: () {
                            if (form.isSubmitted) {
                              setState(() {
                                form.validate();
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: isSmall ? 50 : 100),

                    //Continue Button
                    ResponsiveButton(
                      isSmall: isSmall,
                      isLoading: form.isLoading,
                      onPressed: () {
                        bool isValid = false;
                        setState(() {
                          form.isSubmitted = true;
                          isValid = form.validate();
                        });
                        if (isValid) {
                          setState(() => form.isLoading = true);
                          Future.delayed(const Duration(seconds: 2), () {
                            userProvider.registerUser(
                              email: widget.email,
                              profile_pic: choice == -1 ? null : userPP[choice],
                              fullname: form.control("fullname").text,
                              country_code: country_code,
                              phone: form.control("phone").text,
                              password: form.control("password").text,
                            );
                            setState(() => form.isLoading = false);
                            showFlexibleSnackbar(
                              context,
                              "Welcome to ParkID, ${form.control("fullname").text.split(" ")[0]}!",
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainLayout(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          });
                        }
                      },
                      text: "Register",
                    ),
                    SizedBox(height: isSmall ? 10 : 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
