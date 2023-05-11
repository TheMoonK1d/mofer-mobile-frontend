import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/Controller/signout_controller.dart';
import 'package:mofer/Views/payment_page.dart';

class ExpiredAccount extends StatefulWidget {
  const ExpiredAccount({Key? key}) : super(key: key);

  @override
  State<ExpiredAccount> createState() => _ExpiredAccountState();
}

class _ExpiredAccountState extends State<ExpiredAccount> {
  User? user = FirebaseAuth.instance.currentUser;
  late String uid, email;
  @override
  void initState() {
    final user = this.user;
    if (user != null) {
      uid = user.uid;
      email = user.email!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SafeArea(child: Container()),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                    elevation: 0,
                    //color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 300,
                        child: Center(
                          child: Text(
                            "Payment Due",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 50,
                              fontFamily: "Montserrat",
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                    height: 200,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Your subscription has ended.\nTo continue using our service, please make a payment or your account will be terminated.",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    )),
              ),
              Expanded(child: Container()),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentPage(uid: uid)));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 20,
                      minimumSize: const Size(400, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Pay',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                        // color: Colors.white,
                      ),
                    )),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            "Before you leave",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                          content: Text(
                            "You will still see this page when you login with $email again until you pay the subscription fee",
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentPage(uid: uid)));
                              },
                              child: const Text(
                                "Pay now",
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                SignOut signOut = SignOut(context);
                                signOut.signOut();
                              },
                              child: const Text(
                                "Sign out",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.redAccent),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    child: Text(
                      'Sign out from this account?',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        //color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        // color: Colors.white,
                      ),
                    ),
                  )),
            ],
          )),
    );
  }
}
