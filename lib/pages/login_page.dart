import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:media_app/helper_widgets/helper_functions.dart';
import 'package:media_app/pages/register_page.dart';
import 'package:media_app/utils/constants.dart';

import '../helper_widgets/sign_button.dart';
import '../helper_widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginUser(String email, String password) async {
    showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator(),));
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar(
          'Error Logging in',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Loggin gin',
        e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 200, child: Image.asset("assets/media.PNG")),
                InputText(
                  obscureText: false,
                  controller: emailController,
                  hintText: "Your email",
                  label: Text("Email"),
                ),
                const SizedBox(height: 10),
                InputText(
                  obscureText: true,
                  controller: passwordController,
                  hintText: "Your password",
                  label: Text("Password"),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot your password?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                SignButton(
                  onTap: () => loginUser(
                    emailController.text,
                    passwordController.text,
                  ),
                  buttonName: "Sign in",
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Not a member?",
                          style: TextStyle(color: Colors.grey, fontSize: 10)),
                      const SizedBox(width: 30),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
