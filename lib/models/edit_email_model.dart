import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mofer/Views/verify_email_change_page.dart';

class EditEmailModel {
  updateEmail(email, uid, context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
    debugPrint("$email  $uid");
    final Map<String, String> order = {"email": email, "uid": uid};
    final http.Response response = await http.put(
      Uri.parse('http://192.168.1.2:5000/c/update_email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
    } else {
      debugPrint(response.body);
      debugPrint('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }
}
