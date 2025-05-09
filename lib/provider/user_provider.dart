import 'package:flutter/foundation.dart';
import '../utils/user.dart';

class UserProvider with ChangeNotifier {
  List<User> userList = [
    User(
      email: "johndoer@gmail.com",
      profilePic: "assets/users/male 2.jpg",
      fullname: "JOHN DOER",
      countryCode: "CN",
      phone: "123456789",
      password: "Asdf1234!",
    ),
  ];

  int? currentUser;

  void registerUser({
    required String email,
    String? profile_pic,
    required String fullname,
    required String country_code,
    required String phone,
    required String password,
  }) {
    userList.add(
      User(
        email: email,
        profilePic: profile_pic,
        fullname: fullname,
        countryCode: country_code,
        phone: phone,
        password: password,
      ),
    );
    currentUser = userList.length - 1;
    notifyListeners();
  }

  int findUser(String email) {
    return userList.indexWhere((user) => user.email == email);
  }

  int login(int index, String password) {
    if (userList[index].password == password) {
      currentUser = index;
      notifyListeners();
      return 1;
    }
    return -1;
  }

  void logout() {
    currentUser = null;
    notifyListeners();
  }

  Map<String, Object?> getCurrentUser() {
    return userList[currentUser!]();
  }

  int resetPassword(int index, String newPass) {
    final result = userList[index].resetPassword(newPass);
    notifyListeners();
    return result;
  }

  int changePassword(String oldPass, String newPass) {
    final result = userList[currentUser!].changePassword(oldPass, newPass);
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
    userList[currentUser!].editProfile(
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

  void joinMember({required MemberType type, required double nominal}) {
    userList[currentUser!].joinMember(type: type, nominal: nominal);
    notifyListeners();
  }

  void topUp(double nominal) {
    userList[currentUser!].topUp(nominal);
    notifyListeners();
  }

  void purchase(double nominal) {
    userList[currentUser!].purchase(nominal);
    notifyListeners();
  }
}
