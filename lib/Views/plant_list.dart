import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/dialog.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

import 'main_page.dart';

class PlantList extends StatefulWidget {
  const PlantList({Key? key}) : super(key: key);

  @override
  State<PlantList> createState() => _PlantListState();
}

int index = 0;
String PlantName = "";
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
    //     Uri.parse('http://192.168.1.3.112.112:5000/api/android/update_phone_no');
    //api/arduino/get_trackPlant
    final uri = Uri.http('192.168.1.3:5000', '/api/arduino/get_trackPlant');
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
        PlantName = firstDataItem['plant_name'];
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
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: dataArray == null ? 0 : dataArray!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              selected = index;
              debugPrint(selected.toString());
              trackingPlant();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    'You are now tracking your ${dataArray![index]["plant_name"]}'),
              ));
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: SizedBox(
                  height: 100,
                  child: Text(
                    dataArray![index]["plant_name"],
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

trackingPlant() async {
  final pref = await SharedPreferences.getInstance();
  await pref.setString('Tracking', selected.toString());
  //print()
}
