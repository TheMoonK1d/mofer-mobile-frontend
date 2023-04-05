import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/pages/main_page.dart';
import 'package:mofer/pages/signup.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color navColor = ElevationOverlay.applySurfaceTint(
        Theme.of(context).colorScheme.surface,
        Theme.of(context).colorScheme.surfaceTint,
        0);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarContrastEnforced: true,
          systemNavigationBarColor: navColor,
          statusBarColor: navColor,
          systemNavigationBarDividerColor: navColor,
          systemNavigationBarIconBrightness:
              Theme.of(context).brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
        ),
        child: SafeArea(
          child: SafeArea(
            child: Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/new_bk.png"),
                    // fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: Center(
                      child: TextLiquidFill(
                        text: 'MOFER',
                        waveColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.4),
                        boxBackgroundColor: navColor,
                        textStyle: GoogleFonts.montserrat(
                          fontSize: 30,
                          letterSpacing: 10,
                          shadows: [
                            const Shadow(
                              offset: Offset(0.0, 10.0),
                              blurRadius: 30.0,
                            ),
                          ],
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.normal,
                        ),
                        boxHeight: 300,
                      ),
                    )),
                    Column(
                      children: [
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
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.07),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            )),

                        const SizedBox(
                          height: 20,
                        ),

                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.07),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            )),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
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
                              onPressed: () {},
                              onLongPress: (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainPage()),
                                );
                              }),
                              style: ElevatedButton.styleFrom(
                                //1c7a47
                                //foregroundColor: const Color(0xff0e3920),

                                backgroundColor: const Color(0xff2a9d8f),
                                elevation: 1,
                                minimumSize: const Size(400, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text(
                                'Log in',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  color: Colors.white,
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
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()),
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
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
