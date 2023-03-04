import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _greeting() {
    final hour = TimeOfDay.now().hour;
    if (hour <= 12) {
      return "Good Morning 🌤";
    } else if (hour <= 17) {
      return "Good Afternoon ⛅";
    }
    return "Good Evening 🌙";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5db17f),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Color(0xff5db17f),
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark),

        backgroundColor: const Color(0xffe5e9d2),
        elevation: 0,
        title: Text(
          "Home",
          style: GoogleFonts.montserrat(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.normal,
          ),
        ),
        automaticallyImplyLeading: false,
        //leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu_rounded)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_active_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_outlined),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/test.png"), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(child: Container()),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                _greeting(),
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                elevation: 10,
                child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    width: 150,
                    // decoration: BoxDecoration(
                    //   borderRadius: const BorderRadius.all(Radius.circular(20)),
                    //   color: Colors.white,
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.black.withOpacity(0.2),
                    //       spreadRadius: 2,
                    //       blurRadius: 10,
                    //       offset:
                    //           const Offset(0, 7), // changes position of shadow
                    //     ),
                    //   ],
                    // ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "27°",
                          style: GoogleFonts.montserrat(
                            fontSize: 50,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          "Today",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Text(
                          "Looks good",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
