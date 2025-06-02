import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hotel_app/AuthenticationScreen/RegisterScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Delayed navigation to the next screen
    Future.delayed(Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => RegisterScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    });

    return Scaffold(
      body: Image.asset(
        "assets/helpinn_splashscreen.gif",
        fit: BoxFit.cover, // Use BoxFit.cover to fill the entire screen
        filterQuality: FilterQuality.high,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
