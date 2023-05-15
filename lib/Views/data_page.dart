import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mofer/Views/settings_page.dart';

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
        body:
            // ListView(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            //       child: Container(
            //           decoration: BoxDecoration(
            //             color:
            //                 Theme.of(context).colorScheme.primary.withOpacity(0.3),
            //             borderRadius: BorderRadius.circular(20),
            //           ),
            //           child: Padding(
            //             padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.end,
            //               children: [
            //                 Text(
            //                   textAlign: TextAlign.start,
            //                   "Plant Name",
            //                   style: GoogleFonts.montserrat(
            //                     fontSize: 25,
            //                     fontWeight: FontWeight.w300,
            //                     fontStyle: FontStyle.normal,
            //                   ),
            //                 ),
            //                 Text(
            //                   textAlign: TextAlign.start,
            //                   "Plant type",
            //                   style: GoogleFonts.montserrat(
            //                     fontSize: 15,
            //                     fontWeight: FontWeight.w200,
            //                     fontStyle: FontStyle.normal,
            //                   ),
            //                 ),
            //                 Stack(
            //                   alignment: Alignment.bottomCenter,
            //                   children: [
            //                     Container(
            //                       height: 100,
            //                       decoration: BoxDecoration(
            //                           color: Theme.of(context)
            //                               .colorScheme
            //                               .primary
            //                               .withOpacity(0.2),
            //                           borderRadius: const BorderRadius.only(
            //                               bottomLeft: Radius.circular(20),
            //                               bottomRight: Radius.circular(20),
            //                               topLeft: Radius.circular(100))),
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            //                       child: SizedBox(
            //                           height: 210,
            //                           child: Image.asset('assets/pngtree.png')),
            //                     )
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           )),
            //     ),
            //   ],
            // )
            Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Lottie.asset('animations/nothing_here_full.json',
                    reverse: true, height: 300),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nothing here",
                    style: GoogleFonts.montserrat(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  Text(
                    "For now 🌱",
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
