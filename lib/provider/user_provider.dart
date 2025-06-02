import 'package:flutter/foundation.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';
import '../model/user.dart';

class UserProvider with ChangeNotifier {
  List<User> userList = [
    User(
      id: 1,
      email: "johndoer@gmail.com",
      profilePic: "assets/images/users/male 2.jpg",
      fullname: "JOHN DOER",
      countryCode: "CN",
      dialCode: "86",
      phone: "123456789",
      password: "Asdf1234!",
    ),
  ];

  User? currentUser;

  void registerUser({
    required String email,
    String? profile_pic,
    required String fullname,
    required String country_code,
    required String phone,
    required String password,
  }) {
    final String dialCode =
        countries
            .firstWhereOrNull((item) => item.code == country_code)!
            .dialCode;
    final newUser = User(
      id: userList.length + 1,
      email: email,
      profilePic: profile_pic,
      fullname: fullname,
      countryCode: country_code,
      dialCode: dialCode,
      phone: phone,
      password: password,
    );
    userList.add(newUser);
    currentUser = newUser;
    notifyListeners();
  }

  User? findUserByEmail(String email) {
    final user = userList.firstWhereOrNull((u) => u.email == email);
    return user;
  }

  int login(int id, String password) {
    final user = userList.firstWhereOrNull((u) => u.id == id);
    if (user != null && user.password == password) {
      currentUser = user;
      notifyListeners();
      return 1;
    }
    return -1;
  }

  void logout() {
    currentUser = null;
    notifyListeners();
  }

  int resetPassword(int id, String newPass) {
    final user = userList.firstWhereOrNull((u) => u.id == id);
    if (user == null) return -1;
    final result = user.resetPassword(newPass);
    notifyListeners();
    return result;
  }

  void rateApp(int rate) {
    currentUser?.rateApp(rate);
    notifyListeners();
  }

  void switchLanguage(String lang) {
    currentUser?.switchLanguage(lang);
    notifyListeners();
  }

  int changePassword(String oldPass, String newPass) {
    final result = currentUser?.changePassword(oldPass, newPass) ?? -1;
    notifyListeners();
    return result;
  }

  void editProfile({
    required String fullname,
    required String email,
    required String phone,
    required String countryCode,
    String? birthDate,
    String? gender,
    String? profilePic,
  }) {
    currentUser?.editProfile(
      newFullname: fullname,
      newEmail: email,
      newPhone: phone,
      newCountryCode: countryCode,
      newBirthDate: birthDate,
      newGender: gender,
      newProfilePic: profilePic,
    );
    notifyListeners();
  }

  int joinMember({required MemberType type, required double nominal}) {
    final result = currentUser?.joinMember(type: type, nominal: nominal) ?? -1;
    notifyListeners();
    return result;
  }

  void topUp(double nominal) {
    currentUser?.topUp(nominal);
    notifyListeners();
  }

  void purchase(double nominal) {
    currentUser?.purchase(nominal);
    notifyListeners();
  }
}
