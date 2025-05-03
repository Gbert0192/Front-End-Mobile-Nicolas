import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final List<SettingButtons> acc_setting = [
    SettingButtons(icon: "assets/icons/key.png", title: "Change Password"),
    SettingButtons(icon: "assets/icons/calender.png", title: "Subscriptions"),
    SettingButtons(icon: "assets/icons/language.png", title: "Languages"),
  ];
  final List<SettingButtons> help_oth = [
    SettingButtons(icon: "assets/icons/question.png", title: "FAQ"),
    SettingButtons(icon: "assets/icons/problem.png", title: "Contact Us"),
    SettingButtons(icon: "assets/icons/star.png", title: "Rate Our App"),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    final userProvider = Provider.of<UserProvider>(context);
    Map<String, Object?> user = userProvider.getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      radius: isSmall ? 40 : 70,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                          user['profile_pic'] != null
                              ? AssetImage(user['profile_pic'] as String)
                              : null,
                      child:
                          user['profile_pic'] == null
                              ? Icon(
                                Icons.person,
                                size: isSmall ? 40 : 70,
                                color: Colors.grey[500],
                              )
                              : null,
                    ),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user['fullname'] as String ?? 'Unknown Name',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user['email'] as String ?? '-',
                            style: TextStyle(
                              fontSize: isSmall ? 12 : 16,
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
                            // Handle edit
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Account Settings",
                        style: TextStyle(
                          fontSize: 25,
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
                      itemCount: acc_setting.length,
                      itemBuilder: (BuildContext context, int index) {
                        return acc_setting[index];
                      },
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Helps and Others",
                        style: TextStyle(
                          fontSize: 25,
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
                      itemCount: help_oth.length,
                      itemBuilder: (BuildContext context, int index) {
                        return help_oth[index];
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingButtons extends StatelessWidget {
  const SettingButtons({
    required this.icon,
    required this.title,
    this.tail = Icons.arrow_right_sharp,
    this.bgColor = const Color(0xFFEDF4FF),
  });

  final String icon;
  final String title;
  final IconData tail;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                Image.asset(icon, scale: isSmall ? 20 : 25),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isSmall ? 14 : 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Icon(tail),
          ],
        ),
      ),
    );
  }
}
