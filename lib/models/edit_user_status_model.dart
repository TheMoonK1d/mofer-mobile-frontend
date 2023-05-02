import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class EditUserStatusModel {
  updateUserStatus(uid) async {
    debugPrint("Updating user status...");
    final data = {'customer_uid': uid};
    final http.Response response = await http.put(
      Uri.parse('http://192.168.1.2:5000/c/update_status'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
