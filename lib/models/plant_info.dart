import 'package:flutter/material.dart';

class IBottomSheet extends StatelessWidget {
  const IBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          child: const Text('SHOW BOTTOM SHEET',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          onPressed: () {},
        ),
      ),
    );
  }
}
