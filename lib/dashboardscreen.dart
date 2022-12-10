import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase_demo/view/authentication/signin_screen.dart';
import 'core/user_handling.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome IAP..")),
      body: Center(
        child: InkWell(
            onTap: () {
              Helper.clearUserData;
              Get.offAll(const SignInScreen());
            },
            child: const Text("Welcome!!!!!!!!")),
      ),
    );
  }
}
