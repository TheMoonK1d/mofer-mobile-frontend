import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';

class VerifyEmailPage extends StatefulWidget {
  late String fName, lName, email, phone, city, kebele, street;

  VerifyEmailPage({
    super.key,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.city,
    required this.kebele,
    required this.street,
  });

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

const String url = 'http://192.168.8.209:5000/api/android/signup';
bool _buttonEnabled = true;

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  Widget build(BuildContext context) {
    void onButtonPressed() {
      setState(() {
        _buttonEnabled = false;
      });
      //........................
    }

    Future<void> sendDataAllInfo() async {
      debugPrint("Ready to send data");
      final Map<String, dynamic> data = {
        'customer_fname': widget.fName,
        'customer_lname': widget.lName,
        'customer_email': widget.email,
        'customer_phone_no': widget.phone,
        'customer_type': 'app user',
        'city': widget.city,
        'kebele': widget.kebele,
        'street': widget.street,
      };
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        debugPrint('successful');
        debugPrint(response.body);
        final result = jsonDecode(response.body);

        String uid = result['customer_uid'];
        debugPrint(uid.toString());

        if (context.mounted) {
          debugPrint("Value while passing it $widget.uid");
          FirebaseAuth.instance.signOut();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      } else {
        debugPrint('Error ${response.statusCode}: ${response.reasonPhrase}');
      }
    }

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
              child: Text(
                textAlign: TextAlign.start,
                "Email sent to ${widget.email}",
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                  onPressed: () {
                    sendDataAllInfo();
                    _buttonEnabled ? onButtonPressed : null;
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 20,
                    minimumSize: const Size(400, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Check Email 📩',
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

  // Future sendData() async {
  //   debugPrint("Fetching data");
  //   final response =
  //   await http.post(Uri.parse('http://192.168.8.209:5000/p/allPackages'));
  //   debugPrint(response.statusCode.toString());
  //   //data = jsonDecode(response.body);
  //
  //   debugPrint(lst.toString());
  // }
}
