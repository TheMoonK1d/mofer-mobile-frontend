import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/dialog.dart';
import 'home_page.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

import 'main_page.dart';

class PlantList extends StatefulWidget {
  const PlantList({Key? key}) : super(key: key);

  @override
  State<PlantList> createState() => _PlantListState();
}

int index = 0;
String plantName = "";
int len = 0;
int selected = 0;
// Map? data;
List? dataArray;

class _PlantListState extends State<PlantList> {
  Future getPlantList() async {
    final prefs = await SharedPreferences.getInstance();
    //var token = prefs.getString("Token");
    debugPrint("Getting Plant Status info");
    debugPrint(prefs.getString("Token").toString());
    //final data = {'uid': uid};
    // final uri =
    //     Uri.parse('http://192.168.1.4.112.112:5000/api/android/update_phone_no');
    //api/android/get_trackPlant
    final uri = Uri.http('192.168.1.4:5000', '/api/android/get_trackPlant');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': prefs.getString("Token").toString(),
      },
    );
    debugPrint(response.body.toString());
    //var _data = jsonDecode(response.body);
    //List<dynamic> _data = jsonEncode(data);

    if (response.statusCode == 200) {
      setState(() {
        Map<String, dynamic> data = json.decode(response.body);
        dataArray = data['data'];
        debugPrint(dataArray!.length.toString());
        Map<String, dynamic> firstDataItem = dataArray![index];
        len = dataArray!.length;
        plantName = firstDataItem['plant_name'];
        String dataEnteredDate = firstDataItem['entered_date'];
        DateTime dateTime = DateTime.parse(dataEnteredDate);
        formattedDate = DateFormat.yMMMMd().format(dateTime);
      });
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
    getPlantList();
    super.initState();
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
            body: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              "Your Plants",
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
                  child: ListView.builder(
                    itemCount: dataArray == null ? 0 : dataArray!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: const Icon(Icons.compost),
                          title: Text(
                            dataArray![index]["plant_name"] != null
                                ? dataArray![index]["plant_name"].toString()
                                : "Loading...",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          subtitle: Text(
                            //entered_date
                            formattedDate != null
                                ? "Last tracked on $formattedDate"
                                : "Loading...",
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          onTap: () {
                            selected = index;
                            debugPrint(selected.toString());
                            trackingPlant();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'You are now tracking your ${dataArray![index]["plant_name"]}'),
                            ));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainPage()));
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            )));
  }
}

trackingPlant() async {
  final pref = await SharedPreferences.getInstance();
  await pref.setString('Tracking', selected.toString());
  //print()
}
