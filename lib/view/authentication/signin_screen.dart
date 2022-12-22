import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/button.dart';
import '../../common/text_style.dart';
import '../../core/user_handling.dart';
import '../../core/utils/colors.dart';
import '../../common/text_field.dart';
import '../../common/validator.dart';
import '../../controller/login_controller.dart';
import '../../core/utils/string.dart';
import 'email_service.dart';
import 'signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as f_auth;

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  f_auth.FirebaseAuth auth = f_auth.FirebaseAuth.instance;

  LoginController loginController = Get.put(LoginController());

  final GlobalKey<FormState> _loginformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Obx(() {
            return Center(
              child: Form(
                key: _loginformKey,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 250),
                      const Text(
                        "Login",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      textFormField(
                          controller: loginController.txtEmail,
                          hintText: "Email address",
                          validator: (val) {
                            return Validators.validEmail(val!);
                          },
                          keyboardType: TextInputType.emailAddress),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: loginController.txtPassword,
                        obscureText: loginController.isShowPassword.value,
                        autocorrect: true,
                        validator: (value) {
                          return Validators.validatePassword(value!);
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              loginController.isShowPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              loginController.isShowPassword.value =
                                  !loginController.isShowPassword.value;
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      ///Login button
                      CommonButton(
                          buttonLabel: AppStrings.login,
                          onTap: () {
                            loginEmail();
                          }),
                      const SizedBox(height: 20),

                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Get.to(() => const SignUpScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: AppStrings.signUpAlertString,
                                style: greyColor18,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: AppStrings.signUp,
                                      style: primaryColorBold18),
                                ],
                              ),
                            ),
                            SizedBox(width: 20,),
                            InkWell(
                                onTap: () async {
                                  Helper.clearUserData();
                                  await FirebaseAuth.instance.signOut();
                                },
                                child: const Text("LogOut"))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
