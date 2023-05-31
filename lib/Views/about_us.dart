import 'package:flutter/material.dart';
import 'package:flutter_about_page/flutter_about_page.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    AboutPage ab = AboutPage();
    ab.customStyle(
        descFontFamily: "Roboto", listTextFontFamily: "RobotoMedium");

    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            ab.setImage("assets/final.png"),
            ab.addWidget(
              Text(
                'Mofer is an IOT based smart farming solution built as a proof of concept by 4th year C.S students at st mary university',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            ab.addWidget(
              Text(
                'Version: 8.0 (Alpha)',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            ab.addWidget(
              Text(
                'Code name: Gomen',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            ab.addWidget(
              Text(
                'Mofer for Android',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            ab.addWidget(
              Text(
                'Meet the team',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: CircleAvatar(
                    child: Text(
                  'AT',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                )),
                title: Text(
                  'Abinet Tamiru',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                subtitle: Text(
                  'Back-End & Security',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: CircleAvatar(
                    child: Text(
                  'ED',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                )),
                title: Text(
                  "Eyob Desta",
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                //trailing: const Icon(Icons.edit),
                subtitle: Text(
                  'Mobile Front-End',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: CircleAvatar(
                    child: Text(
                  'HC',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                )),
                title: Text(
                  'Hiwot Chernet ',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                subtitle: Text(
                  'Embedded systems developer',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: CircleAvatar(
                    child: Text(
                  'RD',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                )),
                title: Text(
                  'Ruth Damtew',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                subtitle: Text(
                  'System architect',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: CircleAvatar(
                    child: Text(
                  'TB',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                )),
                title: Text(
                  'Tsegazeab Befikadu',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                subtitle: Text(
                  'Web Front-End',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
