import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';

class LanguageModal extends StatefulWidget {
  const LanguageModal(this.value, {super.key});
  final String value;

  @override
  State<LanguageModal> createState() => _LanguageModalState();
}

class _LanguageModalState extends State<LanguageModal> {
  final List<Language> languages = [
    Language('Bahasa Indonesia', 'ID'),
    Language('English', 'EN'),
    Language('中文', 'CN'),
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    User user = userProvider.currentUser!;
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: isSmall ? 40 : 50,
            height: isSmall ? 5 : 7,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 223, 223),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          Text(
            'Switch Language',
            style: TextStyle(
              fontSize: isSmall ? 20 : 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: isSmall ? 5 : 10),
          Divider(
            indent: isSmall ? 10 : 12,
            thickness: isSmall ? 1.5 : 2.2,
            color: const Color.fromARGB(255, 223, 223, 223),
          ),
          SizedBox(height: isSmall ? 15 : 22),

          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFE2EDFF),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(64),
                  blurRadius: 6,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                ...languages.map((lang) {
                  final isSelected = user.language == lang.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: GestureDetector(
                      onTap: () {
                        userProvider.switchLanguage(lang.value);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(64),
                              blurRadius: 6,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/others/${lang.value.toLowerCase()}.png',
                              width: isSmall ? 24 : 36,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "${lang.label} (${lang.value})",
                                style: TextStyle(
                                  fontSize: isSmall ? 14 : 18,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: Colors.lightGreenAccent,
                                size: isSmall ? 20 : 28,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Language {
  Language(this.label, this.value);
  final String label;
  final String value;
}
