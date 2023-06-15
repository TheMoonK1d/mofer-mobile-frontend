import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ReadDetail extends StatelessWidget {
  const ReadDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Container(
                height: 500,
                width: 400,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 30),
                          blurRadius: 30,
                          spreadRadius: 2)
                    ]),
                child: Lottie.asset('animations/sensor.json',
                    reverse: true, height: 200),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
