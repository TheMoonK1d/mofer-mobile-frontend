import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mofer/Utils/dialog.dart';
import 'package:mofer/Views/check_status.dart';

class Login {
  String? error;
  Future signIn(BuildContext context, String email, String password) async {
    debugPrint("Logging in.......");
    loadingDialog(context);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      debugPrint("Navigating to CheckStatus Page...");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CheckStatus()));
    } on FirebaseAuthException catch (e) {
      error = e.message;
      debugPrint("E.msg $error");
      debugPrint(e.toString());
      // Utils.showSnackBar(error);
      Navigator.pop(context);
    }
  }
}
