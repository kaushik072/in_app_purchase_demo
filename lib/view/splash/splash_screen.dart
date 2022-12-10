import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/user_handling.dart';
import '../authentication/signin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    Map<String, dynamic>? userData = Helper.checkLogIn();
    if (userData != {} && userData != null) {
      await isDataAlreadyAvailable(userData['userId']);
    } else {
      Future.delayed(const Duration(milliseconds: 10))
          .then((value) => Get.offAll(const SignInScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
