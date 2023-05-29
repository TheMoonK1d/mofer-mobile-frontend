import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mofer/Views/Bank_view/bank_otp.dart';
import 'package:mofer/Views/payment_page.dart';

import '../Views/login.dart';

var result, token, phone, order_id, uid;

class Bank {
  final BuildContext context;
  String username, password;
  Bank(this.context, this.username, this.password);
  bankLoginDataSender(String amount, id, uid) async {
    debugPrint("Ready to send");
    debugPrint("Received: $amount, $id, $uid, $username, $password");
    final Map<String, dynamic> data = {
      'username': username,
      'password': password,
    };
    final uri = Uri.http('192.168.244.112:7000', '/useraccount/login', data);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      debugPrint(response.body);
      result = jsonDecode(response.body);
      token = result['Authorization'];
      debugPrint("Token: $token");
      getOrder(amount, id, uid);
    } else {
      debugPrint("something went wrong");
      debugPrint(response.body);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Logged Out!'),
      ));
    }
  }

  getOrder(amount, id, uid) async {
    debugPrint("Getting order");
    debugPrint("$amount, $id, $uid");
    final Map<String, int> order = {
      'amount': int.parse(amount),
      'receiver': 10000002,
    };
    final http.Response response = await http.post(
      Uri.parse('http://192.168.244.112:7000/order/order'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': '$token',
      },
      body: jsonEncode(order),
    );

    if (response.statusCode == 200) {
      debugPrint('successful');
      debugPrint(response.body);
      result = jsonDecode(response.body);
      phone = result['phonenumber'];
      order_id = result['order_id'];
      debugPrint("Phone: $phone, Order ID: $order_id, UID: $uid ID: $id");
      if (context.mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OTPPage(
                    phone: phone,
                    order_id: order_id,
                    token: token,
                    uid: uid.toString(),
                    id: id.toString())));
      }
    } else if (response.statusCode == 400) {
      debugPrint("Low balance");
      if (context.mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PaymentPage(uid: uid)));
      }
    } else if (response.statusCode == 403) {
      debugPrint("Token expired");
      if (context.mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PaymentPage(uid: uid)));
      }
    } else {
      debugPrint(response.body);
      debugPrint('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }
}
