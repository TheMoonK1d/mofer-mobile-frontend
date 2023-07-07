import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slider_button/slider_button.dart';

import '../Utils/dialog.dart';
import '../models/bank_login.dart';

class PaymentLogin extends StatefulWidget {
  final String newAmount, uid;
  final int id;
  const PaymentLogin(
      {Key? key, required this.newAmount, required this.id, required this.uid})
      : super(key: key);

  @override
  State<PaymentLogin> createState() => _PaymentLoginState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController pinController = TextEditingController();

class _PaymentLoginState extends State<PaymentLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  textAlign: TextAlign.start,
                  "You will pay\n${widget.newAmount} ETB",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),

          //Phone
          //change to username
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.name,
                controller: usernameController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                  hintText: "Username",
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                controller: pinController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                  hintText: "Password",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              )),

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: Center(
              child: SliderButton(
                width: 300,
                height: 60,
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                action: () {
                  debugPrint(
                      "Username: ${usernameController.text} Password ${pinController.text}");
                  loadingDialog(context);
                  Bank bank = Bank(
                      context, usernameController.text, pinController.text);
                  //debugPrint("$new_amount, $id, $uid");
                  bank.bankLoginDataSender(
                    widget.newAmount,
                    widget.id,
                    widget.uid,
                  );
                },
                label: Text(
                  'Slide to ➡ to pay 💰',
                  style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                icon: const Icon(Icons.payment_rounded),
                radius: 12,
                buttonColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              textAlign: TextAlign.start,
              "Once logged in your session will last for 15 ⌚ min only",
              style: GoogleFonts.montserrat(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
