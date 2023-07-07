import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mofer/Views/check_status.dart';
import 'package:mofer/Views/first_time.dart';
import 'package:mofer/root.dart';
import 'package:mofer/test_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Views/login.dart';
import 'first_screen.dart';

bool? firstTimeChecker;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

//send token

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? check;

  firstTimeCheckerFun() async {
    final prefs = await SharedPreferences.getInstance();
    firstTimeChecker = prefs.getBool("notFirstTime");
    debugPrint("First Time: $firstTimeChecker");
  }

  @override
  void initState() {
    firstTimeCheckerFun();
    if (firstTimeChecker == null) {
      firstTimeChecker = false;
    } else {
      firstTimeChecker = true;
    }
    super.initState();
  }

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
              home: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading...");
                  } else if (snapshot.hasError == true) {
                    return Text("Something went wrong");
                  } else if (firstTimeChecker == false) {
                    //return LoginPage();
                    setFirstTime();
                    return FirstScreen();
                  } else if (firstTimeChecker == null) {
                    //return LoginPage();
                    setFirstTime();
                    return FirstScreen();
                  } else {
                    return Root();
                  }
                },
              )));
    });
  }
}

// class FirstTime extends StatefulWidget {
//   FirstTime({Key? key, required this.firstTime}) : super(key: key);
//   bool? firstTime;

//   @override
//   State<FirstTime> createState() => _FirstTimeState();
// }

// class _FirstTimeState extends State<FirstTime> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: FutureBuilder(
//           //future: checkFirstTime(),
//           builder: (context, snapshot) {
//             if (firstTimeChecker == true) {
//               return FirstScreen();
//             } else if (firstTimeChecker == false || firstTimeChecker == null) {
//               return MyApp();
//             } else {
//               return Text("error");
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

setFirstTime() async {
  final pref = await SharedPreferences.getInstance();
  await pref.setBool('notFirstTime', true);
}
