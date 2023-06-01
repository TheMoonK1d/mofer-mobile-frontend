import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/Views/expired_page.dart';
import 'package:mofer/Views/free_trial.dart';
import 'package:mofer/Views/main_page.dart';
import 'package:mofer/Views/user_disabled.dart';
import 'package:lottie/lottie.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CheckStatus extends StatefulWidget {
  const CheckStatus({Key? key}) : super(key: key);

  @override
  State<CheckStatus> createState() => _CheckStatusState();
}

int? exp, dsl, _new;
//String? uid;
var token;

class _CheckStatusState extends State<CheckStatus> {
  Future checkUser() async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    String uid = currentUser.uid;
    debugPrint("Sending UID $uid");
    final data = {'uid': uid};
    final uri = Uri.http('192.168.1.4:5000', '/api/android/check', data);
    final response = await http.get(uri);
    var data0 = jsonDecode(response.body);
    if (response.statusCode == 200) {
      debugPrint("Value");
      exp = data0['data']['is_expired'];
      dsl = data0['data']['is_disabled'];
      _new = data0['data']['is_new'];
      debugPrint("Expire: $exp Disable: $dsl");
      debugPrint("EXP: $exp");
      debugPrint("DSL: $dsl");
    } else {
      debugPrint("$uid does not exist");
    }
  }

  @override
  void initState() {
    super.initState();
    debugPrint("Checking user status.....");
    checkUser();
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
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: checkUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
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
                                      color: Colors.grey,
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
                );
              } else if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset('animations/lost_connection.json',
                        reverse: true, height: 200),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 50),
                      child: Text(
                        'Opps 😕 ${snapshot.error}',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    )
                  ],
                );
              } else {
                if (_new == 1) {
                  debugPrint("User has a free trail");
                  return const FreeTrial();
                } else if (exp == 1) {
                  debugPrint("User account has expired");
                  return const ExpiredAccount();
                } else if (dsl == 1) {
                  debugPrint("User has disabled the account");
                  return const UserDisabledAccount();
                }
                debugPrint("All seems to be good going to main account");
                return const MainPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
