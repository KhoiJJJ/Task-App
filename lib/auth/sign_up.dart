import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/auth/sign_in.dart';
import 'package:task_app/constant/routes.dart';
import 'package:task_app/constant/show_message.dart';
import 'package:task_app/firebase/firebase_auth.dart';
import 'package:task_app/screens/bottom_bar.dart';

import 'package:task_app/widgets/primary_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isShowPassword = true;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
                children: <Widget>[
                  FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: const Text(
                        "Create an account",
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
                    children: [
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
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.person_outline),
                                        hintText: "Name",
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
                                    controller: _phoneController,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.phone),
                                        hintText: "Phone",
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
                          duration: const Duration(milliseconds: 1500),
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1600),
                          child: PrimaryButton(
                            title: 'Sign Up',
                            onPressed: () async {
                              bool isValidated = signUpValidation(
                                _emailController.text,
                                _nameController.text,
                                _phoneController.text,
                                _passwordController.text,
                              );
                              if (isValidated) {
                                bool isLogined = await AuthenticationProvider()
                                    .signUpWithEmailAndPassword(
                                        _emailController.text,
                                        _nameController.text,
                                        _passwordController.text,
                                        _phoneController.text,
                                        context);
                                if (isLogined) {
                                  // ignore: use_build_context_synchronously
                                  Routes.instance.pushAndRemoveUntil(
                                      widget: const BottomBar(),
                                      context: context);
                                }
                              }
                            },
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
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
                                  widget: const SignInPage(), context: context);
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      )
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
