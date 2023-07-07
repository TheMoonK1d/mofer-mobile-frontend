import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mofer/Views/login.dart';

import 'Views/SignUp_view/signup_name.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);
  Future<void> delayedFunction() async {
    await Future.delayed(Duration(seconds: 2));

    // Code to be executed after the delay
    print('Delayed function executed');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: delayedFunction(),
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
                              // color: navColor.withOpacity(0.5),
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
        } else {
          return Scaffold(
              appBar: AppBar(
                  // title: Text(
                  //   "Welcome",
                  //   style: GoogleFonts.montserrat(
                  //     fontSize: 30,
                  //     fontWeight: FontWeight.w200,
                  //     fontStyle: FontStyle.normal,
                  //   ),
                  // ),
                  // centerTitle: true,
                  ),
              body: Column(
                children: [
                  Expanded(
                    child: PageView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: Container()),
                            SizedBox(
                              height: 200,
                              child: Image.asset(
                                "assets/final.png",
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                            Text(
                              "Welcome to",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Text(
                              "Mofer",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Expanded(child: Container()),
                            Padding(
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 7,
                                          width: 7,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: Container()),
                            SizedBox(
                              height: 200,
                              child: Lottie.asset('animations/3_screen.json',
                                  reverse: false, height: 200),
                            ),
                            Text(
                              "Track and Analyze",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Text(
                              "Your plants",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Expanded(child: Container()),
                            Padding(
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 7,
                                          width: 7,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: Container()),
                            SizedBox(
                              height: 200,
                              child: Lottie.asset('animations/2_screen.json',
                                  reverse: false, height: 200),
                            ),
                            Text(
                              "Tranfer and Sell",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Text(
                              "Your plants",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Expanded(child: Container()),
                            Padding(
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 7,
                                          width: 7,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: Container()),
                            SizedBox(
                              height: 200,
                              child: Lottie.asset('animations/1_screen.json',
                                  reverse: false, height: 200),
                            ),
                            Text(
                              "Tranfer and Sell",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Text(
                              "Your plants",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Expanded(child: Container()),
                            Padding(
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          height: 7,
                                          width: 7,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          "Get Started",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            //color: const Color(0xff2a9d8f),
                            //0xFF0d1b2a
                          ),
                        )),
                  ),
                ],
              ));
        }
      },
    );
  }
}
