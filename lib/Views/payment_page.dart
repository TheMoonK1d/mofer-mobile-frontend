import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mofer/Utils/dialog.dart';
import 'package:mofer/Views/payment_login.dart';
import 'package:mofer/models/bank_login.dart';
import 'package:slider_button/slider_button.dart';

//Might be null Test first

class PaymentPage extends StatefulWidget {
  final String uid;
  const PaymentPage({super.key, required this.uid});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Map? data;
  List? lst;
  int index = 0;
  late String new_amount;
  String paytxt = "You will pay";

  @override
  void initState() {
    getPackage();
    super.initState();
  }

  String removeTheSpace(String amount) {
    int index = amount.indexOf(' ');
    if (index == -1) {
      return new_amount = amount;
    } else {
      return new_amount = amount.substring(0, index);
    }
  }

  Future getPackage() async {
    debugPrint("Fetching data");
    final response = await http
        .get(Uri.parse('http://192.168.244.209:5000/api/android/allPackages'));
    debugPrint(response.statusCode.toString());
    data = jsonDecode(response.body);
    setState(() {
      lst = data!["data"];
    });
    debugPrint(lst.toString());
  }

  String amount = "";
  int id = 0;

  @override
  Widget build(BuildContext context) {
    var _uid = widget.uid.toString();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SafeArea(child: Container()),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          paytxt,
                          style: GoogleFonts.montserrat(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            textAlign: TextAlign.start,
                            "Double tap👆🏾 on a plan",
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            Expanded(
              child: PageView.builder(
                  itemCount: lst == null ? 0 : lst!.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onDoubleTap: () {
                          id = lst![index]["package_id"];
                          amount = lst![index]["package_price"];
                          removeTheSpace(amount);
                          debugPrint("$new_amount, $id, $_uid");

                          //Navigate to new page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentLogin(
                                        newAmount: new_amount,
                                        id: id,
                                        uid: _uid,
                                      )));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Card(
                              //surfaceTintColor: bk,
                              elevation: 20,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 350,
                                width: 400,
                                child: Padding(
                                  padding: const EdgeInsets.all(60),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${lst![index]["package_title"]}",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      Text(
                                        //Remember to change this
                                        "${lst![index]["package_description".toString()]}",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      Text(
                                        "Only for ${lst![index]["package_price"]}",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                "${lst![index]["swipe"]}",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w200,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
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
            ),
          ],
        ));
  }
}
