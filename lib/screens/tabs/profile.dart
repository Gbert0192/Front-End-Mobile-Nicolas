import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/account/change_password.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/account/contact_us.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/account/edit_profile.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/account/subscription/subscription_page.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    final userProvider = Provider.of<UserProvider>(context);
    Map<String, Object?> user = userProvider.getCurrentUser();

    void acc_nav(Widget page) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    }

    final List<SettingButtons> acc_setting = [
      SettingButtons(
        icon: "assets/icons/key.png",
        title: "Change Password",
        onPressed: () => acc_nav(ChangePassword()),
      ),
      SettingButtons(
        icon: "assets/icons/calender.png",
        title: "Subscriptions",
        onPressed: () => acc_nav(SubscriptionPage()),
      ),
      SettingButtons(icon: "assets/icons/language.png", title: "Languages"),
    ];
    final List<SettingButtons> help_oth = [
      SettingButtons(icon: "assets/icons/question.png", title: "FAQ"),
      SettingButtons(
        icon: "assets/icons/problem.png",
        title: "Contact Us",
        onPressed: () => acc_nav(ContactUsPage()),
      ),
      SettingButtons(icon: "assets/icons/star.png", title: "Rate Our App"),
    ];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                'My Profile',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: isSmall ? 50 : 70,
                          backgroundColor: Colors.grey[300],
                          backgroundImage:
                              user['profile_pic'] != null
                                  ? AssetImage(user['profile_pic'] as String)
                                  : null,
                          child:
                              user['profile_pic'] == null
                                  ? Icon(
                                    Icons.person,
                                    size: isSmall ? 50 : 70,
                                    color: Colors.grey[500],
                                  )
                                  : null,
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user['fullname'] as String,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSmall ? 18 : 20,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user['email'] as String,
                                style: TextStyle(
                                  fontSize: isSmall ? 14 : 16,
                                  color: Colors.grey[500],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '+${user['dial_code'] ?? ''}${user['phone'] ?? ''}',
                                style: TextStyle(
                                  fontSize: isSmall ? 16 : 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: const Color(0xFF1F1E5B),
                            child: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                size: 16,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                acc_nav(
                                  EditProfile({
                                    "fullname": user["fullname"],
                                    "email": user["email"],
                                    "phone": user["phone"],
                                    "birth_date": user["birth_date"],
                                    "gender": user["gender"],
                                    "profile_pic": user["profile_pic"],
                                    "country_code": user["country_code"],
                                  }),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: isSmall ? 4 : 8,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Account Settings",
                            style: TextStyle(
                              fontSize: isSmall ? 18 : 25,
                              fontWeight: FontWeight.w400,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: acc_setting.length,
                          itemBuilder: (BuildContext context, int index) {
                            return acc_setting[index];
                          },
                        ),
                        SizedBox(height: isSmall ? 8 : 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Helps and Others",
                            style: TextStyle(
                              fontSize: isSmall ? 18 : 25,
                              fontWeight: FontWeight.w400,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: help_oth.length,
                          itemBuilder: (BuildContext context, int index) {
                            return help_oth[index];
                          },
                        ),
                        SizedBox(height: isSmall ? 8 : 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Exit the Application",
                            style: TextStyle(
                              fontSize: isSmall ? 18 : 25,
                              fontWeight: FontWeight.w400,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SettingButtons(
                          title: "Log Out",
                          tail: Icons.exit_to_app_rounded,
                          tailColor: Colors.red,
                          textColor: Colors.red,
                          bgColor: Color(0xFFFFDCDC),
                        ),
                        SizedBox(height: isSmall ? 10 : 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingButtons extends StatelessWidget {
  const SettingButtons({
    super.key,
    this.icon,
    required this.title,
    this.onPressed,
    this.tail = Icons.arrow_right_sharp,
    this.bgColor = const Color(0xFFEDF4FF),
    this.textColor = Colors.black,
    this.iconColor = Colors.black,
    this.tailColor = Colors.black,
  });

  final Object? icon;
  final String title;
  final IconData tail;
  final Color bgColor;
  final Color textColor;
  final Color tailColor;
  final Color iconColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isSmall ? 4 : 8),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 12 : 16,
            vertical: isSmall ? 10 : 12,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 6,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon != null
                      ? icon is String
                          ? Image.asset(
                            icon! as String,
                            scale: isSmall ? 32 : 25,
                          )
                          : Icon(
                            icon! as IconData,
                            size: isSmall ? 24 : 28,
                            color: iconColor,
                          )
                      : SizedBox.shrink(),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: isSmall ? 16 : 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Icon(tail, color: tailColor),
            ],
          ),
        ),
      ),
    );
  }
}
