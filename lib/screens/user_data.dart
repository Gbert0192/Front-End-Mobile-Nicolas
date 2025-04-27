import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/phone_input.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
import 'package:tugas_front_end_nicolas/screens/home.dart';
import 'package:tugas_front_end_nicolas/utils/snackbar.dart';
import 'package:tugas_front_end_nicolas/utils/validator.dart';

class UserData extends StatefulWidget {
  const UserData(this.email);
  final String email;

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  bool isSubmitted = false;
  bool isLoading = false;

  ImageProvider? profileImage;
  String country_code = "ID";

  Map<String, TextEditingController> FieldControls = {
    "fullname": TextEditingController(),
    "phone": TextEditingController(),
    "password": TextEditingController(),
    "conpassword": TextEditingController(),
  };

  Map<String, String?> FieldErrors = {
    "fullname": null,
    "phone": null,
    "password": null,
    "conpassword": null,
  };

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

  bool validate() {
    final errorFullname = validateBasic(
      key: "Fullname",
      value: FieldControls["fullname"]!.text,
      required: true,
    );
    setState(() {
      FieldErrors["fullname"] = errorFullname;
    });
    final errorPhone = validateBasic(
      key: "Phone Number",
      value: FieldControls["phone"]!.text,
      minLength: 7,
      maxLength: 12,
      required: true,
    );
    setState(() {
      FieldErrors["phone"] = errorPhone;
    });
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
    return FieldErrors["fullname"] == null &&
        FieldErrors["phone"] == null &&
        FieldErrors["password"] == null &&
        FieldErrors["conpassword"] == null;
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
                          radius: 70,
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
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.blue,
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
                          controller: FieldControls["fullname"],
                          hint: 'Enter Fullname',
                          label: 'Fullname',
                          type: TextInputTypes.text,
                          errorText: FieldErrors["fullname"],
                          onChanged: () {
                            if (isSubmitted) {
                              validate();
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        ResponsivePhoneInput(
                          isSmall: isSmall,
                          country_code: country_code,
                          hint: 'Enter Phone Number',
                          controller: FieldControls["phone"],
                          errorText: FieldErrors["phone"],
                          onChanged: () {
                            if (isSubmitted) {
                              validate();
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
                          controller: FieldControls["password"],
                          hint: 'Enter Password',
                          label: 'Password',
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
                          hint: 'Enter Confirm Password',
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
                    SizedBox(height: isSmall ? 50 : 80),

                    //Continue Button
                    ResponsiveButton(
                      isSmall: isSmall,
                      isLoading: isLoading,
                      onPressed: () {
                        isSubmitted = true;
                        final isValid = validate();
                        if (isValid) {
                          setState(() => isLoading = true);
                          Future.delayed(const Duration(seconds: 2), () {
                            userProvider.registerUser({
                              "email": widget.email,
                              "profile_pic":
                                  choice == -1 ? null : userPP[choice],
                              "fullname": FieldControls["fullname"]!.text,
                              "country_code": country_code,
                              "phone": FieldControls["phone"]!.text,
                              "password": FieldControls["password"]!.text,
                            });
                            setState(() => isLoading = false);
                            showFlexibleSnackbar(
                              context,
                              "Welcome to ParkID, ${FieldControls["fullname"]!.text.split(" ")[0]}!",
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
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
