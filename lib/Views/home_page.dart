import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mofer/Views/check_status.dart';
import 'package:mofer/Views/plant_list.dart';
import 'package:mofer/Views/read_detail.dart';
import 'package:mofer/Views/settings_page.dart';
import 'package:mofer/Views/transfer_plant%20.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import '../Utils/dialog.dart';
import 'Home_easter_eggs/water.dart';
import 'package:http/http.dart' as http;
import 'home_detail.dart';
import 'login.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

String _greeting() {
  final hour = TimeOfDay.now().hour;
  if (hour <= 12) {
    return "Good morning";
  } else if (hour <= 17) {
    return "Good afternoon";
  }
  return "Good evening";
}

var water, temp, humidity, read, entered_date, plant_name;
int index = 0;

String? formattedDate;

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  int index = 0;
  String? plantName, username;
  int len = 0;
  int selected = 0;
// Map? data;
  List? dataArray, nameArray;
  bool tracking = false;
  String plantAmount = "plant";

  Future getPlantList() async {
    final prefs = await SharedPreferences.getInstance();
    //var token = prefs.getString("Token");
    debugPrint("Getting Plant Status info");
    debugPrint(prefs.getString("Token").toString());
    //final data = {'uid': uid};
    // final uri =
    //     Uri.parse('http://192.168.138.209.112.112:5000/api/android/update_phone_no');
    //api/android/get_trackPlant
    final uri = Uri.http('192.168.138.209:5000', '/api/android/get_trackPlant');
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

  Future getStatusData() async {
    final prefs = await SharedPreferences.getInstance();
    //var token = prefs.getString("Token");
    //final prefs = await SharedPreferences.getInstance();
    index = int.parse(prefs.getString("Tracking")!);
    debugPrint("LLLLLLLLLLLLL: ${prefs.getString("Tracking").toString()}");
    //index == null ? 0 : int.parse(prefs.getString("Tracking")!);
    debugPrint("Getting Plant Status info");
    debugPrint(prefs.getString("Token").toString());
    //final data = {'uid': uid};
    // final uri =
    //     Uri.parse('http://192.168.138.209.112.112:5000/api/android/update_phone_no');
    //api/android/get_trackPlant
    final uri = Uri.http('192.168.138.209:5000', '/api/android/get_trackPlant');
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
      // setState(() {

      // });
      Map<String, dynamic> data = json.decode(response.body);

      // Access values from the "data" array
      List<dynamic> dataArray = data['data'];
      List<dynamic> nameArray = data['displayName'];
      //email = data0['data']['email'];

      //debugPrint(dataArray.length.toString());
      Map<String, dynamic> namePointer = nameArray[0];
      username = namePointer['customer_fname'];
      Map<String, dynamic> firstDataItem = dataArray[index];
      //int id = firstDataItem['id'];
      int dataCount = firstDataItem['count'];
      int dataSoilMoisture = int.parse(firstDataItem['soil_moisture']);
      int dataHumidity = int.parse(firstDataItem['humidity']);
      int dataTemperature = int.parse(firstDataItem['temprature']);
      String dataPlantName = firstDataItem['plant_name'];
      String dataEnteredDate = firstDataItem['entered_date'];
      if (dataArray.length > 1) {
        plantAmount = "Plants";
      } else {
        plantAmount = "Plant";
      }
      // print('ID: $id');
      // print('Data Count: $dataCount');
      read = dataCount;
      water = dataSoilMoisture;
      temp = dataHumidity;
      humidity = dataHumidity;
      plant_name = dataPlantName; //This is another plant name var
      DateTime dateTime = DateTime.parse(dataEnteredDate);
      formattedDate = DateFormat.yMMMMd().format(dateTime);

      debugPrint('Data Soil Moisture: $dataSoilMoisture');
      debugPrint('Data Humidity: $dataHumidity');
      debugPrint('Data Temperature: $dataTemperature');
      debugPrint('Data Plant Name: $dataPlantName');
      debugPrint('Data Entered Date: $dataEnteredDate');
      debugPrint("$water $temp $humidity $read");
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
    getPlantList();

    super.initState();
  }

  ShakeDetector detector = ShakeDetector.autoStart(
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 5,
      onPhoneShake: () {
        Vibration.vibrate();
        debugPrint("Data has been refreshed!");
        //getStatusData();
      });

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
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckStatus()));
                },
                icon: const Icon(Icons.refresh_rounded)),
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
        body: FutureBuilder(
          future: getStatusData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Shimmer.fromColors(
                        baseColor: bk,
                        highlightColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.005),
                        child: const Card(
                          elevation: 0,
                          child: SizedBox(
                            height: 170,
                            width: 400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: bk,
                            highlightColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                            child: Text(
                              "Your Controls",
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).colorScheme.primary,
                          highlightColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                            ),
                          ),
                        ),
                        Shimmer.fromColors(
                            baseColor: Theme.of(context).colorScheme.primary,
                            highlightColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                              ),
                            )),
                        Shimmer.fromColors(
                            baseColor: Theme.of(context).colorScheme.primary,
                            highlightColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).colorScheme.primary,
                          highlightColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                            ),
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).colorScheme.primary,
                          highlightColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 120,
                            width: 245,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      color: bk,
                      elevation: 50,
                      surfaceTintColor: bk,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        height: 170,
                        width: 400,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Lottie.asset('animations/transfer_done.json',
                                reverse: true, height: 150),
                            Expanded(child: Container()),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Selam👋🏾 $username",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      Text(
                                        _greeting(),
                                        style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    formattedDate != null
                                        ? "Last read was on\n$formattedDate"
                                            .toString()
                                        : "Last 11's read was on\n...",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  const SizedBox(
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeDetail(
                                    animation: 'water_1.json',
                                    name: 'Moisture',
                                    height: 50,
                                    width: 50,
                                    data: water,
                                    des: "",
                                    sign: "%",
                                  ),
                                ));
                          },
                          onLongPress: () {
                            Vibration.vibrate();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Water(),
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
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
                                const Icon(
                                  Icons.water,
                                  size: 30,
                                  color: Colors.blueAccent,
                                ),
                                Text(
                                  "Moisture",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                Text(
                                  water != null ? "$water %".toString() : "",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeDetail(
                                    animation: 'therm.json',
                                    name: 'Temperature',
                                    height: 50,
                                    width: 50,
                                    data: temp,
                                    des:
                                        "Temperature is important for plants as it affects their growth and development. Each plant has a specific temperature range it prefers. Temperature influences germination, growth, and seasonal adaptations. Indoor plants have different temperature requirements. Providing suitable temperature conditions is crucial for plant health.",
                                    sign: "℃",
                                  ),
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
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
                                const Icon(
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
                                Text(
                                  temp != null ? "$temp ℃".toString() : "",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeDetail(
                                    animation: 'humidly.json',
                                    name: 'Humidity',
                                    height: 900,
                                    width: 900,
                                    data: humidity,
                                    des:
                                        "Humidity is important for plants as it affects their transpiration, disease risk, and overall health. Different plants have varying humidity preferences. High humidity can reduce water loss but may increase disease risk, while low humidity can lead to dehydration. Controlling humidity and ensuring proper air circulation is crucial for plant well-being.",
                                    sign: "%",
                                  ),
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
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
                                const Icon(
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
                                Text(
                                  humidity != null
                                      ? "$humidity %".toString()
                                      : "",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ReadDetail()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
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
                                const Icon(
                                  Icons.sensors,
                                  size: 30,
                                  //color: Colors.purple,
                                ),
                                Text(
                                  "Today",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                Text(
                                  read != null ? "$read reads".toString() : "",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // showDialog(
                            //   context: context,
                            //   builder: (context) => AlertDialog(
                            //     title: Text(
                            //       plant_name != null
                            //           ? "$plant_name".toString()
                            //           : "Loading...",
                            //       style: GoogleFonts.montserrat(
                            //         fontSize: 20,
                            //         fontWeight: FontWeight.w900,
                            //         fontStyle: FontStyle.normal,
                            //         // color: Colors.white,
                            //       ),
                            //     ),
                            //     content: Text(
                            //       "What would you like to do?",
                            //       style: GoogleFonts.montserrat(
                            //         fontSize: 15,
                            //         fontWeight: FontWeight.w500,
                            //         fontStyle: FontStyle.normal,
                            //         // color: Colors.white,
                            //       ),
                            //     ),
                            //     actions: [
                            //       Center(
                            //         child: Column(
                            //           crossAxisAlignment: CrossAxisAlignment.center,
                            //           mainAxisAlignment: MainAxisAlignment.center,
                            //           children: [
                            //             Padding(
                            //               padding: const EdgeInsets.all(5),
                            //               child: ElevatedButton.icon(
                            //                   onPressed: () {
                            //                     Navigator.pop(context);
                            //                     Navigator.push(
                            //                         context,
                            //                         MaterialPageRoute(
                            //                           builder: (context) =>
                            //                               const PlantList(),
                            //                         ));
                            //                   },
                            //                   icon: Icon(Icons.switch_right_rounded),
                            //                   label: Text(
                            //                     'Change plant',
                            //                     style: GoogleFonts.montserrat(
                            //                       fontSize: 15,
                            //                       fontWeight: FontWeight.w900,
                            //                       fontStyle: FontStyle.normal,
                            //                       // color: Colors.white,
                            //                     ),
                            //                   ),
                            //                   style: ElevatedButton.styleFrom(
                            //                     //backgroundColor: const Color(0xff2a9d8f),
                            //                     elevation: 0,
                            //                     minimumSize: const Size(400, 50),
                            //                     shape: RoundedRectangleBorder(
                            //                       borderRadius:
                            //                           BorderRadius.circular(50.0),
                            //                     ),
                            //                   )),
                            //             ),
                            //             Padding(
                            //               padding: const EdgeInsets.all(5),
                            //               child: ElevatedButton.icon(
                            //                   onPressed: () {
                            //                     debugPrint("sdhfsdj");
                            //                     Navigator.push(
                            //                         context,
                            //                         MaterialPageRoute(
                            //                           builder: (context) =>
                            //                               const Accept(),
                            //                         ));
                            //                   },
                            //                   icon: Icon(Icons.move_up),
                            //                   label: Text(
                            //                     'Transfer plant',
                            //                     style: GoogleFonts.montserrat(
                            //                       fontSize: 15,
                            //                       fontWeight: FontWeight.w900,
                            //                       fontStyle: FontStyle.normal,
                            //                       // color: Colors.white,
                            //                     ),
                            //                   ),
                            //                   style: ElevatedButton.styleFrom(
                            //                     //backgroundColor: const Color(0xff2a9d8f),
                            //                     elevation: 0,
                            //                     minimumSize: const Size(400, 50),
                            //                     shape: RoundedRectangleBorder(
                            //                       borderRadius:
                            //                           BorderRadius.circular(50.0),
                            //                     ),
                            //                   )),
                            //             ),
                            //           ],
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // );

                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                              ),
                              builder: (BuildContext context) {
                                return Container(
                                    height: 800,
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  size: 40,
                                                )),
                                          ),
                                          // Expanded(child: Container()),
                                          Text(
                                            "Currently \ntracking $plantName",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w900,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: ElevatedButton.icon(
                                                onPressed: () {
                                                  debugPrint("sdhfsdj");
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const PlantList(),
                                                      ));
                                                },
                                                icon: const Icon(
                                                    Icons.switch_right_rounded),
                                                label: Text(
                                                  'Track another plant',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w900,
                                                    fontStyle: FontStyle.normal,
                                                    // color: Colors.white,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  //backgroundColor: const Color(0xff2a9d8f),
                                                  elevation: 0,
                                                  minimumSize:
                                                      const Size(400, 50),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                  ),
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: ElevatedButton.icon(
                                                onPressed: () {
                                                  debugPrint("sdhfsdj");
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            TransferPlant(
                                                          name: plantName!,
                                                        ),
                                                      ));
                                                },
                                                icon: const Icon(
                                                    Icons.move_up_rounded),
                                                label: Text(
                                                  'Transfer your plant',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w900,
                                                    fontStyle: FontStyle.normal,
                                                    // color: Colors.white,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  //backgroundColor: const Color(0xff2a9d8f),
                                                  elevation: 0,
                                                  minimumSize:
                                                      const Size(400, 50),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                  ),
                                                )),
                                          ),
                                          Expanded(child: Container()),
                                          Text(
                                            "You have ${dataArray!.length.toString()} $plantAmount",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Row(
                                              children: List.generate(
                                                dataArray == null
                                                    ? 0
                                                    : dataArray!.length,
                                                (index) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: FilterChip(
                                                    selected: tracking,
                                                    onSelected: (tracking) {},
                                                    label: Text(
                                                      dataArray![index]
                                                          ["plant_name"],
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]));
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
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
                                const Icon(
                                  Icons.park_rounded,
                                  size: 30,
                                  color: Color(0xff5ab59a),
                                ),
                                Text(
                                  "Now tracking",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                Text(
                                  plant_name != null
                                      ? "$plant_name".toString()
                                      : "",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
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
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
