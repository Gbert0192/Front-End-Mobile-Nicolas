class User {
  int id;
  String email;
  String? profilePic;
  String fullname;
  String countryCode;
  String dialCode;
  String phone;
  String password;
  String? birthDate;
  String? gender;
  int? rating;
  double balance = 10000000;
  bool isMember = false;
  bool twoFactor = false;
  DateTime? memberSince;
  DateTime? memberUntil;

  User({
    required this.id,
    required this.email,
    this.profilePic,
    required this.fullname,
    required this.countryCode,
    required this.dialCode,
    required this.phone,
    required this.password,
  });

  User call() {
    return this;
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

  void rateApp(int rate) {
    rating = rate;
  }

  void setUp2Fac() {
    twoFactor = true;
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
    if (purchase(nominal) == -1) return -1;
    memberSince = DateTime.now();
    switch (type) {
      case MemberType.monthly:
        memberUntil = DateTime.now().add(Duration(days: 30));
        break;

      case MemberType.seasonal:
        memberUntil = DateTime.now().add(Duration(days: 90));
        break;

      case MemberType.annual:
        memberUntil = DateTime.now().add(Duration(days: 365));
        break;
    }
    isMember = true;
    return 1;
  }

  bool checkStatusMember() {
    if (memberUntil == null) {
      isMember = false;
      return false;
    }
    if (DateTime.now().isAfter(memberUntil!)) {
      isMember = false;
      return false;
    }
    isMember = true;
    return true;
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
