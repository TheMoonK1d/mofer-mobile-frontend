import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bk_blur.png"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SafeArea(child: Column()),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mofer',
                        style: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Glad to see you',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w200,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Row(
                children: [
                  Text(
                    "Email",
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Container(
                height: 50,
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    enableSuggestions: true,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        hintText: "Enter your email",
                        hintStyle: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            fontStyle: FontStyle.normal,
                            color: Colors.white),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Row(
                children: [
                  Text(
                    "Password",
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                height: 50,
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.remove_red_eye_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        hintText: "Enter your password",
                        hintStyle: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            fontStyle: FontStyle.normal,
                            color: Colors.white),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
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
                          color: const Color(0xff2a9d8f),
                        ),
                      )),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
              child: ElevatedButton(
                  onPressed: () {},
                  onLongPress: (() {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const Home()),
                    // );
                  }),
                  style: ElevatedButton.styleFrom(
                    //1c7a47
                    foregroundColor: const Color(0xff0e3920),
                    backgroundColor: const Color(0xff2a9d8f),
                    elevation: 5,
                    minimumSize: const Size(400, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Log in',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                  )),
            ),

            TextButton(
                onPressed: () {},
                child: Text(
                  "Create an account",
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: const Color(0xff2a9d8f),
                    //0xFF0d1b2a
                  ),
                )),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Alpha 0.1',
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
