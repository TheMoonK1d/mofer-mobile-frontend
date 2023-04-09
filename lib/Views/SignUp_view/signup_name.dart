import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/Controller/AuthController/login_controller.dart';
import 'package:mofer/Views/SignUp_view/signup_contact_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mofer/main.dart';

import '../../Controller/AuthController/signup_controller.dart';


class SignUpNamePage extends StatefulWidget {

  final String fName, lName;

  const SignUpNamePage({super.key, required this.fName, required this.lName});

  @override
  State<SignUpNamePage> createState() => _SignUpNamePageState();
}

TextEditingController _fName = TextEditingController();
TextEditingController _lName = TextEditingController();
final formKey = GlobalKey<FormState>();

class _SignUpNamePageState extends State<SignUpNamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/new_bk.png"),
              // fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  textAlign: TextAlign.start,
                                  "Sign Up",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    textAlign: TextAlign.start,
                                    "Who should we call you?",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),

                    //First Name
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: _fName,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value)=> nameValidator(value, "First name"),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "First Name",
                              hintStyle: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        )),

                    const SizedBox(
                      height: 20,
                    ),

                    //Last Name
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: _lName,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value)=> nameValidator(value, "Last name"),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Last Name",
                              hintStyle: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: ElevatedButton(
                      onPressed: () {
                       if(formKey.currentState!.validate()){
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => SignUpContactPage(
                                 fName: _fName.text,
                                 lName: _lName.text,
                                 email: 'null',
                                 phone: 'null',)),
                         );
                       }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2a9d8f),
                        elevation: 20,
                        minimumSize: const Size(400, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Next',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.normal,
                          // color: Colors.white,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ));
  }
}
