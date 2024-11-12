import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:tvmaze/presentation/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.black,
      splashIconSize: 100.h,
      splashTransition: SplashTransition.scaleTransition,
      animationDuration: const Duration(microseconds: 750000),
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50.w,
            decoration: BoxDecoration(),
            child: Image.asset(
              'lib/assets/logo.png',
              fit: BoxFit.contain,
            ),
          ),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 2),
            builder: (context, double value, child) {
              return SpinKitThreeBounce(
                color: Colors.lightBlue.shade400,
              );
            },
          )
        ],
      ),
      nextScreen: HomeScreen(),
      duration: 1500,
    );
  }
}
