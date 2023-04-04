import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/Bank%20ui/bank_login_page.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Map? data;
  List? lst;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getPackage();
    debugPrint("Ready!");
  }

  Future getPackage() async {
    debugPrint("Fetching data");
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    debugPrint(response.statusCode.toString());
    var decode = jsonDecode(response.body);

    data = jsonDecode(response.body);

    setState(() {
      lst = data!["data"];
    });
    debugPrint(lst.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Payment",
            style: GoogleFonts.montserrat(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.normal,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: PageView.builder(
                  itemCount: lst == null ? 0 : lst!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Swipe 👈 to see listings",
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          Card(
                            elevation: 5,
                            child: Container(
                              height: 500,
                              width: 300,
                              child: Column(
                                children: [
                                  Text("${lst![index]["email"]}"),
                                  Text("${lst![index]["first_name"]}"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                    value: false,
                    onChanged: (dynamic t) {
                      setState(() {});
                    }),
                Text(
                  "Accept terms and conditions",
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 1,
                  minimumSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  //get pkg id and amount
                  //pass it to next page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BankLoginPage()),
                  );
                },
                icon: const Icon(Icons.payment_outlined),
                label: Text(
                  "Continue",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Read Terms & Conditions here",
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ],
        ));
  }
}

class Package {
  String title, desc;
  int price;

  Package(this.title, this.desc, this.price);
}
