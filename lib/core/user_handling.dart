import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_purchase_demo/subscription_page.dart';
import 'package:in_app_purchase_demo/view/authentication/email_service.dart';
import '../dashboardscreen.dart';

class Helper {
  static String userKey = "userKey";
  static GetStorage storage = GetStorage();

  static setUserData(Map<String, dynamic> documentValue) {
    storage.write(userKey, documentValue);
  }

  static Map<String, dynamic>? getUserData() {
    return storage.read(userKey);
  }

  static String getUserId() {
    Map<String, dynamic>? isUserData = getUserData();
    if (isUserData != null) {
      return isUserData['Id'];
    }
    return "";
  }

  static clearUserData() {
    return storage.remove(userKey);
  }

  static checkLogIn() {
    Map<String, dynamic>? userData = storage.read(userKey);
    return userData;
  }
}

isDataAlreadyAvailable(String uid) async {
  Map<String, dynamic> subscriptionData = await getSubscriptionData(uid);
  debugPrint('isDataAlreadyAvailable : $subscriptionData');
  if (subscriptionData.isNotEmpty) {
    debugPrint('if');
    //TODO handle it after entering data
    Get.offAll(const DashboardScreen());
  } else {
    debugPrint('else');
    Get.off(() => const SubscriptionPage());
  }
}

checkUserIsAvailable(String id) async {
  bool isAvailable = false;
  final snapShot =
      await FirebaseFirestore.instance.collection('user').doc(id).get();

  if (!snapShot.exists) {
    isAvailable = true;
  } else {
    isAvailable = false;
  }
  return isAvailable;
}
