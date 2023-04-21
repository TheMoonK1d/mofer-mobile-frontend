import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDisabledAccount extends StatelessWidget {
  const UserDisabledAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SafeArea(child: Container()),
              const Padding(
                padding: EdgeInsets.all(10),
                child:  Card(
                    elevation: 0,
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 80,
                        child: Center(
                          child: Text(
                            "Looks like you have disabled your account ⚠",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              fontFamily: "Montserrat",
                            ),
                          ),
                        ),),
                    )),
              ),
            ],
          )
      ),
    );
  }
}
