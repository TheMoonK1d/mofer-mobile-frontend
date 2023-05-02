import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/Views/edit_address.dart';
import 'package:mofer/Views/edit_email.dart';
import 'package:mofer/Views/edit_name.dart';
import 'package:mofer/Views/edit_password.dart';
import 'package:mofer/Views/edit_phone.dart';
import 'package:mofer/Views/login.dart';
import 'package:http/http.dart' as http;
import 'package:mofer/models/edit_user_status_model.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

bool? _checkBoxValue = false, status = false;
int? address_id, kebele;
String? uid, fName, lName, phone, city, street, email, fullName;
EditUserStatusModel editUserStatus = EditUserStatusModel();

class _SettingPageState extends State<SettingPage> {
  Future getSettingsData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
    debugPrint("Getting user info");
    final data = {'uid': uid};
    final uri = Uri.http('192.168.1.2:5000', '/c/get_user', data);
    final response = await http.get(uri);
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
        kebele = int.parse(data0['data']['kebele']);
        street = data0['data']['street'];
      });
      debugPrint("$fName $lName $phone $email");
      // debugPrint("EXP: $exp");
      // debugPrint("DSL: $dsl");
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
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
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
            padding: const EdgeInsets.all(10),
            child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
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
                              editUserStatus.updateUserStatus(uid);
                              setState(() {
                                status = t;
                              });
                              FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            value: status!,
                          ),
                        ],
                      )),
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.email_outlined),
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
                            )));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: Text(
                fullName != null ? "$fullName".toString() : "Loading...",
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
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.password_outlined),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditPassword()));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.numbers_outlined),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditPhone()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.location_on_outlined),
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
                            )));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 10,
        onPressed: () {
          setState(() {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
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
    );
  }
}
