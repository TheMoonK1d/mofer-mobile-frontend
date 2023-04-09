import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Utils/dialog.dart';
import '../Views/login.dart';

class SignUp {
  final BuildContext context;
  SignUp(String email, String password, this.context);
  Future signUp (context, String email, password) async {
    loadingDialog(context);
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e){
      debugPrint(e.toString());
    }
    if (context.mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
    }
  }
}