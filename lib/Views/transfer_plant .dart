import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransferPlant extends StatelessWidget {
  const TransferPlant({Key? key}) : super(key: key);

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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SizedBox(
                      height: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Plant Transfer Alert',
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w200,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          Expanded(child: Container()),
                          Text(
                            'Transferring your plant to the marketplace will result in data loss and make it available for sale to others.\nYou can still cancel',
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          Expanded(child: Container()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        "Apologies for the inconvenience.",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.normal,
                                          // color: Colors.white,
                                        ),
                                      ),
                                      content: Text(
                                        "Our platform is still on alpha and we are working hard to enhance your experience. Thank you for your understanding.",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          // color: Colors.white,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Okay",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                              fontStyle: FontStyle.normal,
                                              // color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Text(
                                  'Why am i seeing this?',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                )),
          ),
        ],
      ),
    );
  }
}
