import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/Controller/AuthController/auth_validation_controller.dart';
import 'package:mofer/Controller/AuthController/login_controller.dart';
import 'package:mofer/Views/forgot_password.dart';
import 'package:flutter/services.dart';
import 'package:mofer/models/login_model.dart';
import 'SignUp_view/signup_name.dart';

//backgroundColor: const Color(0xff2a9d8f),

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  DateTime? _currentBackPressTime;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Login login = Login();
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
            child: SafeArea(
              child: SafeArea(
                child: Scaffold(
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
                          Expanded(
                              child: Center(
                                  child: SizedBox(
                            height: 300,
                            width: 200,
                            child: Image.asset(
                              "assets/final.png",
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ))),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Text(
                                      textAlign: TextAlign.start,
                                      "Sign In",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Email
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (email) => emailValidator(email),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15.0, horizontal: 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none),
                                      filled: true,
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.2),
                                      hintText: "Email",
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

                              //password
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    controller: passwordController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) =>
                                        passwordValidator(value),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15.0, horizontal: 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none),
                                      filled: true,
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.2),
                                      hintText: "Password",
                                      hintStyle: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  )),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgotPassword()));
                                        },
                                        child: Text(
                                          "Forgot password?",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            //color: const Color(0xff2a9d8f),
                                          ),
                                        )),
                                  ],
                                ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 5, 20, 10),
                                child: ElevatedButton(
                                    onPressed: () {
                                      //signIn(context, emailController.text , passwordController.text);
                                      if (formKey.currentState!.validate()) {
                                        login.signIn(
                                            context,
                                            emailController.text,
                                            passwordController.text);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      //backgroundColor: const Color(0xff2a9d8f),
                                      elevation: 20,
                                      minimumSize: const Size(400, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: Text(
                                      'Log in',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FontStyle.normal,
                                        // color: Colors.white,
                                      ),
                                    )),
                              ),

                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpNamePage(
                                                fName: 'null',
                                                lName: 'null',
                                              )),
                                    );
                                  },
                                  child: Text(
                                    "Create an account",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      //color: const Color(0xff2a9d8f),
                                      //0xFF0d1b2a
                                    ),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}
