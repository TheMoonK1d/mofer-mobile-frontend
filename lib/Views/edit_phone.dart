import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/models/edit_phone_model.dart';
import '../Controller/edit_phone_controller.dart';

class EditPhone extends StatelessWidget {
  String phone;
  EditPhone({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _phone = TextEditingController();
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
                                "☎",
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
                                "What is your new number?",
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

                  //Phone
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 56,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              '🇪🇹 +251',
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _phone,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => newPhoneValidator(value),
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
                              hintText: phone,
                              hintStyle: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: ElevatedButton(
                    onPressed: () {
                      EditPhoneModel editPhoneModel = EditPhoneModel();
                      //Fix this
                      //Don't pass null.
                      editPhoneModel.updatePhone(_phone.text, 'null', context);
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
