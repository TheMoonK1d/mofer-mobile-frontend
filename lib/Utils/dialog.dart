import 'package:flutter/material.dart';
import 'package:mofer/Views/main_page.dart';

Future loadingDialog(context) {
  Color navColor = ElevationOverlay.applySurfaceTint(
      Theme.of(context).colorScheme.surface,
      Theme.of(context).colorScheme.surfaceTint,
      0);
  return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: navColor.withOpacity(0.8),
      builder: (context) => const Center(
            child: CircularProgressIndicator(strokeWidth: 6),
          ));
}

Future otpDialog(context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        "All Done",
        style: TextStyle(fontWeight: FontWeight.w900),
      ),
      content: const Text(
        "Thank you, You will now be redirected to your home page ",
        style:
        TextStyle(fontWeight: FontWeight.w700),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const MainPage()));
          },
          child: const Text(
            "Okay",
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        ),

      ],
    ),
  );
}