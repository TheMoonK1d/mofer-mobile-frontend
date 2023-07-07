import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mofer/Utils/dialog.dart';
import 'package:mofer/Views/check_status.dart';
import 'package:mofer/Auth/token.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String? error;
String? _uid;

class Login {
  Future signIn(BuildContext context, String email, String password) async {
    debugPrint("Logging in.......");
    loadingDialog(context);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      getToken();
      debugPrint("Navigating to CheckStatus Page...");
      navToHome(context);
      // if (context.mounted) {
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => const CheckStatus()));
      //
      //   // Navigator.pushReplacement(context,
      //   //     MaterialPageRoute(builder: (context) => const CheckStatus()));
      // }
    } on FirebaseAuthException catch (e) {
      error = e.message;
      debugPrint("E.msg $error");
      debugPrint(e.toString());
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("⚠ $error"),
      ));
    }
    // if (context.mounted) {
    //   Navigator.pop(context);
    // }
  }
}

getToken() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    _uid = user.uid;
  }
  debugPrint("Sending uid");
  final data = {'uid': _uid};
  final http.Response response = await http.post(
    Uri.parse('http://192.168.1.100:5000/api/android/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    debugPrint("Sending $_uid to API : $data");
    debugPrint("getting Token...");
    var apiToken = jsonDecode(response.body);
    token = apiToken['Authorization'];
    Token saveToken = Token();
    saveToken.localSave(token);
    final pref = await SharedPreferences.getInstance();
    await pref.setString('Tracking', 0.toString());
    debugPrint(token);
  } else {
    debugPrint("$_uid does not exist");
  }
}

navToHome(context){
  debugPrint("please just f***ing work");
  Navigator.pop(context);
  if (context.mounted) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CheckStatus()));

    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) => const CheckStatus()));
  }
}