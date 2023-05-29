import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/Views/login.dart';
import 'package:http/http.dart' as http;

class VerifyEmailChange extends StatelessWidget {
  String email;
  VerifyEmailChange({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                textAlign: TextAlign.start,
                "Verify",
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Center(
                child: Column(
              children: [
                Text(
                  textAlign: TextAlign.start,
                  "email sent to $email",
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Text(
                  textAlign: TextAlign.start,
                  "You will be signed out!",
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                  onPressed: () {
                    sendEmail(email, context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 20,
                    minimumSize: const Size(400, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Check New Email 📩',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.normal,
                      // color: Colors.white,
                    ),
                  )),
            ),
          ],
        ));
  }
}

sendEmail(email, context) async {
  debugPrint("Sending email");
  final data = {'email': email};
  final uri =
      Uri.http('192.168.244.112:5000', '/api/android/confirm_new_email', data);

  final response = await http.get(uri);
  debugPrint(response.body);
  if (response.statusCode == 200) {
    debugPrint("Sent email to $email the request data is as followed : $data");
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  } else {
    debugPrint("$email does not exist");
  }
}
