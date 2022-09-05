import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Image.asset('assets/pokemon-logo.png'),
      ),
    );
  }
}
