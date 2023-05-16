import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditNameModel {
  updateName(fName, lName, uid, context) async {
    debugPrint("Updating name");
    debugPrint("$fName $lName $uid");
    final Map<String, String> order = {
      "customer_fname": fName,
      "customer_lname": lName,
      "customer_uid": uid
    };
    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.put(
      Uri.parse('http://192.168.1.2:5000/api/android/update_user_name'),
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
        Navigator.pop(context);
      }
    } else {
      debugPrint(response.body);
      debugPrint('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }
}
