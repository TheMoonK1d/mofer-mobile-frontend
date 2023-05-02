import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/models/signup_models.dart';

class InfoCheckPage extends StatelessWidget {
  final String fName, lName, email, phone, city, kebele, street, password;
  const InfoCheckPage({
    super.key,
    required this.password,
    required this.kebele,
    required this.city,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.email,
    required this.street,
  });

  @override
  Widget build(BuildContext context) {
    SignUp signup = SignUp(
        email, password, context, fName, lName, phone, street, kebele, city);

    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/new_bk.png"),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SafeArea(child: Container()),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            "Is this right?",
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
                padding: const EdgeInsets.all(10),
                child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "$fName $lName",
                          style: GoogleFonts.montserrat(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.normal,
                            // color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.email_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              email,
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.normal,
                                // color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.phone_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              phone,
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.normal,
                                // color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Icon(Icons.map_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "$city/$kebele/$street",
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.normal,
                                // color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 1,
                  backgroundColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                  minimumSize: const Size(400, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Go back',
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.normal,
                    // color: Colors.white,
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
            child: ElevatedButton(
                onPressed: () {
                  signup.signUp(context, email, password, kebele, city, phone,
                      street, fName, lName);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 20,
                  minimumSize: const Size(400, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Yes, Finish',
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.normal,
                    // color: Colors.white,
                  ),
                )),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    ));
  }
}
