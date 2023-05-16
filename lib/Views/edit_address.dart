import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controller/AuthController/signup_controller.dart';
import '../models/edit_address_model.dart';

class EditAddress extends StatelessWidget {
  int address_id, kebele;
  String city, street;
  EditAddress(
      {super.key,
      required this.address_id,
      required this.city,
      required this.kebele,
      required this.street});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _city = TextEditingController();
    final TextEditingController _street = TextEditingController();
    final TextEditingController _kebele = TextEditingController();
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
                                "🗺",
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
                                "Where is your new location",
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
                  //City
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _city,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            locationValidator(value, "new city first"),
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
                          hintText: city,
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

                  //Street
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        controller: _street,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            locationValidator(value, "new street first"),
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
                          hintText: street,
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
                  //Kebele
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _kebele,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            locationValidator(value, "new kebele first"),
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
                          hintText: kebele.toString(),
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
                ],
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Some information will be updated after restart'),
                        ));
                        EditAddressModel editAddressModel = EditAddressModel();
                        // TODO: Fix null passing
                        editAddressModel.updateAddress(address_id, _city.text,
                            _street.text, _kebele.text, 'null', context);
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
