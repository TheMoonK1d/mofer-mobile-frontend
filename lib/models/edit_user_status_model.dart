import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditUserStatusModel {
  updateUserStatus(uid) async {
    debugPrint("Updating user status...");
    final data = {'customer_uid': uid};
    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.put(
      Uri.parse('http://192.168.1.2:5000/api/android/update_status'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': prefs.getString("Token").toString(),
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      debugPrint("Sending $uid to API : $data");
    } else {
      debugPrint("$uid does not exist");
    }
  }
}
