import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/Views/product_detail_view.dart';
import 'package:mofer/Views/search_view.dart';
import 'package:mofer/Views/settings_page.dart';
import 'package:http/http.dart' as http;

import 'my_products.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

Map? data;
List? lst;
int index = 0;
String? id;

class _MarketPageState extends State<MarketPage> {
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  Future getProducts() async {
    debugPrint("Fetching products");
    final response =
        await http.get(Uri.parse('http://192.168.1.2:5000/s/allProducts'));
    debugPrint(response.statusCode.toString());
    data = jsonDecode(response.body);
    lst = data!["data"];
    debugPrint(lst.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Market",
            style: GoogleFonts.montserrat(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.normal,
            ),
          ),
          automaticallyImplyLeading: false,
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
        body: FutureBuilder(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Wait");
            }
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: Row(
                    children: [
                      Flexible(
                          child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const Search())));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(children: [
                              const Icon(Icons.search_rounded),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Search here",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  //color: const Color(0xff2a9d8f),
                                ),
                              )
                            ]),
                          ),
                        ),
                      )),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                        ),
                        child: Center(
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MyProduct(),
                                    ));
                              },
                              icon: const Icon(Icons.shopping_bag_rounded)),
                        ),
                      )
                    ],
                  ),
                ),
                Flexible(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: RefreshIndicator(
                          // trigger the _loadData function when the user pulls down
                          //onRefresh: getProducts(),
                          onRefresh: () {
                            return getProducts();
                          },
                          // Render the todos
                          child: MasonryGridView.builder(
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
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
                                          builder: ((context) => ProductDetail(
                                                s_id: id!,
                                              ))));
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        child: Image.network(
                                            "${lst![index]["s_image"]}")),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      height: 70,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.1),
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              bottomRight:
                                                  Radius.circular(15))),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${lst![index]["s_name"]}',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                            //s_quanity
                                            Text(
                                              '${lst![index]["s_quanity"]} amount',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                // color: Colors.white,
                                              ),
                                            )
                                          ]),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )))
              ],
            );
          },
        ));
  }
}
