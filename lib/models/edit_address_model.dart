import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditAddressModel {
  updateAddress(address_id, city, street, kebele, uid, context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
    //debugPrint("$password  $uid");
    final Map<String, dynamic> order = {
      "address_id": address_id,
      "city": city,
      "street": street,
      "kebele": kebele,
      "customer_uid": uid
    };
    final prefs = await SharedPreferences.getInstance();
    final http.Response response = await http.put(
      Uri.parse('http://192.168.1.2:5000/api/android/update_address'),
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
