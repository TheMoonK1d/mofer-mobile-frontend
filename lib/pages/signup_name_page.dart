import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/pages/signup_address_page.dart';

class SignUpName extends StatelessWidget {
  const SignUpName({super.key});

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
                              "Get in touch",
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

                //Email
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
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
                        hintText: "Phone Number",
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
                              builder: (context) => const SignUpAddressPage()),
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
