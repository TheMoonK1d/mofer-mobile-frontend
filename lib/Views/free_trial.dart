import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mofer/Views/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/signout_controller.dart';
import 'login.dart';

class FreeTrial extends StatefulWidget {
  const FreeTrial({Key? key}) : super(key: key);

  @override
  State<FreeTrial> createState() => _FreeTrialState();
}

class _FreeTrialState extends State<FreeTrial> {
  bool isPlaying = true;
  User? user = FirebaseAuth.instance.currentUser;
  late String uid, email;
  final controller = ConfettiController();
  @override
  void initState() {
    controller.play();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  sendUID() async {
    final user = this.user;
    if (user != null) {
      uid = user.uid;
    }
    debugPrint("Function called");
    final data = {'customer_uid': uid};
    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.post(
      Uri.parse('http://192.168.244.112:5000/api/android/start'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': prefs.getString("Token").toString(),
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      debugPrint("Sending $uid to API : $data");
    } else if (response.statusCode == 401) {
      if (context.mounted) {
        //loadingDialog(context);
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    } else {
      debugPrint("$uid does not exist");
    }
  }

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
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Scaffold(
            body: Column(
              children: [
                Expanded(
                    child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                            child: DefaultTextStyle(
                              style: GoogleFonts.montserrat(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.normal,
                                  color: Theme.of(context).colorScheme.primary),
                              child: AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  FadeAnimatedText('Congrats 🙌🏿'),
                                  FadeAnimatedText('እንኳን ደስ አለቹ 🙌🏿'),
                                  FadeAnimatedText('Baga gammadde 🙌🏿'),
                                  FadeAnimatedText('מזל טוב 🙌🏿 '),
                                  FadeAnimatedText('🙌🏿 おめでとう'),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            'You have been gifted a 1-month free trial of our service. Enjoy full access to all features and let us know if you need any help.\nHave a good day 🎉🎊',
                            style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ],
                      )),
                )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 70),
                  child: ElevatedButton(
                      onPressed: () {
                        //signIn(context, emailController.text , passwordController.text);
                        if (isPlaying == true) {
                          controller.stop();
                          isPlaying = false;
                        } else {
                          controller.play();
                          isPlaying = true;
                        }
                        sendUID();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 20,
                        minimumSize: const Size(400, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Start now',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.normal,
                          // color: Colors.white,
                        ),
                      )),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              "...",
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            content: const Text(
                              "....",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  SignOut signOut = SignOut(context);
                                  signOut.signOut();
                                },
                                child: const Text(
                                  "Sign out",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
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
            ),
          ),
          ConfettiWidget(
            confettiController: controller,
            shouldLoop: true,
            gravity: 1.0,
            emissionFrequency: 0.02,
            numberOfParticles: 5,
            minBlastForce: 10,
            maxBlastForce: 100,
            blastDirectionality: BlastDirectionality.explosive,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(0.5),
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              Theme.of(context).colorScheme.tertiary,
            ],
          )
        ],
      ),
    );
  }
}
