import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../styles/button.dart';

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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var userEmail = TextEditingController();
  bool isRequesting = false;

  Future<void> passwordReset(BuildContext context) async {
    try {
      if (userEmail.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "please_fill_in_all_fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Color(0xFFFF5757),
          fontSize: 16.0,
        );
        return;
      }
      setState(() {
        isRequesting = true;
      });

      var url = Uri.parse('http://localhost:5000/send_password_reset');
      var response = await http.post(url, body: {'email': userEmail.text});

      setState(() {
        isRequesting = false;
      });

      // Handle the response here
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var response_data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (response_data['status'] == "success") {
          Fluttertoast.showToast(
            msg: "Password reset link sent! Check your email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Color(0xFFFF5757),
            fontSize: 16.0,
          );
        } else if (response_data['status'] == "error") {
          Fluttertoast.showToast(
            msg: "Password reset link could not be sent.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Color(0xFFFF5757),
            fontSize: 16.0,
          );
        } else if (response_data['status'] == "invalid") {
          Fluttertoast.showToast(
            msg: "No user registered with this email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Color(0xFFFF5757),
            fontSize: 16.0,
          );
        }
      }
    } catch (error) {
      // Handle other errors
      setState(() {
        isRequesting = false;
      });
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFFFF5757), size: 25), // Set back arrow color to white
      ),
      body: SingleChildScrollView(
        child: Container(
          transform: Matrix4.translationValues(0.0, -40.0, 0.0),
          color: Colors.white,
          child: Column(
            children: [
              ClipPath(
                clipper: TopCurveClipper(),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF5757),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        SizedBox(height: 120,),
                        Container(
                          height: 60,
                          child: Image.asset('assets/logo.png',
                            fit: BoxFit.cover,),
                        ),
                        SizedBox(height: 30,),
                        Text(
                          "Enter your Email and we will send you a password reset link",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20,),
                        TextField(
                          style: TextStyle(color: Colors.white, fontFamily: 'Poppins', height: 1.5),
                          keyboardType: TextInputType.emailAddress,
                          controller: userEmail,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: "Enter Your Email",
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
                        SizedBox(height: 20,),
                        Center(
                          child: Container(
                            child: Column(
                              children: [
                                Center(
                                  child: ElevatedButton(
                                    style: buttonPrimary,
                                    onPressed: isRequesting ? null : () async {
                                      passwordReset(context);
                                    },
                                    child: isRequesting
                                        ? LinearPercentIndicator(
                                      animation: true,
                                      animationDuration: 5000,
                                      percent: 1,
                                      progressColor: Color(0xFFFF5757),
                                      backgroundColor: Colors.white,
                                    )
                                        : Text(
                                      "Reset Password",
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
