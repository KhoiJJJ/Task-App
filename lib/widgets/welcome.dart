import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:task_app/auth/sign_in.dart';
import 'package:task_app/auth/sign_up.dart';
import 'package:task_app/constant/routes.dart';
import 'package:task_app/firebase/firebase_auth.dart';
import 'package:task_app/screens/bottom_bar.dart';
import 'package:task_app/widgets/primary_button.dart';
import 'package:task_app/widgets/small_text.dart';

import '../constant/show_message.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (auth.currentUser != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomBar()),
            (route) => false);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 50,
            ),
            const Text('W E L C O M E'),
            Center(
                child: Image.asset(
              "assets/task-welcome.jpg",
            )),
            const SizedBox(
              height: 18,
            ),
            PrimaryButton(
              title: 'Login',
              onPressed: () {
                Routes.instance
                    .push(widget: const SignInPage(), context: context);
              },
            ),
            const SizedBox(
              height: 18,
            ),
            PrimaryButton(
              title: 'Sign up',
              onPressed: () {
                Routes.instance
                    .push(widget: const SignUpPage(), context: context);
              },
            ),
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SmallText(
                    text: 'Or you can login by these methods',
                    color: Colors.grey[800],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SignInButton(
                    Buttons.Google,
                    text: "Sign up with Google",
                    onPressed: () {
                      AuthenticationProvider().signInWithGoogle().then((value) {
                        showMessage("You logged in");
                        Routes.instance.pushAndRemoveUntil(
                            widget: const BottomBar(), context: context);
                      }).catchError((e) {
                        showMessage(e.toString());
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  SmallText(
                      text: 'By signing in you are agreeing to our',
                      color: Colors.grey[800]),
                  SmallText(
                    text: 'Term and Privacy Policy',
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
