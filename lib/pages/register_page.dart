import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:media_app/pages/login_page.dart';
import 'package:media_app/utils/constants.dart';
import '../helper_widgets/sign_button.dart';
import '../helper_widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 200, child: Image.asset("assets/media.PNG")),
                InputText(
                  obscureText: false,
                  controller: usernameController,
                  hintText: "Username",
                  label: const Text("Username"),
                ),
                const SizedBox(height: 10),
                InputText(
                  obscureText: false,
                  controller: emailController,
                  hintText: "Your email",
                  label: const Text("Email"),
                ),
                const SizedBox(height: 10),
                InputText(
                  obscureText: true,
                  controller: passwordController,
                  hintText: "Your password",
                  label: const Text("Password"),
                ),
                const SizedBox(height: 10),
                InputText(
                  obscureText: true,
                  controller: confirmPasswordController,
                  hintText: "Confirm",
                  label: const Text("Confirm password"),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 25),
                SignButton(
                  buttonName: "Sign up",
                  onTap: () => authController.registerUser(
                    usernameController.text,
                    emailController.text,
                    passwordController.text,
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Already have account?",
                          style: TextStyle(color: Colors.grey, fontSize: 10)),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 11),
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
