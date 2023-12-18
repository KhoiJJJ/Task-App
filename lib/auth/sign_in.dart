import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:task_app/auth/sign_up.dart';
import 'package:task_app/constant/routes.dart';
import 'package:task_app/constant/show_message.dart';
import 'package:task_app/firebase/firebase_auth.dart';
import 'package:task_app/screens/bottom_bar.dart';
import 'package:task_app/screens/home.dart';
import 'package:task_app/widgets/primary_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange.shade900,
          Colors.orange.shade800,
          Colors.orange.shade400
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: const Text(
                        "Welcome Back",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 60,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1400),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromRGBO(225, 95, 27, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    style: const TextStyle(color: Colors.black),
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.email_outlined),
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    style: const TextStyle(color: Colors.black),
                                    controller: _passwordController,
                                    obscureText: isShowPassword,
                                    decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(Icons.password_sharp),
                                        suffixIcon: CupertinoButton(
                                            onPressed: () {
                                              setState(() {
                                                isShowPassword =
                                                    !isShowPassword;
                                              });
                                            },
                                            padding: EdgeInsets.zero,
                                            child: Icon(
                                              isShowPassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.grey,
                                            )),
                                        hintText: "Password",
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: Column(
                          children: [
                            PrimaryButton(
                              title: 'Login',
                              onPressed: () {
                                AuthenticationProvider()
                                    .signInWithEmailAndPassword(
                                        _emailController.text,
                                        _passwordController.text)
                                    .then((userCredential) {
                                  showMessage("You logged in");
                                  Routes.instance.pushAndRemoveUntil(
                                      widget: const HomePage(),
                                      context: context);
                                }).catchError((e) {
                                  showMessage(e.toString());
                                });
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Routes.instance.push(
                                        widget: const SignUpPage(),
                                        context: context);
                                  },
                                  child: const Text(
                                    'Create',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1700),
                          child: const Text(
                            "Or continue with social media",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: SignInButton(
                          Buttons.Google,
                          text: "Sign up with Google",
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          onPressed: () {
                            AuthenticationProvider()
                                .signInWithGoogle()
                                .then((value) {
                              showMessage("You logged in");
                              Routes.instance.pushAndRemoveUntil(
                                  widget: const BottomBar(), context: context);
                            }).catchError((e) {
                              showMessage(e.toString());
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
