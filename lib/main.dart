import 'package:flutter/material.dart';
import 'package:hotel_app/HomeScreen/BookingConfirmation.dart';
import 'package:hotel_app/AuthenticationScreen/LoginScreen.dart';
import 'package:hotel_app/AuthenticationScreen/RegisterScreen.dart';
import 'package:hotel_app/MainScreen.dart';
import 'package:flutter/services.dart';
import 'package:hotel_app/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.data == true) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: 'main',
              routes: {
                'login': (context) => LoginScreen(),
                'register': (context) => RegisterScreen(),
                'main': (context) => MainScreen(),
                'confirmation': (context) => BookingConfirmation(),
              },
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: 'splashscreen',
              routes: {
                'splashscreen': (context) => SplashScreen(),
                'login': (context) => LoginScreen(),
                'register': (context) => RegisterScreen(),
                'main': (context) => MainScreen(),
                'confirmation': (context) => BookingConfirmation(),
              },
            );
          }
        }
      },
    );
  }

  Future<bool> checkLoggedIn() async {
    SharedPreferences user_info = await SharedPreferences.getInstance();
    bool isLoggedIn = user_info.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }
}
