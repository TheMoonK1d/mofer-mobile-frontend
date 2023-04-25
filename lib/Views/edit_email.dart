import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Controller/AuthController/auth_validation_controller.dart';

class EditEmail extends StatefulWidget {
  const EditEmail({Key? key}) : super(key: key);

  @override
  State<EditEmail> createState() => _EditEmailState();
}

final TextEditingController _email = TextEditingController();
final formKey = GlobalKey<FormState>();

class _EditEmailState extends State<EditEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
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
                                  "Email",
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
                                Text(
                                  textAlign: TextAlign.start,
                                  "What is your new email",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),

                    //Email
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _email,
                          autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                          validator: (email) => emailValidator(email),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                            hintText: "Email",
                            hintStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),

                        )),
                  ],
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: ElevatedButton(
                      onPressed: () { },
                      style: ElevatedButton.styleFrom(
                        elevation: 20,
                        minimumSize: const Size(400, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Update',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
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

        ));
  }
}
