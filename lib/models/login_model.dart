import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mofer/Utils/dialog.dart';
import 'package:mofer/Views/check_status.dart';
import 'package:mofer/Auth/token.dart';
import 'package:http/http.dart' as http;

class Login {
  String? error;
  Future signIn(BuildContext context, String email, String password) async {
    debugPrint("Logging in.......");
    loadingDialog(context);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      getToken();
      debugPrint("Navigating to CheckStatus Page...");

      if (context.mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CheckStatus()));
      }
    } on FirebaseAuthException catch (e) {
      error = e.message;
      debugPrint("E.msg $error");
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("⚠ $error"),
      ));
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}

getToken() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    uid = user.uid;
  }
  debugPrint("Sending uid");
  final data = {'uid': uid};
  final http.Response response = await http.post(
    Uri.parse('http://192.168.1.2:5000/c/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    debugPrint("Sending $uid to API : $data");
    debugPrint("getting Token...");
    var _token = jsonDecode(response.body);
    token = _token['Authorization'];
    Token saveToken = Token();
    saveToken.localSave(token);
  } else {
    debugPrint("$uid does not exist");
  }
}
