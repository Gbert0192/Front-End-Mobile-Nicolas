import 'package:intl_phone_field/countries.dart';

class User {
  String email;
  String? profilePic;
  String fullname;
  String countryCode;
  String phone;
  String password;
  String? birthDate;
  String? gender;
  String? lang = "EN";
  double balance = 0;
  bool isMember = false;
  String? memberSince;
  String? memberUntil;

  User({
    required this.email,
    this.profilePic,
    required this.fullname,
    required this.countryCode,
    required this.phone,
    required this.password,
  });

  Map<String, Object?> call() {
    final String? dialCode =
        countries.firstWhere((item) => item.code == countryCode).dialCode
            as String?;
    return {
      'email': email,
      'profile_pic': profilePic,
      'fullname': fullname,
      'country_code': countryCode,
      'dial_code': dialCode,
      'phone': phone,
      'birth_date': birthDate,
      'gender': gender,
      'balance': balance,
      'is_member': isMember,
      'member_since': memberSince,
      'member_until': memberUntil,
      'lang': lang,
    };
  }

  int changePassword(String oldPass, String newPass) {
    if (password != oldPass) return -1;
    if (password == newPass) return 0;
    password = newPass;
    return 1;
  }

  int resetPassword(String newPass) {
    if (password == newPass) return 0;
    password = newPass;
    return 1;
  }

  void editProfile({
    required String newFullname,
    required String newEmail,
    required String newPhone,
    required String newCountryCode,
    String? newBirthDate,
    String? newGender,
    String? newProfilePic,
  }) {
    email = newEmail;
    fullname = newFullname;
    phone = newPhone;
    countryCode = newCountryCode;
    birthDate = newBirthDate;
    gender = newGender;
    profilePic = newProfilePic;
  }

  int joinMember({required MemberType type, required double nominal}) {
    if (this.purchase(nominal) == -1) return -1;
    memberSince = DateTime.now().toString();
    switch (type) {
      case MemberType.monthly:
        memberUntil = DateTime.now().add(Duration(days: 30)).toString();
        break;

      case MemberType.seasonal:
        memberUntil = DateTime.now().add(Duration(days: 90)).toString();
        break;

      case MemberType.annual:
        memberUntil = DateTime.now().add(Duration(days: 365)).toString();
        break;
    }
    isMember = true;
    return 1;
  }

  void topUp(double nominal) {
    balance += nominal;
  }

  int purchase(double nominal) {
    if (nominal > balance) {
      return -1;
    }
    balance -= nominal;
    return 1;
  }
}

enum MemberType { monthly, seasonal, annual }
