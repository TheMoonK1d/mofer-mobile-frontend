import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mofer/models/bank_login.dart';
import 'package:mofer/models/opt_model.dart';
import 'package:otp_text_field/otp_field.dart';

// Send token, amount, receiver account

//create an await function that will receive order id

//when received render otp page
class OTPPage extends StatefulWidget {
  final String phone, order_id, token, uid, id;
  const OTPPage(
      {super.key,
      required this.phone,
      required this.order_id,
      required this.token,
      required this.uid,
      required this.id});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  @override

  OtpFieldController otpController = OtpFieldController();



  @override
  Widget build(BuildContext context) {
    OTPModel otp = OTPModel(context);
    var _id = widget.id;
    var _uid = widget.uid;
    void printID() {
      debugPrint("Phone: $phone Order id: $order_id Token: $token UID: $_uid, ID: $_id");
    }
    printID();

    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
        padding: const EdgeInsets.all(50),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          ),
          child: OTPTextField(
              controller: otpController,
              length: 5,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceEvenly,
              fieldWidth: 40,
              style: const TextStyle(fontSize: 17),
              onChanged: (pin) {},
              onCompleted: (pin) {
                debugPrint("Verfy otp///////////////////////////////////////////////////////////////////////////////////////////////////");
                debugPrint("$order_id, $token, $pin.toString(), $_uid, $_id");
                otp.otpVerification(order_id, token, pin.toString(), _uid, _id);
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
        ),
      ),
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
      Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              otp.resendOTP(token);
            },
            child: const Text("Resend"),
          )),
    ]));
  }


}
