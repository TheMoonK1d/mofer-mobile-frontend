import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ReadDetail extends StatelessWidget {
  const ReadDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Container(
                height: 200,
                width: 400,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 30),
                          blurRadius: 30,
                          spreadRadius: 2)
                    ]),
                child: Lottie.asset('animations/sensor.json',
                    reverse: true, height: 500),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              textAlign: TextAlign.start,
              "Sensor seem to be working",
              style: GoogleFonts.montserrat(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
              ),
            ),
          )
        ],
      ),
    );
  }
}
