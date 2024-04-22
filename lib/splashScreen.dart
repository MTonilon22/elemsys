import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:elemsys/homepage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset(
                "assets/animations/Animation - 1713758338206.json"),
          )
        ],
      ),
      nextScreen: const HomePage(),
      splashIconSize: 500,
      backgroundColor: Color(0XFF5a8ad0),
    );
  }
}
