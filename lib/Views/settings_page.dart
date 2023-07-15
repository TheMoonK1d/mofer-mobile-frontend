import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/Views/edit_address.dart';
import 'package:mofer/Views/edit_email.dart';
import 'package:mofer/Views/edit_name.dart';
import 'package:mofer/Views/edit_password.dart';
import 'package:mofer/Views/edit_phone.dart';
import 'package:mofer/Views/login.dart';
import 'package:http/http.dart' as http;
import 'package:mofer/models/edit_user_status_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/dialog.dart';
import 'about_us.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

bool? status = false;
int? address_id, kebele;
String? uid, fName, lName, phone, city, street, email, fullName;
EditUserStatusModel editUserStatus = EditUserStatusModel();

class _SettingPageState extends State<SettingPage> {
  Future getSettingsData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
    final prefs = await SharedPreferences.getInstance();
    //var token = prefs.getString("Token");
    debugPrint("Getting user info");
    final data = {'uid': uid};
    final uri = Uri.http('192.168.8.209:5000', '/api/android/get_user', data);
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': prefs.getString("Token").toString(),
      },
    );
    // headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': prefs.getString("Token").toString(),
    //   },
    var data0 = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        email = data0['data']['email'];
        fName = data0['data']['customer_fname'];
        lName = data0['data']['customer_lname'];
        fullName =
            "${data0['data']['customer_fname'].toString()} ${lName = data0['data']['customer_lname'].toString()}";
        phone = data0['data']['customer_phone_no'];
        status = data0['data']['customer_status'];
        debugPrint(status.toString());
        address_id = data0['data']['address_id'];
        city = data0['data']['city'];
        kebele = data0['data']['kebele'];
        street = data0['data']['street'];
      });
      debugPrint("$fName $lName $phone $email");
      // debugPrint("EXP: $exp");
      // debugPrint("DSL: $dsl");
    } else if (response.statusCode == 401) {
      if (context.mounted) {
        loadingDialog(context);
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    } else {
      debugPrint("$uid does not exist");
    }
  }

  @override
  void initState() {
    getSettingsData();
    super.initState();
  }

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
          body: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(strokeWidth: 6);
              } else {
                return ListView(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  textAlign: TextAlign.start,
                                  "Settings",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                          elevation: 0,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.05),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: SizedBox(
                                height: 130,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Under maintenance',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    Text(
                                      'Expect possible slowdowns we will fix this soon. Thank you for your patience.',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w200,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text(
                                                  "Apologies for the inconvenience.",
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w900,
                                                    fontStyle: FontStyle.normal,
                                                    // color: Colors.white,
                                                  ),
                                                ),
                                                content: Text(
                                                  "Our platform is still on alpha and we are working hard to enhance your experience. Thank you for your understanding.",
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                    // color: Colors.white,
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "Okay",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        // color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Why am i seeing this?',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                          elevation: 0,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.05),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                                height: 80,
                                child: Row(
                                  children: [
                                    Text(
                                      'Activated',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Switch(
                                      onChanged: (t) {
                                        //Function
                                        editUserStatus.updateUserStatus(
                                            uid, context);
                                        setState(() {
                                          status = t;
                                        });
                                        FirebaseAuth.instance.signOut();
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));
                                      },
                                      value: status!,
                                    ),
                                  ],
                                )),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: const Icon(Icons.email_rounded),
                        title: Text(
                          email != null ? email.toString() : "Loading...",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        subtitle: Text(
                          'Change Email',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        onTap: () {
                          debugPrint(uid);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditEmail(
                                        uid: uid!,
                                        email: email!,
                                      )));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: const Icon(Icons.account_circle_rounded),
                        title: Text(
                          fullName != null
                              ? "$fullName".toString()
                              : "Loading...",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        subtitle: Text(
                          'Change name',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditName(
                                        lName: lName!,
                                        fName: fName!,
                                        uid: uid!,
                                      )));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: const Icon(Icons.password_rounded),
                        title: Text(
                          'Password',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        subtitle: Text(
                          'Change password',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EditPassword()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: const Icon(Icons.numbers_rounded),
                        title: Text(
                          phone != null ? phone.toString() : "09******",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        //trailing: const Icon(Icons.edit),
                        subtitle: Text(
                          'Change phone number',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditPhone(
                                        phone: phone!,
                                      )));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: const Icon(Icons.location_on_rounded),
                        title: Text(
                          'Location',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        subtitle: Text(
                          'Change you address',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditAddress(
                                        address_id: address_id!,
                                        city: city!,
                                        kebele: kebele!,
                                        street: street!,
                                      )));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: const Icon(Icons.group_rounded),
                        title: Text(
                          'About Us',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        subtitle: Text(
                          'Lets us meet',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AboutUs()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: const Icon(Icons.question_answer_rounded),
                        title: Text(
                          'FAQ',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        subtitle: Text(
                          'If you have any thing to ask',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text(
                                "FAQ",
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                              content: const Text(
                                "Try to read more on our website mofer.meinab.com/faq",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Okay",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          "Made by the mofer team, with ❤",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            elevation: 10,
            onPressed: () {
              //loadingDialog(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Logged Out!'),
              ));
              setState(() {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              });
            },
            label: Row(
              children: [
                Text(
                  'Logout',
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
