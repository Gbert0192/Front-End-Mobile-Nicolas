import 'dart:math';
import 'package:flutter/foundation.dart';

class ForgetPassProvider with ChangeNotifier {
  int? OTP = null;
  String email = "";

  void randomizeOTP() {
    final random = Random();
    OTP = 100000 + random.nextInt(900000);
  }

  bool validateOTP(String value) {
    bool isValid = OTP == int.parse(value);
    return isValid;
  }
}
