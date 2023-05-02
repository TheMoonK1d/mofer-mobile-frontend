import 'package:flutter/material.dart';

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
