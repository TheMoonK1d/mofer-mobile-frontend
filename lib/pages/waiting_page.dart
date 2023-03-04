import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avatar_glow/avatar_glow.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({Key? key}) : super(key: key);

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xffe5e9d2),
            systemNavigationBarColor: Color(0xff5db17f),
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Connecting...",
          style: GoogleFonts.montserrat(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.normal,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Icon(Icons.more_vert_rounded),
              ))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/test.png"), fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SafeArea(child: Container()),
              AvatarGlow(
                glowColor: const Color(0xFF5db17f),
                endRadius: 120,
                duration: const Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                curve: Curves.easeOutQuad,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: const Color(0xFF5db17f),
                      borderRadius: BorderRadius.circular(99)),
                  child: const Icon(
                    Icons.wifi,
                    color: Color(0xFF14171A),
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Expanded(child: Container()),
            ],
          )),
    );
  }
}
