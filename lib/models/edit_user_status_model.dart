import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Views/login.dart';

class EditUserStatusModel {
  updateUserStatus(uid, context) async {
    debugPrint("Updating user status...");
    final data = {'customer_uid': uid};
    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.put(
      Uri.parse('http://192.168.244.112:5000/api/android/update_status'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': prefs.getString("Token").toString(),
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      debugPrint("Sending $uid to API : $data");
    } else if (response.statusCode == 401) {
      if (context.mounted) {
        //loadingDialog(context);
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    } else {
      debugPrint("$uid does not exist");
    }
  }
}
