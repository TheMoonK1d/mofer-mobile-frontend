import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mofer/Views/tracking_amount.dart';

class NoPlantPage extends StatelessWidget {
  const NoPlantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SafeArea(child: Container()),
                    Row(
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          "No plants",
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
            Expanded(
                child: Container(
              child: Lottie.asset('animations/nothing_here.json',
                  reverse: true, height: 300),
            )),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                textAlign: TextAlign.start,
                "Looks like you have no plants to track, contact the mofer team for more information",
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NoPlantPage()));
                },
                child: Text(
                  textAlign: TextAlign.start,
                  "Check again",
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
