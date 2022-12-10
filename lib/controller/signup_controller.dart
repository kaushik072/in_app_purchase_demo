import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  var isShowPassword = true.obs;
  RxBool isDataAvailable = false.obs;
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  TextEditingController txtPhoneNumber = TextEditingController();
  User? user;
  bool showPassword(RxBool isPassword) {
    if (isPassword.isTrue) {
      return isPassword.value = false;
    } else {
      return isPassword.value = true;
    }
  }


}
