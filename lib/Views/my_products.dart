import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mofer/Views/product_detail_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

Map? data;
List? lst;
int index = 0;
String? id;
User? user = FirebaseAuth.instance.currentUser;
String? uid;

class _MyProductState extends State<MyProduct> {
  @override
  void initState() {
    getMyProducts();
    super.initState();
  }

  Future getMyProducts() async {
    if (user != null) {
      uid = user!.uid;
    }
    debugPrint("Fetching Your Product List ...");
    final _data = {'customer_uid': uid};
    final prefs = await SharedPreferences.getInstance();

    final uri = Uri.http(
        '192.168.244.209:5000', '/api/android/specificUserProduct', _data);
    var response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': prefs.getString("Token").toString(),
      },
    );
    debugPrint(response.statusCode.toString());
    data = jsonDecode(response.body);
    lst = data!["data"];
    debugPrint(lst.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getMyProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Column(children: [
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Row(
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              "My Products 🛒",
                              style: GoogleFonts.montserrat(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Flexible(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: RefreshIndicator(
                        onRefresh: () {
                          return getMyProducts();
                        },
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: lst == null ? 0 : lst!.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                id = lst![index]["S_id"].toString();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetail(s_id: id!),
                                    ));
                              },
                              child: SizedBox(
                                height: 200,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  child: Image.network(
                                    "${lst![index]["s_image"]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )))
            ]);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, child: const Icon(Icons.add_rounded)),
    );
  }
}
