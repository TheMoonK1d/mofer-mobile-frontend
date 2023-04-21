import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/Views/expired_page.dart';
import 'package:mofer/Views/main_page.dart';
import 'package:mofer/Views/user_disabled.dart';
import 'package:http/http.dart' as http;

class CheckStatus extends StatefulWidget {
  const CheckStatus({Key? key}) : super(key: key);

  @override
  State<CheckStatus> createState() => _CheckStatusState();
}

late int exp , dsl;
String? uid;

class _CheckStatusState extends State<CheckStatus> {
  Future checkUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
    debugPrint("Sending UID");
    final data = {'customer_uid': uid};
    final uri = Uri.http('192.168.1.6:5000', '/ss/check', data);
    final response = await http.get(uri);
    var data0 = jsonDecode(response.body);
    if (response.statusCode == 200) {
      debugPrint("Value");
      exp = data0['data']['is_expired'];
      dsl = data0['data']['is_disabled'];
      debugPrint("Expire: $exp Disable: $dsl");
      debugPrint("EXP: $exp");
      debugPrint("DSL: $dsl");
    } else {
      debugPrint("$uid does not exist");
    }
  }

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder (
        future: checkUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: Center(
                    child:  CircularProgressIndicator(strokeWidth: 6),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: Text(
                      textAlign: TextAlign.start,
                      "Just a sec...",
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            if (exp == 1){
              return const ExpiredAccount();
            }else if (dsl == 1){
              return const UserDisabledAccount();
            }
            return const MainPage();
          }
        },
      ),
    );
  }
}
