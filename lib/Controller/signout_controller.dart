import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SignOut {
  final BuildContext context;
  SignOut(this.context);
  final FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    await auth.signOut();
    if(context.mounted){
      Navigator.pop(context);
    }
  }
}