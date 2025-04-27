import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/phone_input.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';
import 'package:tugas_front_end_nicolas/screens/home.dart';
import 'package:tugas_front_end_nicolas/utils/snackbar.dart';
import 'package:tugas_front_end_nicolas/utils/validator.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  bool isSubmitted = false;
  bool isLoading = false;
  bool showIcon = false;

  ImageProvider? profileImage;

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

  void changeAvatar() {
    setState(() {
      if (showIcon) {
        profileImage = AssetImage('assets/users/female 1.jpg');
        showIcon = false;
      } else {
        profileImage = null;
        showIcon = true;
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
      minLength: 8,
      maxLength: 17,
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
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: profileImage,
                          child:
                              showIcon
                                  ? Icon(
                                    Icons.person,
                                    size: 75,
                                    color: Colors.grey[400],
                                  )
                                  : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: IconButton(
                              onPressed: () {
                                changeAvatar();
                              },
                              icon: Icon(Icons.edit, size: 12),
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
                          controller: FieldControls["phone"],
                          errorText: FieldErrors["phone"],
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
                    SizedBox(height: 50),

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
                            setState(() => isLoading = false);
                            showFlexibleSnackbar(
                              context,
                              "Welcome to ParkID, User!",
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
                      text: "Continue",
                    ),
                    SizedBox(height: 20),
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
