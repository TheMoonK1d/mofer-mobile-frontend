import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/pages/data_page.dart';
import 'package:mofer/pages/home_page.dart';
import 'package:mofer/pages/waiting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  final page = [
    const HomePage(),
    const DataPage(),
    const WaitingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5db17f),
      body: page[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            //indicatorColor: const Color(0xFF1F2429),
            labelTextStyle: MaterialStateProperty.all(
          GoogleFonts.montserrat(
            fontSize: 10,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            //color: Colors.white
          ),
        )),
        child: NavigationBar(
          onDestinationSelected: (index) {
            setState(() {
              this.index = index;
            });
          },
          height: 60,
          elevation: 0,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          backgroundColor: const Color(0xFF5db17f),
          selectedIndex: index,
          destinations: const [
            NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                  //color: Colors.white,
                ),
                label: "Home",
                selectedIcon: Icon(
                  Icons.home_rounded,
                  size: 25,
                  // color: Colors.teal,
                )),
            NavigationDestination(
                icon: Icon(
                  Icons.data_usage_outlined,
                  //color: Colors.white,
                ),
                label: "Date",
                selectedIcon: Icon(
                  Icons.data_usage_rounded,
                  size: 25,
                  //color: Colors.teal,
                )),
            NavigationDestination(
                icon: Icon(
                  Icons.shopping_basket_outlined,
                  //color: Colors.white,
                ),
                label: "Market",
                selectedIcon: Icon(
                  Icons.shopping_basket_rounded,
                  size: 25,
                  //color: Colors.teal,
                ))
          ],
        ),
      ),
    );
  }
}
