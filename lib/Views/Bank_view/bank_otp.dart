import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';

// Send token, amount, receiver account

//create an await function that will receive order id

//when received render otp page
class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  OtpFieldController otpController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Enter the number we just sent you over SMS",
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                //color: const Color(0xff2a9d8f),
                //0xFF0d1b2a
              ),
            ),
          ),
          OTPTextField(
              controller: otpController,
              length: 5,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceEvenly,
              fieldWidth: 40,
              outlineBorderRadius: 20,
              style: const TextStyle(fontSize: 17),
              onChanged: (pin) {

              },
              onCompleted: (pin) {
                //send order id and opt value
                //wait for respose
                //if otp is incorrect show msg
                //else
                //get object

                /*
                  Extract object 
                  get time
                  get amount
                  get transaction id
                */
                //get firebase token
                //send firebase token, transaction id, pkg id, time
                //show dialog

                //return to ???????????????

              }),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "you can resend sms in 1 min",
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                //color: const Color(0xff2a9d8f),
                //0xFF0d1b2a
              ),
            ),
          ),
        ]));
  }
}
