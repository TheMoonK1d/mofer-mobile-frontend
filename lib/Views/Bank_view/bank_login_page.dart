import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bank_otp.dart';

//init function
/*
  get pkg id
  get amount

 */

//http://192.168.1.6:7000/useraccount/login


class BankLoginPage extends StatelessWidget {
  final String id, amount;

  const BankLoginPage({super.key, required this.id, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Meneab Bank 💳",
          style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.normal,
              color: Colors.white),
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        //leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu_rounded)),
      ),
      body: Column(
        children: [
          //Email
          Expanded(child: Container()),
          Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      width: 10,
                    ),
                  ),
                  hintText: "Username",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              )),

          Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      width: 10,
                    ),
                  ),
                  hintText: "Password",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              )),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        //send username and password
                        //wait for response
                        //if response is token next page and pass the token, pkg id, amount value
                        //else show msg
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OTPPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        //1c7a47
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        elevation: 5,
                      ),
                      child: Text(
                        'Log in',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.normal,
                          // color: Colors.white,
                        ),
                      )),
                ],
              )),
          const SizedBox(
            height: 150,
          )
        ],
      ),
    );
  }
}
