import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          IconButton(onPressed: (){}, icon: Icon(Icons.settings))
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          FirebaseAuth.instance.signOut();
        },
        child: const Icon(Icons.logout_rounded),
      ),
    );

  }
}

