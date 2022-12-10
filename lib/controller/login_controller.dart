import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isShowPassword = true.obs;
  RxBool isDataAvailable = false.obs;
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  String? iD;
  bool showPassword(RxBool isPassword) {
    if (isPassword.isTrue) {
      return isPassword.value = false;
    } else {
      return isPassword.value = true;
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
