import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mofer/Views/check_status.dart';
import 'package:mofer/free_trial.dart';
import 'Views/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

//send token

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color brandcolor = const Color(0xff2a9d8f);
    String? uid;
    int exp, dsl;

    return MaterialApp(
        title: 'Mofer',
        debugShowCheckedModeBanner: false,
        //scaffoldMessengerKey: Utils.messageKey,
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          colorSchemeSeed: brandcolor,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          colorSchemeSeed: brandcolor,
        ),
        themeMode: ThemeMode.system,
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
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
                //return const CheckStatus();
                //For testing
                return FreeTrial();
              } else {
                //return LoginPage();
                //For testing
                return FreeTrial();
              }
            })
    );
  }
}
