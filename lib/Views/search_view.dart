import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    Color navColor = ElevationOverlay.applySurfaceTint(
        Theme.of(context).colorScheme.surface,
        Theme.of(context).colorScheme.surfaceTint,
        0);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarContrastEnforced: true,
          systemNavigationBarColor: navColor,
          statusBarColor: navColor,
          systemNavigationBarDividerColor: navColor,
          systemNavigationBarIconBrightness:
              Theme.of(context).brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
        ),
        child: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          "Search",
                          style: GoogleFonts.montserrat(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      child: Row(
                        children: [
                          Flexible(
                              child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => const Search())));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(children: [
                                  const Icon(Icons.search_rounded),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  // Text(
                                  //   "Search here",
                                  // style: GoogleFonts.montserrat(
                                  //   fontSize: 15,
                                  //   fontWeight: FontWeight.w500,
                                  //   fontStyle: FontStyle.normal,
                                  //   //color: const Color(0xff2a9d8f),
                                  // ),
                                  // )
                                  Flexible(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none),
                                        hintText: "Search here",
                                        hintStyle: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          )),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2),
                            ),
                            child: Center(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.tune_rounded)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.start,
                          "Searching?\nWe are all searching,\nSearching for something that can\nfill the void,but sadly it is not here\natleast not for now\nGood luck",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ])),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            onPressed: () {},
            child: const Icon(Icons.clear_all_rounded),
          ),
        ));
  }
}
