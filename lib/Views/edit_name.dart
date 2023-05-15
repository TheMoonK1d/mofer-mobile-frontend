import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/models/edit_name_model.dart';

import '../Controller/AuthController/signup_controller.dart';

class EditName extends StatelessWidget {
  //const EditName({Key? key}) : super(key: key);
  String fName, lName, uid;
  EditName(
      {super.key, required this.fName, required this.lName, required this.uid});

  @override
  Widget build(BuildContext context) {
    TextEditingController _fName = TextEditingController();
    TextEditingController _lName = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                                "🆔",
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
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: _fName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            nameValidator(value, "First name"),
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
                          hintText: fName,
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

                  //Last Name
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: _lName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => nameValidator(value, "Last name"),
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
                          hintText: lName,
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
                      if (formKey.currentState!.validate()) {
                        EditNameModel edit = EditNameModel();
                        edit.updateName(_fName.text, _lName.text, uid, context);
                      }
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
