import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ProductDetail extends StatefulWidget {
  late String s_id;

  ProductDetail({super.key, required this.s_id});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  //Map? data;

  //List? lst;

  int index = 0;
  int? kebele;
  int? quantity;

  String? fName, lName, pName, img, phone, city, street;
  getDetailProduct() async {
    final data = {'s_id': widget.s_id};
    final uri = Uri.http('192.168.1.2:5000', '/s/specificProduct', data);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      debugPrint(response.body);
      var result = jsonDecode(response.body);
      //debugPrint(result.toString());
      //lst = result!["data"];

      pName = result['data']['s_name'];
      fName = result['data']['customer_fname'];
      lName = result['data']['customer_lname'];
      img = result['data']['s_image'];
      phone = result['data']['customer_phone_no'];
      city = result['data']['city'];
      kebele = result['data']['kebele'];
      street = result['data']['street'];
      quantity = result['data']['s_quanity'];

      debugPrint('IMAGE LINK!!!!!!! ${img}');
    } else {
      debugPrint("something went wrong");
      debugPrint(response.body);
    }
  }

  @override
  void initState() {
    getDetailProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getDetailProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return ListView(children: [
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
                              //'${widget.s_id}',
                              pName != null
                                  ? "$pName".toString()
                                  : "Loading...",
                              style: GoogleFonts.montserrat(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              //'${widget.s_id}',
                              pName != null
                                  ? "Posted by $fName $lName".toString()
                                  : "Loading...",
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Icon(Icons.verified_outlined)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        width: 400,
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Image.network(
                              img.toString(),
                              fit: BoxFit.cover,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 60,
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                          ),
                          child: Row(
                            children: [
                              Text(
                                textAlign: TextAlign.start,
                                phone != null
                                    ? "$fName's contact $phone".toString()
                                    : "Loading...",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                              Expanded(child: Container()),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: IconButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              'Please respect users privacy 🔏'),
                                        ));
                                      },
                                      icon: Icon(Icons.privacy_tip_outlined)))
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ]);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              getDetailProduct();
            });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Refreshed 🔃'),
            ));
          },
          child: Icon(Icons.refresh_outlined)),
    );
  }
}
