import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
            ],
          ),
        ),
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  const SettingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
