import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  String report = "Generating report";

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
          appBar: AppBar(),
          body: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            "Your Activity",
                            style: GoogleFonts.montserrat(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    height: 300,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: Lottie.asset('animations/plant_3.json',
                                repeat: false, reverse: false, height: 200),
                          ),
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Text(
                  textAlign: TextAlign.start,
                  report,
                  style: GoogleFonts.montserrat(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: DefaultTextStyle(
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: false,
                    isRepeatingAnimation: false,

                    onFinished: () {
                      setState(() {
                        report = "Done";
                        debugPrint("Done");
                      });
                    },
                    //pause: Duration(seconds: 0),
                    animatedTexts: [
                      TypewriterAnimatedText(
                          'Based on our analysis, your plant is showing below average temperature, humidity, and soil moisture. Tomato plants prefer warm temperatures, high humidity, and consistent moisture levels in the soil. When these conditions are not met, the plant may struggle to grow and produce healthy fruits\n \nTo improve the current plant conditions will recommend the following tasks to do. Covering the tomato plants with a light fabric or row cover can also help protect them from cold temperatures. You can increase humidity levels by misting the tomato plants with water or by placing a tray of water near the plants. Water the tomato plants regularly and deeply to ensure that the soil stays moist.'),
                      // TypewriterAnimatedText(
                      //     'We hope we have helped with our report'),
                    ],
                  ),
                ),
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.start,
                  "THIS IS STILL\nA ON BETA",
                  style: GoogleFonts.montserrat(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                      color: Colors.grey.withOpacity(0.1)),
                ),
              ),
            ],
          ),
        ));
  }
}
