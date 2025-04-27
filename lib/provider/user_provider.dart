import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  List<Map<String, Object?>> userList = [
    {
      "email": "johndoer@gmail.com",
      "profile_pic": "assets/users/male 2.jpg",
      "fullname": "JOHN DOER",
      "country_code": "ID",
      "phone": "123456789",
      "password": "Asdf1234!",
      "birth_date": "12-02-2000",
      "gender": "male",
      "balance": 100000,
      "is_member": false,
    },
  ];

  int? currentUser = null;

  void registerUser(Map<String, Object?> userData) {
    Map<String, Object?> payload = {
      "email": userData["email"],
      "profile_pic": userData["profile_pic"],
      "fullname": userData["fullname"],
      "country_code": userData["country_code"],
      "phone": userData["phone"],
      "password": userData["password"],
      "birth_date": null,
      "gender": null,
      "balance": 0,
      "is_member": false,
    };
    userList.add(payload);
    currentUser = userList.length - 1;
  }

  int findUser(String email) {
    final index = userList.indexWhere((user) => user["email"] == email);
    return index;
  }

  int login(int index, String password) {
    if (userList[index]["password"] == password) {
      currentUser = index;
      return 1;
    }
    return -1;
  }

  void Logout() {
    currentUser = null;
  }

  Map<String, Object?> getCurrentUser() {
    final user = userList[currentUser!];
    return {
      "email": user["email"],
      "profile_pic": user["profile_pic"],
      "fullname": user["fullname"],
      "country_code": user["country_code"],
      "phone": user["phone"],
      "birth_date": user["birth_date"],
      "gender": user["gender"],
      "balance": user["balance"],
      "is_member": user["is_member"],
    };
  }

  int resetPassword(int index, String newPass) {
    bool samePass = userList[index!]["password"] == newPass;
    if (samePass) {
      return 0;
    }
    userList[index]["password"] = newPass;
    return 1;
  }

  int changePassword(String oldPass, String newPass) {
    bool passMatch = userList[currentUser!]["password"] == oldPass;
    if (!passMatch) {
      return -1;
    }
    bool samePass = userList[currentUser!]["password"] == newPass;
    if (samePass) {
      return 0;
    }
    userList[currentUser!]["password"] = newPass;
    return 1;
  }

  void editProfile({
    required String fullname,
    required String phone,
    String? birth_date,
    String? gender,
  }) {
    userList[currentUser!]["fullname"] = fullname;
    userList[currentUser!]["phone"] = phone;
    userList[currentUser!]["birth_date"] = birth_date;
    userList[currentUser!]["gender"] = gender;
  }

  void joinMember() {
    userList[currentUser!]["is_member"] = true;
  }

  void topUp(double nominal) {
    final balance = userList[currentUser!]["balance"] as double? ?? 0.0;
    userList[currentUser!]["balance"] = balance + nominal;
    notifyListeners();
  }

  void purchase(double nominal) {
    final balance = userList[currentUser!]["balance"] as double? ?? 0.0;
    userList[currentUser!]["balance"] = balance - nominal;
    notifyListeners();
  }
}
