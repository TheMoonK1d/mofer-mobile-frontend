import 'dart:convert';
import 'package:confetti/confetti.dart';
import 'package:countup/countup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../Utils/dialog.dart';
import 'login.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage({super.key, required this.name, required this.traceId});

  int? traceId;
  String? name;
  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  CurvedAnimation? curve;
  String? report = "Generating report", result = "Waiting...", uid;

  var paragraph_1, paragraph_2;
  bool isPlaying = true;
  int? temprature, humidity, soilMoisture;
  String? tempratureStatus, humidityStatus, soilMoistureStatus;
  double temp = 0, humi = 0, soil = 0;
  //Water Color
  Color waterCurrentColor = Colors.black;
  Color waterGood = Colors.orange;
  Color waterAvg = Colors.green;
  Color waterBad = Colors.red;

  //Humidity Color
  Color humidityCurrentColor = Colors.black;
  Color humidityGood = Colors.orange;
  Color humidityAvg = Colors.green;
  Color humidityBad = Colors.red;

  //Temp Color
  Color tempCurrentColor = Colors.black;
  Color tempGood = Colors.orange;
  Color tempAvg = Colors.green;
  Color tempBad = Colors.red;

  final conController = ConfettiController();
  Future getSettingsData() async {
    debugPrint(widget.traceId.toString());
    final prefs = await SharedPreferences.getInstance();
    //final data = {'trace_id': widget.traceId};

    final Map<String, dynamic> data = {
      'trace_id': widget.traceId.toString(),
      'plant_name': widget.name,
    };
    final uri =
        Uri.http('192.168.8.209:5000', '/api/android/generate_activity', data);
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': prefs.getString("Token").toString(),
      },
    );
//moisture
    var data0 = jsonDecode(response.body);
    if (response.statusCode == 200) {
      temprature = data0['mean']['temprature'];
      humidity = data0['mean']['humidity'];
      soilMoisture = data0['mean']['soil_moisture'];

      tempratureStatus = data0['status']['temprature'];
      humidityStatus = data0['status']['humidity'];
      soilMoistureStatus = data0['status']['soil_moisture'];

      //Water color assignment
      if (soilMoistureStatus == "below average") {
        waterCurrentColor = waterBad;
      } else if (soilMoistureStatus == "average") {
        waterCurrentColor = waterAvg;
      } else if (soilMoistureStatus == "above average") {
        waterCurrentColor = waterGood;
      } else {
        waterCurrentColor = waterCurrentColor;
      }

      //Humidity color assignment
      if (humidityStatus == "below average") {
        humidityCurrentColor = humidityBad;
      } else if (humidityStatus == "average") {
        humidityCurrentColor = humidityAvg;
      } else if (humidityStatus == "above average") {
        humidityCurrentColor = humidityGood;
      } else {
        humidityCurrentColor = humidityCurrentColor;
      }
      //Temp color assignment
      if (tempratureStatus == "below average") {
        tempCurrentColor = tempBad;
      } else if (tempratureStatus == "average") {
        tempCurrentColor = tempAvg;
      } else if (tempratureStatus == "above average") {
        tempCurrentColor = tempGood;
      } else {
        tempCurrentColor = tempCurrentColor;
      }

      temp = temprature!.toDouble();
      humi = humidity!.toDouble();
      soil = soilMoisture!.toDouble();
    } else if (response.statusCode == 401) {
      if (context.mounted) {
        loadingDialog(context);
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    } else {
      debugPrint("does not exist");
    }
  }

  @override
  void initState() {
    super.initState();
    getSettingsData();
    conController.stop();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    curve = CurvedAnimation(
        parent: controller, curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  void dispose() {
    controller.dispose();
    conController.dispose();
    super.dispose();
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
            appBar: AppBar(),
            body: FutureBuilder(
              future: getSettingsData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SizedBox(child: CircularProgressIndicator()),
                  );
                } else {
                  return ListView(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    textAlign: TextAlign.start,
                                    "${widget.name}'s activity",
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
                      SizedBox(
                        height: 550,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: navColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      offset: const Offset(0, 80),
                                      blurRadius: 50,
                                      spreadRadius: 5),
                                ],
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30))),
                            child: Padding(
                              padding: const EdgeInsets.all(30),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height: 170,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SimpleCircularProgressBar(
                                              backStrokeWidth: 0,
                                              progressColors: [
                                                navColor,
                                                waterCurrentColor
                                              ],
                                              mergeMode: false,
                                              onGetText: (double value) {
                                                return Text(
                                                  'Moisture',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w900,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width: 60,
                                              child: Countup(
                                                begin: 0,
                                                end: soil,
                                                duration:
                                                    const Duration(seconds: 6),
                                                separator: ',',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w900,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            Container(
                                              width: 130,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                  soilMoistureStatus!,
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
                                    SizedBox(
                                        height: 150,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SimpleCircularProgressBar(
                                              backStrokeWidth: 0,
                                              progressColors: [
                                                navColor,
                                                humidityCurrentColor
                                              ],
                                              mergeMode: false,
                                              onGetText: (double value) {
                                                return Text(
                                                  'Humidity',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w900,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width: 60,
                                              child: Countup(
                                                begin: 0,
                                                end: humi,
                                                duration:
                                                    const Duration(seconds: 6),
                                                separator: ',',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w900,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            Container(
                                              width: 130,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                  humidityStatus!,
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
                                    SizedBox(
                                        height: 150,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SimpleCircularProgressBar(
                                              backStrokeWidth: 0,
                                              progressColors: [
                                                navColor,
                                                tempCurrentColor
                                              ],
                                              mergeMode: false,
                                              onGetText: (double value) {
                                                return Text(
                                                  'Temp',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w900,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width: 60,
                                              child: Countup(
                                                begin: 0,
                                                end: temp,
                                                duration:
                                                    const Duration(seconds: 6),
                                                separator: ',',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w900,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            Container(
                                              width: 130,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                  tempratureStatus!,
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
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  'Color key',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Extreme',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    Text(
                                      'Average',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        color: Colors.teal,
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    Text(
                                      'Bad',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  );
                }
              },
            )));
  }
}
