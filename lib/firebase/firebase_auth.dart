import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_app/constant/show_message.dart';
import 'package:task_app/model/user.dart';

class AuthenticationProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Sign out user
  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn(scopes: <String>['email']).signOut();
    return 'Sign Out success';
  }

  // Sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await _firebaseAuth.signInWithCredential(credential);
  }

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      showMessage('You email or password is incorrect');
      rethrow;
    }
  }

  Future<bool> signUpWithEmailAndPassword(String email, String name,
      String phone, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          name: name,
          email: email,
          phone: phone,
          image: null);
      _firestore
          .collection("users")
          .doc(userCredential.user!.email)
          .set(userModel.toJson());
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> changePassword(String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      _firebaseAuth.currentUser!.updatePassword(password);
      // UserCredential userCredential = await _firebaseAuth
      //     .createUserWithEmailAndPassword(email: email, password: password);
      // UserModel userModel = UserModel(
      //     id: userCredential.user!.uid,
      //     name: name,
      //     email: email,
      //     phone: phone,
      //     image: null);
      // _firestore.collection("users").doc(userModel.id).set(userModel.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      showMessage("Password changed");
      Navigator.of(context).pop();

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
