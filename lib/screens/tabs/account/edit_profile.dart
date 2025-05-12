import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/date_picker.dart';
import 'package:tugas_front_end_nicolas/components/dropdown.dart';
import 'package:tugas_front_end_nicolas/components/phone_input.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
import 'package:tugas_front_end_nicolas/utils/snackbar.dart';
import 'package:tugas_front_end_nicolas/utils/useform.dart';
import 'package:tugas_front_end_nicolas/utils/user.dart';
import 'package:tugas_front_end_nicolas/utils/validator.dart';

class EditProfile extends StatefulWidget {
  const EditProfile(this.user);
  final User user;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String country_code = "ID";

  final form = UseForm(
    fields: ["fullname", "email", "phone", "birth_date", "gender"],
    validators: {
      "fullname":
          (value) =>
              validateBasic(key: "Fullname", value: value, required: true),
      'email': (value) => validateEmail(value: value),
      "phone":
          (value) => validateBasic(
            key: "Phone Number",
            value: value,
            minLength: 7,
            maxLength: 12,
          ),
      "birth_date": (value) => validateBasic(value: value, required: false),
      "gender": (value) => validateBasic(value: value, required: false),
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

  @override
  void initState() {
    super.initState();
    final user = widget.user;
    form.control('fullname').text = (user.fullname);
    form.control('email').text = (user.email);
    form.control('phone').text = (user.phone);
    form.control('birth_date').text = (user.birthDate) ?? "";
    form.control('gender').text = (user.gender) ?? '';

    country_code = (user.countryCode);

    if (user.profilePic != null) {
      choice = userPP.indexWhere((item) => item == user.profilePic);
    }
  }

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
                      'Edit Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
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
                        ResponsiveTextInput(
                          isSmall: isSmall,
                          controller: form.control('email'),
                          hint: 'Enter Email',
                          label: 'Email',
                          type: TextInputTypes.text,
                          errorText: form.error('email'),
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
                        ResponsiveDatePicker(
                          isSmall: isSmall,
                          controller: form.control("birth_date"),
                          hint: 'Select Birth Date',
                          label: 'Birth Date',
                        ),
                        const SizedBox(height: 10),
                        ResponsiveDropdown(
                          isSmall: isSmall,
                          items: [
                            {"label": "Male", "value": "male"},
                            {"label": "Female", "value": "female"},
                          ],
                          controller: form.control("gender"),
                          hint: 'Select Gender',
                          label: 'Gender',
                        ),
                      ],
                    ),
                    SizedBox(height: isSmall ? 50 : 100),

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
                            print(choice == -1 ? null : userPP[choice]);
                            userProvider.editProfile(
                              fullname: form.control("fullname").text,
                              email: form.control("email").text,
                              phone: form.control("phone").text,
                              countryCode: country_code,
                              profilePic: choice == -1 ? null : userPP[choice],
                              birthDate:
                                  form.control("birth_date").text == ""
                                      ? null
                                      : form.control("birth_date").text,
                              gender:
                                  form.control("gender").text == ""
                                      ? null
                                      : form.control("gender").text,
                            );
                            setState(() => form.isLoading = false);
                            showFlexibleSnackbar(
                              context,
                              "Profile has been updated!",
                            );
                            Navigator.pop(context);
                          });
                        }
                      },
                      text: "Save",
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
