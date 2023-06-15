import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mofer/Views/check_status.dart';
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
    Color brandcolor = const Color(0xFF23956D);
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;

      if (lightDynamic != null && darkDynamic != null) {
        lightColorScheme = lightDynamic.harmonized()..copyWith();
        lightColorScheme = lightColorScheme.copyWith();
        darkColorScheme = darkDynamic.harmonized();
      } else {
        lightColorScheme = ColorScheme.fromSeed(
            seedColor: brandcolor, brightness: Brightness.light);
        darkColorScheme = ColorScheme.fromSeed(
          seedColor: brandcolor,
          brightness: Brightness.dark,
        );
      }
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
          child: MaterialApp(
              title: 'Mofer',
              debugShowCheckedModeBanner: false,
              //scaffoldMessengerKey: Utils.messageKey,
              theme:
                  ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
              darkTheme:
                  ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
              themeMode: ThemeMode.system,
              home: StreamBuilder<User?>(
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
                                  glowColor:
                                      Theme.of(context).colorScheme.primary,
                                  endRadius: 150,
                                  duration: const Duration(milliseconds: 3000),
                                  repeat: true,
                                  showTwoGlows: true,
                                  curve: Curves.easeOutQuad,
                                  child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(99)),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          textAlign: TextAlign.start,
                                          "Connecting",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15,
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
                    } else {
                      //return LoginPage();
                      //For testing
                      return LoginPage();
                    }
                  })));
    });
  }
}
