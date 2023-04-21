import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/Views/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: GoogleFonts.montserrat(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.normal,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () {

        }, icon: const Icon(Icons.notifications_active_rounded)),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const SettingPage()));
          }, icon: const Icon(Icons.settings))

        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 200,
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Placeholder(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
                height: 200,
                child: Card()),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
                height: 200,
                child: Placeholder()),
          ),

        ],
      ),
    );
  }
}
