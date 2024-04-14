import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_reminder/screens/auth/login_screen.dart';
// import 'package:stock_reminder/screens/login_screen.dart';

class AuthService {
  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<String> registerUser(
      String email, String password, String name) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.uid)
            .set({
          'name': name,
          'email': email,
          'userId': value.user!.uid,
          "imageUrl": ""
        });
      });
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      return "Unknown error occured";
    }
    return "";
  }

  Future<String> signInUser(String email, String password) async {
    log("Hola");
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      return e.message!;
    } catch (e) {
      log("Unknown error occured");
      return "Unknown error occured";
    }
    return "";
  }

  logout(BuildContext context) async {
    try {
      FirebaseAuth.instance.signOut().then((value) =>
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName));
    } catch (e) {
      log(e.toString());
    }
  }
}
