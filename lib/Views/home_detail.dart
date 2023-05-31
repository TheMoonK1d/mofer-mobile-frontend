import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomeDetail extends StatelessWidget {
  String animation, name;
  double height, width;
  HomeDetail(
      {super.key,
      required this.animation,
      required this.name,
      required this.height,
      required this.width});

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
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          "${name} level",
                          style: GoogleFonts.montserrat(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      textAlign: TextAlign.start,
                      "Waiting ...",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                )),
            Expanded(
                child: Container(
              child: Lottie.asset(
                'animations/${animation}',
                reverse: true,
                height: height,
                width: width,
              ),
            )),
            Padding(
                padding: const EdgeInsets.all(50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      "Waiting for ${name.toLowerCase()} data ",
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
          ],
        ),
      ),
    );
  }
}
