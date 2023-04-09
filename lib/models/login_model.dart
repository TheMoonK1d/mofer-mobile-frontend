import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mofer/Utils/dialog.dart';

class Login {
  Future signIn(BuildContext context, String email, String password) async {
    loadingDialog(context);
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim()
      );
    } on FirebaseAuthException catch (e){
      debugPrint(e.toString());
    }
    Navigator.pop(context);
  }
}