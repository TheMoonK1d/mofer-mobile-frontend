import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../Controller/payment_controller.dart';
import 'Bank_view/bank_login_page.dart';


class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Map? data;
  List? lst;
  int index = 0;
  late String new_amount;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getPackage();
    debugPrint("Ready!");
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
    final response =
        await http.get(Uri.parse('http://192.168.1.6:5000/p/allPackages'));
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
    return Scaffold(

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
                          "Payment",
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
                          onDoubleTap: (){
                            id = lst![index]["package_id"];
                            debugPrint(id.toString());
                            amount = lst![index]["package_price"];
                            debugPrint(amount.toString());
                            removeTheSpace(amount);
                            debugPrint(new_amount);
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> BankLoginPage(id: id.toString(), amount: new_amount,)));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              Card(
                                elevation: 5,
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height-350,
                                  width: 400,
                                  child: Padding(
                                    padding: const EdgeInsets.all(60),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [


                                        Text(
                                          "${lst![index]["package_title"]}",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 50,
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
                      ),),
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