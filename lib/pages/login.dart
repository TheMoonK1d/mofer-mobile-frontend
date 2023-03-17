import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/pages/main_page.dart';
import 'package:mofer/pages/signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mofer",
          style: GoogleFonts.montserrat(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.normal,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        //leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu_rounded)),
      ),
      body: Column(
        children: [
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  textAlign: TextAlign.start,
                  "Sign In",
                  style: GoogleFonts.montserrat(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),

          //Email
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email_outlined),
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
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              )),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot password?",
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        //color: const Color(0xff2a9d8f),
                      ),
                    )),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
            child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (Context) => AlertDialog(
                      title: Text(
                        "Still on Alpha",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      content: Text(
                        "You can long press the Login Button to skip this page",
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
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
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                onLongPress: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                }),
                style: ElevatedButton.styleFrom(
                  //1c7a47
                  //foregroundColor: const Color(0xff0e3920),
                  //backgroundColor: const Color(0xff2a9d8f),
                  elevation: 20,
                  minimumSize: const Size(400, 50),
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
          ),

          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupPage()),
                );
              },
              child: Text(
                "Create an account",
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  //color: const Color(0xff2a9d8f),
                  //0xFF0d1b2a
                ),
              )),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Alpha 0.5',
              style: GoogleFonts.montserrat(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                //color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
