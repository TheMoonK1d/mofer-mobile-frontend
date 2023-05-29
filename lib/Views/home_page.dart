import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mofer/Views/settings_page.dart';
import 'package:vibration/vibration.dart';
import 'Home_easter_eggs/water.dart';
import 'package:countup/countup.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

String _greeting() {
  final hour = TimeOfDay.now().hour;
  if (hour <= 12) {
    return "👋🏾 Hey,\nGood morning";
  } else if (hour <= 17) {
    return "👋🏾 Hey,\nGood evening";
  }
  return "😴 Hey,\nGood afternoon";
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Color bk = ElevationOverlay.applySurfaceTint(
        Theme.of(context).colorScheme.surface,
        Theme.of(context).colorScheme.surfaceTint,
        0);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
            style: GoogleFonts.montserrat(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.normal,
            ),
          ),
          automaticallyImplyLeading: false,
          // leading:
          //     IconButton(onPressed: () {}, icon: const Icon(Icons.menu_rounded)),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_active_rounded)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingPage()));
                },
                icon: const Icon(Icons.settings_rounded))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                color: bk,
                elevation: 50,
                surfaceTintColor: bk,
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 200,
                  width: 400,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Lottie.asset('animations/home_plant.json',
                          reverse: true, height: 300),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              _greeting(),
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Last 11's read was on\n00/00/0000",
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            Expanded(child: Container()),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "New tips",
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                color: bk,
                elevation: 1,
                surfaceTintColor: bk,
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 100,
                  width: 400,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.vibration_rounded),
                      Text(
                        "Did you know\nyou can shake 📳 your phone to refresh",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Your Controls",
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onLongPress: () {
                      Vibration.vibrate();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Water(),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.water,
                            size: 30,
                            color: Colors.blueAccent,
                          ),
                          Text(
                            "Water",
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          Row(
                            children: [
                              Countup(
                                begin: 0,
                                end: 50,
                                duration: Duration(seconds: 3),
                                separator: ',',
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                              Text(
                                "%",
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.thermostat,
                          size: 30,
                          color: Colors.redAccent,
                        ),
                        Text(
                          "Temp",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Row(
                          children: [
                            Countup(
                              begin: 0,
                              end: 20,
                              duration: Duration(seconds: 3),
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Text(
                              "℃",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.water_drop,
                          size: 30,
                          color: Colors.orangeAccent,
                        ),
                        Text(
                          "Humidity",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Row(
                          children: [
                            Countup(
                              begin: 0,
                              end: 13,
                              duration: Duration(seconds: 3),
                              separator: ',',
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Text(
                              "%",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sensors,
                          size: 30,
                          //color: Colors.purple,
                        ),
                        Text(
                          "Reads",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Text(
                          "11",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 120,
                    width: 245,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.park_rounded,
                          size: 30,
                          color: Color(0xfff5ab59a),
                        ),
                        Text(
                          "Your plant",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Text(
                          "Plant Name",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Container(
            //       padding: EdgeInsets.all(10),
            //       height: 150,
            //       width: 150,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         color:
            //             Theme.of(context).colorScheme.primary.withOpacity(0.1),
            //       ),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Icon(
            //             Icons.water_drop_rounded,
            //             size: 35,
            //             color: Colors.blue,
            //           ),
            //           Text(
            //             "Water level",
            //             style: GoogleFonts.montserrat(
            //               fontSize: 15,
            //               fontWeight: FontWeight.w500,
            //               fontStyle: FontStyle.normal,
            //             ),
            //           ),
            //           Text(
            //             "20%",
            //             style: GoogleFonts.montserrat(
            //               fontSize: 40,
            //               fontWeight: FontWeight.w900,
            //               fontStyle: FontStyle.normal,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Container(
            //       padding: EdgeInsets.all(10),
            //       height: 150,
            //       width: 150,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         color:
            //             Theme.of(context).colorScheme.primary.withOpacity(0.1),
            //       ),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Icon(
            //             Icons.water_drop_rounded,
            //             size: 35,
            //             color: Colors.blue,
            //           ),
            //           Text(
            //             "Water level",
            //             style: GoogleFonts.montserrat(
            //               fontSize: 15,
            //               fontWeight: FontWeight.w500,
            //               fontStyle: FontStyle.normal,
            //             ),
            //           ),
            //           Text(
            //             "20%",
            //             style: GoogleFonts.montserrat(
            //               fontSize: 40,
            //               fontWeight: FontWeight.w900,
            //               fontStyle: FontStyle.normal,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
