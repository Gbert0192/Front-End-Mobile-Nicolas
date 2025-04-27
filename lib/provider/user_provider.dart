import 'package:flutter/foundation.dart';
import '../utils/user.dart';

class UserProvider with ChangeNotifier {
  List<User> userList = [
    User(
      email: "johndoer@gmail.com",
      profilePic: "assets/users/male 2.jpg",
      fullname: "JOHN DOER",
      countryCode: "ID",
      phone: "123456789",
      password: "Asdf1234!",
      birthDate: "12-02-2000",
      gender: "male",
      balance: 100000,
      isMember: false,
    ),
  ];

  int? currentUser;

  void registerUser(Map<String, Object?> userData) {
    userList.add(
      User(
        email: userData["email"] as String,
        profilePic: userData["profile_pic"] as String?,
        fullname: userData["fullname"] as String,
        countryCode: userData["country_code"] as String,
        phone: userData["phone"] as String,
        password: userData["password"] as String,
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
    required String phone,
    String? birthDate,
    String? gender,
  }) {
    userList[currentUser!].editProfile(
      newFullname: fullname,
      newPhone: phone,
      newBirthDate: birthDate,
      newGender: gender,
    );
    notifyListeners();
  }

  void joinMember() {
    userList[currentUser!].joinMember();
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
