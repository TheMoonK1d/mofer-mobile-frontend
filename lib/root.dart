import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Views/check_status.dart';
import 'Views/login.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

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
        child: Scaffold(
            body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Center(
                        child: AvatarGlow(
                          glowColor: Theme.of(context).colorScheme.primary,
                          endRadius: 150,
                          duration: const Duration(milliseconds: 3000),
                          repeat: true,
                          showTwoGlows: true,
                          curve: Curves.easeOutQuad,
                          child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(99)),
                              child: SizedBox(
                                height: 150,
                                width: 100,
                                child: Image.asset(
                                  "assets/final.png",
                                  color: navColor.withOpacity(0.5),
                                ),
                              )),
                        ),
                      )),
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.all(50),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  textAlign: TextAlign.start,
                                  "Connecting",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                SizedBox(
                                  width: 13,
                                  child: DefaultTextStyle(
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    ),
                                    child: AnimatedTextKit(
                                      repeatForever: true,
                                      animatedTexts: [
                                        TyperAnimatedText(''),
                                        TyperAnimatedText('.'),
                                        TyperAnimatedText('..'),
                                        TyperAnimatedText('...'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return AlertDialog(
                title: Text(
                  "Something went wrong",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                content: Text(
                  "We are facing a problem, try again",
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
                  ),
                ],
              );
            } else if (snapshot.hasData) {
              return const CheckStatus();
              //return LoginPage();
            } else {
              //return LoginPage();
              //For testing
              return LoginPage();
            }
          },
        )));
  }
}
