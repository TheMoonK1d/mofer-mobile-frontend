import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mofer/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Utils/dialog.dart';
import 'login.dart';
import 'main_page.dart';
import 'no_plant.dart';

class TrackingAmount extends StatefulWidget {
  const TrackingAmount({super.key});

  @override
  State<TrackingAmount> createState() => _TrackingAmountState();
}

class _TrackingAmountState extends State<TrackingAmount> {
  late List dataArray;
  bool tracking = false;
  String plantAmount = "plant";
  int len = 0;
  int? index;
  bool hasPlant = true;

  Future getPlantList() async {
    final prefs = await SharedPreferences.getInstance();
    //var token = prefs.getString("Token");
    debugPrint("Getting Plant Status info");
    debugPrint(prefs.getString("Token").toString());
    //final data = {'uid': uid};
    // final uri =
    //     Uri.parse('http://192.168.138.209.112.112:5000/api/android/update_phone_no');
    //api/android/get_trackPlant
    final uri = Uri.http('192.168.138.209:5000', '/api/android/get_trackPlant');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': prefs.getString("Token").toString(),
      },
    );
    debugPrint(response.body.toString());
    //var _data = jsonDecode(response.body);
    //List<dynamic> _data = jsonEncode(data);

    if (response.statusCode == 200) {
      hasPlant = true;
    } else if (response.statusCode == 401) {
      if (context.mounted) {
        loadingDialog(context);
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    } else if (response.statusCode == 404) {
      hasPlant = false;
    } else {
      debugPrint("Something went wrong");
    }
  }

  @override
  void initState() {
    super.initState();
    debugPrint("Checking user status.....");
    getPlantList();
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
            future: getPlantList(),
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
                                  "looking for your plants",
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
                if (hasPlant == false) {
                  //debugPrint("User has a free trail");
                  return const NoPlantPage();
                }
                debugPrint("We good broooo!");
                return const MainPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
