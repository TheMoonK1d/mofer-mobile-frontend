import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mofer/Views/verify_email_change_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Views/login.dart';

class EditEmailModel {
  updateEmail(email, uid, context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
    debugPrint("$email  $uid");
    final Map<String, String> order = {"email": email, "uid": uid};
    final prefs = await SharedPreferences.getInstance();
    final http.Response response = await http.put(
      Uri.parse('http:// 192.168.11.112:5000/api/android/update_email'),
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => VerifyEmailChange(
                      email: email,
                    ))));
      }
    }else if (response.statusCode == 401) {
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
