import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/Views/plant_list.dart';
import 'package:mofer/Views/recommendation.dart';
import 'package:mofer/Views/settings_page.dart';
import 'package:mofer/Views/your_activity.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/dialog.dart';
import 'login.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

int index = 0, traceId = 0;
String? name;

class _DataPageState extends State<DataPage> {
  Future getStatusData() async {
    final prefs = await SharedPreferences.getInstance();
    index = int.parse(prefs.getString("Tracking")!);
    //http://localhost:5000/api/android/getPlant
    final uri = Uri.http('192.168.1.4:5000', '/api/android/getPlant');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': prefs.getString("Token").toString(),
      },
    );
    debugPrint(response.body.toString());

    if (response.statusCode == 200) {
      setState(() {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> dataArray = data['data'];
        debugPrint(dataArray.length.toString());
        Map<String, dynamic> _data = dataArray[index];

        // int _id = _data['trace_id'];
        // String _name = _data['plant_name'];

        name = _data['plant_name'];
        traceId = _data['trace_id'];
      });
      debugPrint("Yeeeeyy");
    } else if (response.statusCode == 401) {
      if (context.mounted) {
        loadingDialog(context);
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    } else {
      debugPrint("Something went wrong");
    }
  }

  @override
  void initState() {
    getStatusData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Color navColor = ElevationOverlay.applySurfaceTint(
    //     Theme.of(context).colorScheme.surface,
    //     Theme.of(context).colorScheme.surfaceTint,
    //     0);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Data",
            style: GoogleFonts.montserrat(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.normal,
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
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
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PlantList(),
                                ));
                          },
                          child: Text(
                            textAlign: TextAlign.start,
                            name != null ? "$name".toString() : "Loading",
                            style: GoogleFonts.montserrat(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          "Current plant",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.2),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(0))),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: SizedBox(
                                  height: 150,
                                  child: Image.asset('assets/pngtree.png')),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  height: 160,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.auto_graph_rounded,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              "Your Activity",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          "See how your plant is doing",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Expanded(child: Container()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ActivityPage(
                                        name: name,
                                        traceId: traceId,
                                      ),
                                    ));
                              },
                              child: Text(
                                textAlign: TextAlign.start,
                                "Show More",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w200,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  height: 160,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.recommend_rounded,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              "Recommendation",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          "What to do to get better result",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Expanded(child: Container()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RecommendationPage(
                                        name: name,
                                        traceId: traceId,
                                      ),
                                    ));
                              },
                              child: Text(
                                textAlign: TextAlign.start,
                                "Show More",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w200,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  height: 160,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.note_rounded,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              "Your Notes",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          "Take notes to keep track",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Expanded(child: Container()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      '📝 Notes will be available on the next build'),
                                ));
                              },
                              child: Text(
                                textAlign: TextAlign.start,
                                "Show More",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w200,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ));
  }
}
