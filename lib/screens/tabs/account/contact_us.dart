import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/dropdown.dart';
import 'package:tugas_front_end_nicolas/components/phone_input.dart';
import 'dart:math' as math;

import 'package:tugas_front_end_nicolas/components/text_input.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  String? _selectedSubject;

  final List<Map<String, String>> subjects = [
    {'label': 'Support', 'value': 'support'},
    {'label': 'Feedback', 'value': 'feedback'},
    {'label': 'Membership', 'value': 'membership'},
    {'label': 'Feature Request', 'value': 'feature_request'},
    {'label': 'Complaint', 'value': 'complaint'},
    {'label': 'Other', 'value': 'other'},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top Rotated Box
          Positioned(
            top: isSmall ? -250 : -240,
            left: -100,
            child: Transform.rotate(
              angle: -15 * math.pi / 180,
              child: Container(
                width: size.width * 2,
                height: 300,
                color: const Color(0xFFD3DEFF),
              ),
            ),
          ),

          // Bottom Rotated Box
          Positioned(
            bottom: isSmall ? -250 : -240,
            right: -100,
            child: Transform.rotate(
              angle: -15 * math.pi / 180,
              child: Container(
                width: size.width * 2,
                height: 300,
                color: const Color(0xFFD3DEFF),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmall ? 12 : 24.0,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Contact Us",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F1E5B),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            ResponsiveTextInput(
                              isSmall: isSmall,
                              mode: StyleMode.underline,
                              // controller: form.control("password"),
                              hint: 'Enter Fullname',
                              label: 'Fullname',
                              // errorText: form.error('password'),
                              // onChanged: () {
                              //   if (form.isSubmitted) {
                              //     setState(() {
                              //       form.validate();
                              //     });
                              //   }
                              // },
                            ),
                            const SizedBox(height: 10),
                            ResponsiveTextInput(
                              isSmall: isSmall,
                              mode: StyleMode.underline,
                              // controller: form.control("conpassword"),
                              hint: 'Enter Email',
                              label: 'Email',
                              type: TextInputTypes.email,
                              // errorText: form.error('conpassword'),
                              // onChanged: () {
                              //   if (form.isSubmitted) {
                              //     setState(() {
                              //       form.validate();
                              //     });
                              //   }
                              // },
                            ),
                            const SizedBox(height: 10),
                            ResponsivePhoneInput(
                              isSmall: isSmall,
                              mode: StyleMode.underline,
                              // country_code: country_code,
                              // controller: form.control("phone"),
                              hint: 'Enter Phone Number',
                              label: 'Phone',
                              // errorText: form.error('phone'),
                              // onChanged: () {
                              //   if (form.isSubmitted) {
                              //     setState(() {
                              //       form.validate();
                              //     });
                              //   }
                              // },
                              // onCountryChanged:
                              //     (value) => setState(() {
                              //       country_code = value.code;
                              //     }),
                            ),
                            const SizedBox(height: 10),
                            ResponsiveDropdown(
                              isSmall: isSmall,
                              items: subjects,
                              controller: TextEditingController(),
                              mode: StyleMode.underline,
                              // country_code: country_code,
                              // controller: form.control("phone"),
                              hint: 'Enter Subject',
                              label: 'Subject',
                              // errorText: form.error('phone'),
                              // onChanged: () {
                              //   if (form.isSubmitted) {
                              //     setState(() {
                              //       form.validate();
                              //     });
                              //   }
                              // },
                            ),
                            const SizedBox(height: 10),
                            ResponsiveTextInput(
                              isSmall: isSmall,
                              mode: StyleMode.underline,
                              // country_code: country_code,
                              // controller: form.control("phone"),
                              hint: 'Enter Comment',
                              label: 'Comment',
                              // errorText: form.error('phone'),
                              // onChanged: () {
                              //   if (form.isSubmitted) {
                              //     setState(() {
                              //       form.validate();
                              //     });
                              //   }
                              // },
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildSocialIcon('assets/medsos/tiktok.png'),
                              buildSocialIcon('assets/medsos/wa.png'),
                              buildSocialIcon('assets/medsos/ig.png'),
                              buildSocialIcon('assets/medsos/yt.png'),
                              buildSocialIcon('assets/medsos/x.png'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        ResponsiveButton(
                          isSmall: isSmall,
                          // isLoading: form.isLoading,
                          onPressed: () {
                            bool isValid = false;
                            // setState(() {
                            //   form.isSubmitted = true;
                            //   isValid = form.validate();
                            // });
                          },
                          text: "Continue",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSocialIcon(String assetPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Image.asset(assetPath, height: 40, width: 40),
    );
  }
}
