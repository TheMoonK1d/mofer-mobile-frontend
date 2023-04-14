import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AlertDialog errorDialog(context, error){
  return AlertDialog(
      title: Text(
        "✋🏾",
        style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.normal,
        ),
      ),
      content: Text(
        error,
        style: GoogleFonts.montserrat(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ],
  );
}