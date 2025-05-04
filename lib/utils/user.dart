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
  String? lang;
  double balance;
  bool isMember;

  User({
    required this.email,
    this.profilePic,
    required this.fullname,
    required this.countryCode,
    required this.phone,
    required this.password,
    this.birthDate,
    this.gender,
    this.lang = "EN",
    this.balance = 0,
    this.isMember = false,
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

  void joinMember() {
    isMember = true;
  }

  void topUp(double nominal) {
    balance += nominal;
  }

  void purchase(double nominal) {
    balance -= nominal;
  }
}
