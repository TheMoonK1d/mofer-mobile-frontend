import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mofer/Views/verify_page.dart';
import '../Utils/dialog.dart';
import 'package:http/http.dart' as http;

class SignUp {
  final BuildContext context;
  final String fName, lName, phone, city, kebele, street;
  SignUp(
    String email,
    password,
    this.context,
    this.fName,
    this.lName,
    this.phone,
    this.city,
    this.kebele,
    this.street,
  );

  sendData(String email, fName) async {
    debugPrint("Ready to send email and first name");

    final Map<String, dynamic> data = {
      'customer_email': email,
      'customer_fname': fName,
    };
    //final uri = Uri.http('192.168.244.112:5000', '/c/confirm_email', data);
    final uri =
        Uri.http('192.168.244.112:5000', '/api/android/confirm_email', data);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      debugPrint("Sent");
      debugPrint(data.toString());
    } else {
      debugPrint("something went wrong");
    }
  }

  Future signUp(context, String email, password, kebele, city, phone, street,
      fName, lName) async {
    loadingDialog(context);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }

    //Send email
    sendData(email, fName);

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyEmailPage(
            fName: fName,
            lName: lName,
            email: email,
            phone: phone,
            city: city,
            kebele: kebele,
            street: street,
          ),
        ),
      );
    }
  }
}
