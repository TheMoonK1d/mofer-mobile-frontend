import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mofer/Views/settings_page.dart';

import 'login.dart';

class UserDisabledAccount extends StatefulWidget {
  const UserDisabledAccount({Key? key}) : super(key: key);

  @override
  State<UserDisabledAccount> createState() => _UserDisabledAccountState();
}

class _UserDisabledAccountState extends State<UserDisabledAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SafeArea(child: Container()),
              Lottie.asset('animations/error.json',
                  reverse: true, height: 100, width: 100),
              const Center(
                child: Text(
                  "Looks like you have disabled your account, You can activate it here",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                    elevation: 0,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.05),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                          height: 80,
                          child: Row(
                            children: [
                              Text(
                                'Re activate',
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                              Expanded(child: Container()),
                              Switch(
                                onChanged: (t) {
                                  //Function
                                  editUserStatus.updateUserStatus(uid, context);
                                  setState(() {
                                    status = t;
                                  });
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                value: status!,
                              ),
                            ],
                          )),
                    )),
              ),
            ],
          )),
    );
  }
}
