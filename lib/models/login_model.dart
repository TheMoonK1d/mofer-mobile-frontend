import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mofer/Utils/dialog.dart';
import 'package:mofer/Utils/error_dialog.dart';
import 'package:mofer/Utils/error_util.dart';

class Login {
  String? error;
  Future signIn(BuildContext context, String email, String password) async {
    loadingDialog(context);
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim()
      );
    } on FirebaseAuthException catch (e){

      error = e.message;
      debugPrint("E.msg $error");
      debugPrint(e.toString());

     // Utils.showSnackBar(error);

    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}