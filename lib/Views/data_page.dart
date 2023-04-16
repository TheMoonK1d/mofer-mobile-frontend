import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  @override
  Widget build(BuildContext context) {
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
      ),
      body: Column(
        children: [
          Expanded(child:
          PageView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child:  Container(

                  decoration: BoxDecoration(
                      color: Color(0xffddc4be),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        "Plant Name",
                        style: GoogleFonts.montserrat(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [

                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: Color(0xffe5ccc5),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))
                            ),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20), child: SizedBox(
                              height: 210,
                              child: Image.asset('assets/pngtree.png')),)
                        ],
                      ),
                    ],
                  )
                ),

              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child:  Container(

                    decoration: BoxDecoration(
                      color: Color(0xffb6c9d5),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          "Plant Name",
                          style: GoogleFonts.montserrat(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [

                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Color(0xffc2d4df),
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))
                              ),
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20), child: SizedBox(
                                height: 210,
                                child: Image.asset('assets/pngtree.png')),)
                          ],
                        ),
                      ],
                    )
                ),

              ),

            ],
          )),
          Expanded(child: Column())
        ],
      ),
    );
  }
}
