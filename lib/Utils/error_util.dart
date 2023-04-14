import 'package:flutter/material.dart';

class Utils{
  GlobalKey<ScaffoldMessengerState> messageKey = GlobalKey<ScaffoldMessengerState>();
  showSnackBar(String? text){
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text));
     messageKey.currentState!..removeCurrentSnackBar()..showSnackBar(snackBar);
  }
}