import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:media_app/models/user.dart' as model;
import 'package:media_app/pages/home_page.dart';
import 'package:media_app/pages/login_page.dart';
import 'package:media_app/utils/constants.dart';

class AuthController extends GetxController {
  late Rx<User?> _user;
  static AuthController instance = Get.find();
  User get user => _user.value!;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user){
    if(user == null){
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => const HomePage());
    }

  }

  // void loginUser(String email, String password) async {
  //   showDialog(context: Get.overlayContext!, builder: (context) => const Center(child: CircularProgressIndicator(),));
  //   try {
  //     if (email.isNotEmpty && password.isNotEmpty) {
  //       await firebaseAuth.signInWithEmailAndPassword(
  //           email: email, password: password);
  //     } else {
  //       Get.snackbar(
  //         'Error Logging in',
  //         'Please enter all the fields',
  //       );
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error Loggin gin',
  //       e.toString(),
  //     );
  //   }
  // }

  void registerUser(String username, String email, String password) async {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        model.User user = model.User(
          name: username,
          email: email,
          uid: cred.user!.uid,
        );
        await firebaseStore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar("Error creating account", "Please enter all fields");
      }
    } catch (e) {
      Get.snackbar("Error creating account", e.toString());
    }
  }
}
