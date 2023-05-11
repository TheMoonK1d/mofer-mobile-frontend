import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mofer/Views/main_page.dart';

var order_time;

class OTPModel {
  BuildContext context;
  OTPModel(this.context);
  otpVerification(order_id, token, pin, uid, id) async {
    debugPrint("OTP.....................");
    debugPrint(uid);
    final Map<String, String> order = {
      'otp': pin,
      'order_id': order_id,
    };
    final http.Response response = await http.post(
      Uri.parse('http://192.168.1.2:7000/order/verify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': '$token',
      },
      body: jsonEncode(order),
    );

    if (response.statusCode == 200) {
      debugPrint('successful');
      debugPrint(response.body);
      final result = jsonDecode(response.body);
      order_time = result['order_time'];
      debugPrint(order_time);
      String dateString = order_time;
      DateTime date = DateTime.parse(dateString);
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      addSub(order_id, uid, formattedDate, id);
      debugPrint("Navigating to home page");
      if (context.mounted) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      }
    } else {
      debugPrint(response.body);
      debugPrint('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }

  addSub(String order_id, uid, formattedDate, id) async {
    debugPrint("Adding sub.....................");
    debugPrint("UID: $uid, Order id: $order_id, ID: $id, Date: $formattedDate");
    final Map<String, String> order = {
      'customer_uid': uid,
      'transaction_id': order_id,
      'package_id': id,
      'paid_date': formattedDate,
    };
    final http.Response response = await http.post(
      Uri.parse('http://192.168.1.2:5000/ss/addSub'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(order),
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
    } else {
      debugPrint(response.body);
      debugPrint('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }

  resendOTP(token) async {
    debugPrint("Resending OTP");
    final http.Response response = await http.post(
      Uri.parse('http://192.168.1.2:7000/order/resend_OTP'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      debugPrint('Resent!');
    } else {
      debugPrint(response.body);
      debugPrint('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }
}
