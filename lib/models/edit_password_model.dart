import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Views/login.dart';

class EditPasswordModel {
  updatePassword(password, uid, context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
    debugPrint("$password  $uid");
    final Map<String, String> order = {
      "newpassword": password,
      "customer_uid": uid
    };
    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.put(
      Uri.parse('http://192.168.244.112:5000/api/android/update_password'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': prefs.getString("Token").toString(),
      },
      body: jsonEncode(order),
    );

    if (response.statusCode == 200) {
      debugPrint('successful');
      debugPrint(response.body);

      final result = jsonDecode(response.body);
      debugPrint(result[0].toString());
      if (context.mounted) {
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    } else if (response.statusCode == 401) {
      if (context.mounted) {
        //loadingDialog(context);
        FirebaseAuth.instance.signOut();

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    } else {
      debugPrint(response.body);
      debugPrint('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }
}
