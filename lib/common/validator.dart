import 'package:flutter/cupertino.dart';

class Validators {
  static String? validateName(String value, String title) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "$title is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Enter must be a-z and A-Z";
    }
    return null;
  }

  static String? validateRequired(
    String value,
  ) {
    if (value.isEmpty) {
      return "Please Enter Value123";
    }
    return null;
  }

  static String? validatePhoneNo(String value) {
    if (value.length != 10) {
      return 'Mobile Number must be of 10 digit';
    }
    return null;
  }

  static String? validEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Enter Valid Email";
    }
    return null;
  }

  static String? validPassword(String value,
      {TextEditingController? controller}) {
    if (value.isEmpty || value != controller!.text) {
      return "Field is empty";
    }
    return null;
  }

  static String? validatePassword(String value) {
    String pattern =
        r'^.*(?=.{8,})((?=.*[!@#$%^&*()\-_=+{};:,<.>]){1})(?=.*\d)((?=.*[a-z]){1})((?=.*[A-Z]){1}).*$';
    RegExp regExp = RegExp(pattern);

    debugPrint("----value----- (${value.toString()})");
    if (value.isEmpty) {
      debugPrint("----value111----- (${value.toString()})");
      return "Password is Required";
    } else if (!regExp.hasMatch(value)) {
      debugPrint("----value222----- (${value.toString()})");
      return "enter strong Password";
    } else {
      debugPrint("----value----- (${value.toString()})");
      return null;
    }
  }
}
