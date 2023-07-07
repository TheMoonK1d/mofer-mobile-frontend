import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/models/bank_login.dart';
import 'package:mofer/models/opt_model.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

// Send token, amount, receiver account

//create an await function that will receive order id

//when received render otp page
class OTPPage extends StatefulWidget {
  final String phone, order_id, token, uid, id;
  OTPPage(
      {super.key,
      required this.phone,
      required this.order_id,
      required this.token,
      required this.uid,
      required this.id});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  CurvedAnimation? curve;
  OtpFieldController otpController = OtpFieldController();
  int _counter = 60;
  late Timer _timer;
  DateTime? _currentBackPressTime;
  @override
  void initState() {
    //controller!.forward();
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    curve = CurvedAnimation(
        parent: controller!, curve: Curves.fastLinearToSlowEaseIn);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    OTPModel otp = OTPModel(context);
    var _id = widget.id;
    var _uid = widget.uid;

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
                  content: Text('Please try not exit the app at this stage'),
                ),
              );
              return false;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'It is not a good idea to close the app at this stage'),
              ),
            );
            return false;
          },
          child: Scaffold(
              body:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SafeArea(child: Container()),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          "📬",
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
                            "Enter SMS sent to $phone",
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
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
              child: OtpTextField(
                numberOfFields: 4,
                autoFocus: true,
                fieldWidth: 60,
                filled: true,
                fillColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderColor: navColor,
                borderWidth: 5,
                decoration: const InputDecoration(border: InputBorder.none),

                focusedBorderColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.5),
                enabledBorderColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.01),

                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                borderRadius: const BorderRadius.all(Radius.circular(15)),

                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String pin) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Verification Code"),
                          content: Text('Code entered is $pin'),
                        );
                      });
                  otp.otpVerification(
                      order_id, token, pin.toString(), _uid, _id);
                }, // end onSubmit
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "you can resend sms in $_counter sec",
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  //color: const Color(0xff2a9d8f),
                  //0xFF0d1b2a
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      otp.resendOTP(token);
                    },
                    child: const Text("Resend"),
                  )),
            )
          ])),
        ));
  }
}
