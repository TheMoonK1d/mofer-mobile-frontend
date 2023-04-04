import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/pages/signup_password_page.dart';

class SignUpAddressPage extends StatefulWidget {
  const SignUpAddressPage({super.key});

  @override
  State<SignUpAddressPage> createState() => _SignUpAddressPageState();
}

class _SignUpAddressPageState extends State<SignUpAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(child: Container()),
          SizedBox(
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              "Sign Up",
                              style: GoogleFonts.montserrat(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              "Where to find you?",
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "City",
                        hintStyle: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),

                //Email
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        hintText: "Street",
                        hintStyle: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    )),

                const SizedBox(
                  height: 20,
                ),

                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Kebele",
                        hintStyle: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPasswordPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        minimumSize: const Size(400, 50),
                      ),
                      child: Text(
                        'Next',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.normal,
                          // color: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
