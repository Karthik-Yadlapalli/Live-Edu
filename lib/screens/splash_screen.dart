import 'package:flutter/material.dart'; 


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Image.asset("asstes/illustrations/splash.png"),
      )),
    );
  }
}