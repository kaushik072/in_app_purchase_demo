import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../controller/login_controller.dart';
import '../../core/user_handling.dart';
import '../../model/userdata_model.dart';

LoginController loginController = Get.put(LoginController());

final CollectionReference emailUsers =
    FirebaseFirestore.instance.collection('user');

final CollectionReference subscription =
FirebaseFirestore.instance.collection('subscription');

signupWithEmail(String email, String password) async {
  User? user;
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    user = userCredential.user!;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      EasyLoading.showError('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      EasyLoading.showError('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
  return user;
}
LoginWithEmail(String emailValue, String passwordValue) async {
  String? Id;
  try {
    final credentialValue = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailValue, password: passwordValue);
    Id = credentialValue.user!.uid;
  } on FirebaseAuthException catch (err) {
    if (err.code == "User not show here") {
      EasyLoading.showError("Not valid user email");
    } else if (err.code == "Please check the password value") {
      EasyLoading.showError("Please check the password value");
    }
  }
  return Id;
}

getUserData(String Uid) async {
  Map<String, dynamic>? documentData;

  await emailUsers.where('userId', isEqualTo: Uid).get().then((event) {
    if (event.docs.isNotEmpty) {
      documentData = event.docs.single.data() as Map<String, dynamic>?;
    }
  }).catchError((e) => null);
  return documentData;
}

Future<Map<String, dynamic>> getSubscriptionData(String uid) async {
  DocumentSnapshot data = await  subscription.doc(uid).get();
  print('subscription data :: ${data.data()}');
  return (data.data() as Map<String, dynamic>? ) ?? {};
}

loginEmail() async {
  EasyLoading.show(status: "Please wait!");

  loginController. iD = await LoginWithEmail(
      loginController.txtEmail.text, loginController.txtPassword.text);
  if (loginController.iD != null) {
    Map<String, dynamic>? userData = await getUserData(loginController.iD ?? "");
    print("UserData :: ${userData}");
    Helper.setUserData(userData!);
    isDataAlreadyAvailable(loginController.iD??'');
  }
  EasyLoading.dismiss();
}


registerUserInFireStore(String userID, UserDataModel userDataModel) async {
  DocumentReference documentReferencer = emailUsers.doc(userID);

  await documentReferencer
      .set(userDataModel.toJson())
      .whenComplete(() => print("Yehhh.....new  user register!!"))
      .catchError((e) => print("Error get here : $e"));
}