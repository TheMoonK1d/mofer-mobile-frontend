import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/Controller/AuthController/signup_controller.dart';
import 'package:mofer/Views/SignUp_view/signup_password_page.dart';


class SignUpAddressPage extends StatelessWidget {
  final String fName, lName, email, phone;
  SignUpAddressPage({
    super.key,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.email
  });
  final TextEditingController _city = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _kebele =  TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/new_bk.png"),
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
                                Text(
                                  textAlign: TextAlign.start,
                                  "Where to find you?",
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
                            validator: (value)=> locationValidator(value, "City"),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none
                              ),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                              hintText: "City",
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
                            validator: (value)=> locationValidator(value, "Street"),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none
                              ),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                              hintText: "Street",
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
                            validator: (value)=> locationValidator(value, "Kebele"),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none
                              ),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                              hintText: "Kebele",
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
                        if(formKey.currentState!.validate()){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPasswordPage(
                                fName: fName,
                                email: email,
                                phone: phone,
                                lName: lName,
                                city: _city.text,
                                kebele: _kebele.text,
                                street: _street.text,
                                password: 'null',
                              )),
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

