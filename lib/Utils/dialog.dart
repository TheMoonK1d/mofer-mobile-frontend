import 'package:flutter/material.dart';

Future loadingDialog(context){
  return showDialog(context: context,
      barrierDismissible: false,
      builder: (context)=> const Center(child: CircularProgressIndicator(strokeWidth: 6),));
}