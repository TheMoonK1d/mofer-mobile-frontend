import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mofer/Views/login.dart';
import 'package:mofer/Views/my_products.dart';
import 'package:mofer/Views/payment_page.dart';
import 'package:mofer/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/dialog.dart';

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
      Uri.parse('http://192.168.8.209:7000/order/verify'),
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
        otpDialog(context);
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => const MainPage()));
      }
    } else if (response.statusCode == 403) {
      debugPrint("Token expired");
      if (context.mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    } else if (response.statusCode == 500) {
      debugPrint("Invalid or expired");
      if (context.mounted) {
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => PaymentPage()));
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Opps",
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                // color: Colors.white,
              ),
            ),
            content: Text(
              "Looks like you have entered an invalid opt, maybe it expired try again.",
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                // color: Colors.white,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Okay",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.normal,
                    // color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
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
      //'customer_uid': uid,
      'transaction_id': order_id,
      'package_id': id,
      'paid_date': formattedDate,
    };
    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.post(
      Uri.parse('http://192.168.8.209:5000/api/android/addSub'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': prefs.getString("Token").toString(),
      },
      // final response = await http.get(
      //   uri,
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': prefs.getString("Token").toString(),
      //   },
      // );
      body: jsonEncode(order),
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
    } else {
      debugPrint(response.body);
      debugPrint('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }

  resendOTP(token, uid) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Resending...",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.normal,
            // color: Colors.white,
          ),
        ),
        content: Text(
          "A new opt is being sent to you'r number, try that.",
          style: GoogleFonts.montserrat(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            // color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Okay",
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                // color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

    debugPrint("Resending OTP");
    final http.Response response = await http.post(
      Uri.parse('http://192.168.8.209:7000/order/resend_OTP'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      debugPrint('Resent!');
    } else if (response.statusCode == 400) {
      debugPrint("Something went wrong");
      // if (context.mounted) {
      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (context) => LoginPage()));
      // }
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
