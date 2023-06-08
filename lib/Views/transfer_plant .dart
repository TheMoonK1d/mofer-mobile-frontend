import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:google_fonts/google_fonts.dart';

class TransferPlant extends StatefulWidget {
  const TransferPlant({Key? key}) : super(key: key);

  @override
  State<TransferPlant> createState() => _TransferPlantState();
}

int qnt = 1;

class _TransferPlantState extends State<TransferPlant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "Transfer",
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
          Padding(
            padding: EdgeInsets.all(30),
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(Icons.add_photo_alternate_rounded),
            ),
          ),

          //quantity
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  textAlign: TextAlign.start,
                  "Quantity",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (qnt == 1) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Minimum one'),
                              ));
                              Vibration.vibrate();
                            } else {
                              qnt--;
                            }
                          });
                        },
                        icon: const Icon(Icons.exposure_minus_1_rounded)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 70,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.start,
                      "$qnt",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          qnt++;
                        });
                      },
                      icon: const Icon(Icons.exposure_plus_1_rounded)),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  textAlign: TextAlign.start,
                  "Price",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  height: 50,
                  width: 190,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                        child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                    )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
