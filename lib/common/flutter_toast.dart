import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../core/utils/colors.dart';

getFlutterToast({required String msg, required bool isSuccess}) {
  Fluttertoast.showToast(
      msg: msg.toString(),
      fontSize: 14.0,
      backgroundColor: (Get.theme.brightness == Brightness.dark)
          ? (isSuccess ? AppColors.whiteColor : Colors.redAccent)
          : (isSuccess ? AppColors.primaryColor : Colors.redAccent),
      textColor: isSuccess ? Colors.white :AppColors.primaryColor ,
      toastLength: Toast.LENGTH_SHORT);
}
