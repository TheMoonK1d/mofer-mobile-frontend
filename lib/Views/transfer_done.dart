import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mofer/Views/main_page.dart';
import 'package:mofer/Views/tracking_amount.dart';

class TransferDone extends StatelessWidget {
  const TransferDone({super.key});

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
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Container()),
          Lottie.asset('animations/transfer_done.json',
              reverse: true, height: 200),
          Text(
            "Done",
            style: GoogleFonts.montserrat(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.normal,
            ),
          ),
          Text(
            "Your plant has been posted",
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.normal,
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TrackingAmount()));
              },
              style: ElevatedButton.styleFrom(
                //backgroundColor: const Color(0xff2a9d8f),
                elevation: 20,
                minimumSize: const Size(400, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                "Go back home",
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
