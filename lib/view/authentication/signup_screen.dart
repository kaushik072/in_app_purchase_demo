import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase_demo/view/authentication/signin_screen.dart';
import '../../common/button.dart';
import '../../common/data_object.dart';
import '../../common/flutter_toast.dart';
import '../../common/text_field.dart';
import '../../common/validator.dart';
import '../../controller/signup_controller.dart';
import '../../core/user_handling.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/string.dart';
import '../../subscription_page.dart';
import 'email_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignupController signupController = Get.put(SignupController());
  GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(20),
        child: Obx(() {
          return Center(
            child: Form(
              key: _signUpFormKey,
              child: Center(
                  child: Column(
                children: [
                  const SizedBox(height: 250),
                  const Text(
                    "SignUp",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  textFormField(
                      controller: signupController.txtEmail,
                      hintText: "Email address",
                      validator: (val) {
                        return Validators.validEmail(val!);
                      },
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 20),
                  textFormField(
                      controller: signupController.txtName,
                      hintText: "Name",
                      validator: (val) {
                        return Validators.validateName(val!, "Name");
                      },
                      keyboardType: TextInputType.name),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: signupController.txtPassword,
                    obscureText: signupController.isShowPassword.value,
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
                          signupController.isShowPassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          signupController.isShowPassword.value =
                              !signupController.isShowPassword.value;
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: signupController.txtConfirmPassword,
                    autocorrect: true,
                    validator: (value) {
                      return Validators.validPassword(value!,
                          controller: signupController.txtPassword);
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'Confirm Password',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  textFormField(
                      controller: signupController.txtPhoneNumber,
                      hintText: "Mobile Number",
                      validator: (val) {
                        return Validators.validatePhoneNo(val!);
                      },
                      keyboardType: TextInputType.number),

                  ///Signup btn
                  CommonButton(
                      buttonLabel: AppStrings.signUp,
                      onTap: () async {
                        //   if (_signUpFormKey.currentState!.validate()) {}
                        userDataModel.email = signupController.txtEmail.text;
                        userDataModel.name = signupController.txtName.text;
                        userDataModel.password =
                            signupController.txtPassword.text;
                        userDataModel.confirmedPassword =
                            signupController.txtConfirmPassword.text;
                        userDataModel.mobileNumber =
                            signupController.txtPhoneNumber.text;

                        ///check the password and confirmPassword
                        if (userDataModel.password !=
                            userDataModel.confirmedPassword) {
                          getFlutterToast(
                              msg:
                                  "please check the password and confirm password not match:)",
                              isSuccess: true);
                        } else {
                          EasyLoading.show(status: 'Status.....');
                          signupController.user = await signupWithEmail(
                              userDataModel.email!, userDataModel.password!);

                          if (signupController.user?.emailVerified == false) {
                            await signupController.user
                                ?.sendEmailVerification()
                                .then((value) {
                              EasyLoading.dismiss();
                              Get.defaultDialog(
                                middleText:
                                    "Verify with the email and password..",
                                actions: [
                                  CommonButton(
                                    onTap: () {
                                      Get.to(() => const SignInScreen());
                                    },
                                    buttonLabel: AppStrings.signIn,
                                  )
                                ],
                              );
                            }).catchError((onError) {});
                          }
                          if (signupController.user != null) {
                            userDataModel.id = signupController.user!.uid;
                            registerUserInFireStore(
                                signupController.user!.uid, userDataModel);
                            Map<String, dynamic> userData =
                                await getUserData(signupController.user!.uid);
                            Helper.setUserData(userData);
                          }
                          EasyLoading.dismiss();
                        }
                      }),
                ],
              )),
            ),
          );
        }),
      )),
    );
  }
}
