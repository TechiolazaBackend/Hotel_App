import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hotel_app/MainScreen.dart';
import 'package:hotel_app/styles/button.dart';
import 'package:translator/translator.dart';

import 'ForgotPasswordScreen.dart';

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.15);
    path.quadraticBezierTo(size.width / 2, size.height * 0.05, size.width, size.height * 0.15);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var loginEmail = TextEditingController();
  var loginPassword = TextEditingController();
  bool _obscureText = true; // Track whether password is obscured or not
  late String selectedLanguage = "en";

  GoogleTranslator translator = GoogleTranslator();

  String please_fill_in_all_fields = "Please fill in all fields";
  String password_doesnt_match = "Password doesn't match";
  String success = "Success";
  String invalid_credentials = "Invalid Credentials";
  String failed_to_connect_to_the_server = "Failed to connect to the server";
  String log_in = "LOGIN";
  String email_address = "Email Address";
  String enter_your_email = "Enter your Email";
  String password = "Password";
  String enter_your_password = "Enter your Password";
  String forgot_password = "Forgot Password?";
  String dont_have_an_account = "Don't have an Account";
  String sign_up = "SIGN UP";
  String or_text = "or";

  @override
  void initState() {
    super.initState();
    checkLoggedIn().then((userData) {
      setState(() {
        selectedLanguage = userData['language']!;
      });
    });
  }

  Future<Map<String, String?>> checkLoggedIn() async {
    SharedPreferences user_info = await SharedPreferences.getInstance();
    String? language = user_info.getString('language');

    return {'language': language};
  }

  Future<void> translate() async {
    if(selectedLanguage == "es"){
      SharedPreferences user_info = await SharedPreferences.getInstance();
      user_info.setString('language', selectedLanguage);

      Future.wait([
        translator.translate(please_fill_in_all_fields, to: "es"),
        translator.translate(password_doesnt_match, to: "es"),
        translator.translate(success, to: "es"),
        translator.translate(invalid_credentials, to: "es"),
        translator.translate(failed_to_connect_to_the_server, to: "es"),
        translator.translate(log_in, to: "es"),
        translator.translate(email_address, to: "es"),
        translator.translate(enter_your_email, to: "es"),
        translator.translate(password, to: "es"),
        translator.translate(enter_your_password, to: "es"),
        translator.translate(forgot_password, to: "es"),
        translator.translate(dont_have_an_account, to: "es"),
        translator.translate(sign_up, to: "es"),
        translator.translate(or_text, to: "es"),

      ]).then((translations) {
        setState(() {
          please_fill_in_all_fields = translations[0].toString();
          password_doesnt_match = translations[1].toString();
          success = translations[2].toString();
          invalid_credentials = translations[3].toString();
          failed_to_connect_to_the_server = translations[4].toString();
          log_in = translations[5].toString();
          email_address = translations[6].toString();
          enter_your_email = translations[7].toString();
          password = translations[8].toString();
          enter_your_password = translations[9].toString();
          forgot_password = translations[10].toString();
          dont_have_an_account = translations[11].toString();
          sign_up = translations[12].toString();
          or_text = translations[13].toString();
        });
      }).catchError((error) {
        print("Translation Error: $error");
      });
    }else{
      SharedPreferences user_info = await SharedPreferences.getInstance();
      user_info.setString('language', "en");

      setState(() {
        please_fill_in_all_fields = "Please fill in all fields";
        password_doesnt_match = "Password doesn't match";
        success = "Success";
        invalid_credentials = "Invalid Credentials";
        failed_to_connect_to_the_server = "Failed to connect to the server";
        log_in = "LOGIN";
        email_address = "Email Address";
        enter_your_email = "Enter your Email";
        password = "Password";
        enter_your_password = "Enter your Password";
        forgot_password = "Forgot Password?";
        dont_have_an_account = "Don't have an Account";
        sign_up = "SIGN UP";
        or_text = "or";
      });
    }
    }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> login(BuildContext context) async {
    try {
      if (loginEmail.text.isEmpty || loginPassword.text.isEmpty) {
        Fluttertoast.showToast(
          msg: please_fill_in_all_fields,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Color(0xFFFF5757),
          fontSize: 16.0,
        );
        return;
      }

      var url = Uri.parse('http://10.0.2.2:5000/login');

      var response = await http.post(url, body: {
        "email": loginEmail.text,
        "password": loginPassword.text,
      });

      var response_data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (response_data['status'] == "Success") {
          SharedPreferences user_info = await SharedPreferences.getInstance();
          user_info.setBool('isLoggedIn', true);
          user_info.setString('useremail', loginEmail.text.toString());
          user_info.setString('password', loginPassword.text.toString());
          user_info.setString('mainuser_id', response_data['id'].toString());
          user_info.setString('name', response_data['name'].toString());
          user_info.setString('profile_picture', response_data['profile_picture'].toString());

          Fluttertoast.showToast(
            msg: success,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Color(0xFFFF5757),
            fontSize: 16.0,
          );

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => MainScreen(),
            ),
                (Route<dynamic> route) => false,
          );
        }
        else if(response_data['status'] == "Invalid"){
          Fluttertoast.showToast(
            msg: invalid_credentials,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Color(0xFFFF5757),
            fontSize: 16.0,
          );
        }
      } else {
        // Handle other status codes (e.g., 404, 500)
        Fluttertoast.showToast(
          msg: failed_to_connect_to_the_server,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Color(0xFFFF5757),
          fontSize: 16.0,
        );
      }
    } catch (error) {
      // Handle other errors
      Fluttertoast.showToast(
        msg: "Error: $error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Color(0xFFFF5757),
        fontSize: 16.0,
      );
      print("$error");
    }
  }

  @override
  Widget build(BuildContext context) {
    translate();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                alignment: Alignment.bottomCenter,
                transform: Matrix4.translationValues(0.0, 40.0, 0.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 15),
                      height: 25,
                      child: Container(
                        width: 50,
                        child: Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: Color(0xFFFF5757),
                              style: TextStyle(color: Colors.white),
                              value: selectedLanguage,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedLanguage = newValue!;
                                  translate();
                                });
                              },
                              items: <String>['en', 'es']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: TextStyle(color: Colors.white)),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFFFF5757),
                            borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        log_in,
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ClipPath(
                clipper: TopCurveClipper(),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.90,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF5757),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 90,),
                      Container(
                        height: 60,
                        child: Image.asset('assets/logo.png',
                          fit: BoxFit.cover,),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '  ${email_address}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            TextField(
                              style: TextStyle(color: Colors.white, fontFamily: 'Poppins', height: 1.5),
                              keyboardType: TextInputType.emailAddress,
                              controller: loginEmail,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: enter_your_email,
                                hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                                contentPadding: EdgeInsets.symmetric(vertical: 15),
                                filled: true,
                                fillColor: Color(0xFFF89B9B),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.email, color: Colors.white,),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '  ${password}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            TextField(
                              style: TextStyle(color: Colors.white, fontFamily: 'Poppins', height: 1.5),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscureText,
                              obscuringCharacter: '*',
                              controller: loginPassword,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: enter_your_password,
                                hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                                contentPadding: EdgeInsets.symmetric(vertical: 15),
                                filled: true,
                                fillColor: Color(0xFFF89B9B),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.white,
                                  ),
                                  onPressed: _togglePasswordVisibility,
                                ),
                                prefixIcon: Icon(Icons.lock, color: Colors.white,),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return ForgotPasswordScreen();
                                  }));
                                },
                                child: Text(
                                  forgot_password,
                                  style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                child: Column(
                                  children: [
                                    Center(
                                      child: ElevatedButton(
                                        style: buttonPrimary,
                                        onPressed: () async {
                                          String login_email = loginEmail.text.toString();
                                          String login_password = loginPassword.text.toString();
                                          login(context);
                                        },
                                        child: Text(
                                          log_in,
                                          style: TextStyle(color: Color(0xFFFF5757), fontFamily: 'Poppins', fontSize: 30),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          children: [
                            Text(
                              "${dont_have_an_account}?",
                              style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, 'register');
                              },
                              child: Text(
                                sign_up,
                                style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 3.0,
                                color: Colors.white,
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                child: Text(
                                  or_text,
                                  style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 40, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 3.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Handle first image click
                                },
                                child: Image.asset(
                                  'assets/googleicon.png',
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              SizedBox(width: 15),
                              GestureDetector(
                                onTap: () {
                                  // Handle second image click
                                },
                                child: Image.asset(
                                  'assets/facebookicon.png',
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              SizedBox(width: 15),
                              GestureDetector(
                                onTap: () {
                                  // Handle third image click
                                },
                                child: Image.asset(
                                  'assets/twittericon.png',
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
