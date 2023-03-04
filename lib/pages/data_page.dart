import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5db17f),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Color(0xff5db17f),
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark),
        backgroundColor: const Color(0xffe5e9d2),
        elevation: 0,
        title: Text(
          "Data",
          style: GoogleFonts.montserrat(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.normal,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.analytics_outlined),
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
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/test.png"), fit: BoxFit.cover),
        ),
        child: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                elevation: 5,
                child: SizedBox(
                  height: 300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
