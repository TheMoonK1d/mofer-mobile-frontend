import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/models/bank_login.dart';
import '../Controller/edit_password_controller.dart';
import '../models/edit_password_model.dart';

class EditPassword extends StatelessWidget {
  const EditPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _password = TextEditingController();
    final TextEditingController _cPassword = TextEditingController();
    final formKey = GlobalKey<FormState>();
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
                                "🔐",
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
                                "Changing password, good habit.",
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
                  //Password
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        controller: _password,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => editPasswordValidator(value),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none),
                          filled: true,
                          prefixIcon: const Icon(Icons.edit_rounded),
                          fillColor: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.2),
                          hintText: "New password",
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),

                  //Confirm Password
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        controller: _cPassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => editCPasswordValidator(value),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none),
                          filled: true,
                          prefixIcon: const Icon(Icons.edit_rounded),
                          fillColor: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.2),
                          hintText: "Confirm new password",
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
                    onPressed: () {
                      EditPasswordModel editPassword = EditPasswordModel();
                      editPassword.updatePassword(_password.text, uid, context);
                    },
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
