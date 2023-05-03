import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mofer/Views/check_status.dart';
import 'data_page.dart';
import 'home_page.dart';
import 'market_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  int _selectedIndex = 0;
  DateTime? _currentBackPressTime;
  final page = [const CheckStatus(), const DataPage(), const MarketPage()];
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DataPage(),
    MarketPage()
  ];

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
      child: WillPopScope(
        onWillPop: () async {
          DateTime now = DateTime.now();
          if (_currentBackPressTime == null ||
              now.difference(_currentBackPressTime!) >
                  const Duration(seconds: 2)) {
            _currentBackPressTime = now;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Press back button again to exit'),
              ),
            );
            return false;
          }
          return true;
        },
        child: Scaffold(
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: navColor,
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: navColor,
                  hoverColor: navColor,
                  gap: 8,
                  activeColor: Theme.of(context).colorScheme.primary,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  tabs: const [
                    GButton(
                      icon: Icons.home_outlined,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.data_exploration_outlined,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      text: 'Data',
                    ),
                    GButton(
                      icon: Icons.shopping_cart_outlined,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      text: 'Market',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Object _onBackPressed(BuildContext context) {
  return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              ElevatedButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        },
      ) ??
      false;
}
