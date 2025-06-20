import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import '../styles/button.dart';
import 'LoginScreen.dart';

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

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final signupName = TextEditingController();
  final signupEmail = TextEditingController();
  final signupPassword = TextEditingController();
  final signupconfirmPassword = TextEditingController();
  bool _obscureText = true;
  late String selectedLanguage = "en";

  GoogleTranslator translator = GoogleTranslator();

  String please_fill_in_all_fields = "Please fill in all fields";
  String password_doesnt_match = "Password doesn't match";
  String invalid_email = "Please enter a valid email";
  String password_too_short = "Password must be at least 6 characters";
  String name_too_short = "Name must be at least 2 characters";
  String success = "Success";
  String email_already_exists = "Email Already Exists !! Please Login";
  String failed_to_connect_to_the_server = "Failed to connect to the server";
  String sign_up = "SIGN UP";
  String full_name = "Full Name";
  String enter_your_name = "Enter your Name";
  String email_address = "Email Address";
  String enter_your_email = "Enter your Email";
  String password = "Password";
  String enter_your_password = "Enter your Password";
  String confirm_password = "Confirm Password";
  String enter_your_confirm_password = "Enter your Password";
  String already_have_an_account = "Already have an Account";
  String log_in = "LOGIN";

  Future<void> translate() async {
    if (selectedLanguage == "es") {
      SharedPreferences user_info = await SharedPreferences.getInstance();
      user_info.setString('language', selectedLanguage);

      Future.wait([
        translator.translate(please_fill_in_all_fields, to: "es"),
        translator.translate(password_doesnt_match, to: "es"),
        translator.translate(invalid_email, to: "es"),
        translator.translate(password_too_short, to: "es"),
        translator.translate(name_too_short, to: "es"),
        translator.translate(success, to: "es"),
        translator.translate(email_already_exists, to: "es"),
        translator.translate(failed_to_connect_to_the_server, to: "es"),
        translator.translate(sign_up, to: "es"),
        translator.translate(full_name, to: "es"),
        translator.translate(enter_your_name, to: "es"),
        translator.translate(email_address, to: "es"),
        translator.translate(enter_your_email, to: "es"),
        translator.translate(password, to: "es"),
        translator.translate(enter_your_password, to: "es"),
        translator.translate(confirm_password, to: "es"),
        translator.translate(enter_your_confirm_password, to: "es"),
        translator.translate(already_have_an_account, to: "es"),
        translator.translate(log_in, to: "es"),
      ]).then((translations) {
        setState(() {
          please_fill_in_all_fields = translations[0].toString();
          password_doesnt_match = translations[1].toString();
          invalid_email = translations[2].toString();
          password_too_short = translations[3].toString();
          name_too_short = translations[4].toString();
          success = translations[5].toString();
          email_already_exists = translations[6].toString();
          failed_to_connect_to_the_server = translations[7].toString();
          sign_up = translations[8].toString();
          full_name = translations[9].toString();
          enter_your_name = translations[10].toString();
          email_address = translations[11].toString();
          enter_your_email = translations[12].toString();
          password = translations[13].toString();
          enter_your_password = translations[14].toString();
          confirm_password = translations[15].toString();
          enter_your_confirm_password = translations[16].toString();
          already_have_an_account = translations[17].toString();
          log_in = translations[18].toString();
        });
      }).catchError((error) {
        print("Translation Error: $error");
      });
    } else {
      SharedPreferences user_info = await SharedPreferences.getInstance();
      user_info.setString('language', "en");
      setState(() {
        please_fill_in_all_fields = "Please fill in all fields";
        password_doesnt_match = "Password doesn't match";
        invalid_email = "Please enter a valid email";
        password_too_short = "Password must be at least 6 characters";
        name_too_short = "Name must be at least 2 characters";
        success = "Success";
        email_already_exists = "Email Already Exists !! Please Login";
        failed_to_connect_to_the_server = "Failed to connect to the server";
        sign_up = "SIGN UP";
        full_name = "Full Name";
        enter_your_name = "Enter your Name";
        email_address = "Email Address";
        enter_your_email = "Enter your Email";
        password = "Password";
        enter_your_password = "Enter your Password";
        confirm_password = "Confirm Password";
        enter_your_confirm_password = "Enter your Password";
        already_have_an_account = "Already have an Account";
        log_in = "LOGIN";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoggedIn().then((userData) {
      setState(() {
        selectedLanguage = userData['language'] ?? "en";
      });
    });
  }

  Future<Map<String, String?>> checkLoggedIn() async {
    SharedPreferences user_info = await SharedPreferences.getInstance();
    String? language = user_info.getString('language');
    return {'language': language};
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
        msg: please_fill_in_all_fields,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.red,
        fontSize: 16.0,
      );
      return;
    }
    if (signupPassword.text != signupconfirmPassword.text) {
      Fluttertoast.showToast(
        msg: password_doesnt_match,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.red,
        fontSize: 16.0,
      );
      return;
    }

    var url = Uri.parse('https://hotel-app-1-v54y.onrender.com/register');
    try {
      var response = await http.post(url, body: {
        "name": signupName.text.trim(),
        "email": signupEmail.text.trim(),
        "password": signupPassword.text,
      });

      if (response.statusCode == 200) {
        if (response.body == "Success") {
          Fluttertoast.showToast(
            msg: success,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
            textColor: Color(0xFFFF5757),
            fontSize: 16.0,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen(),
            ),
          );
        } else if (response.body == "Email") {
          Fluttertoast.showToast(
            msg: email_already_exists,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
            textColor: Color(0xFFFF5757),
            fontSize: 16.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: response.body,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
            textColor: Color(0xFFFF5757),
            fontSize: 16.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: failed_to_connect_to_the_server,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Color(0xFFFF5757),
          fontSize: 16.0,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: "$error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Color(0xFFFF5757),
        fontSize: 16.0,
      );
    }
  }

  Widget buildTextField(
      String hintText, TextEditingController controller, IconData icon,
      {bool isPassword = false, String? Function(String?)? validator}) {
    return TextFormField(
      style: TextStyle(color: Colors.white, fontFamily: 'Poppins', height: 1.5),
      keyboardType: isPassword ? TextInputType.visiblePassword : TextInputType.text,
      obscureText: isPassword ? _obscureText : false,
      obscuringCharacter: '*',
      controller: controller,
      validator: validator,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: hintText,
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
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.white,
          ),
          onPressed: _togglePasswordVisibility,
        )
            : null,
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    translate();
    return Scaffold(
      backgroundColor: Colors.black,
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
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                    ),
                    Container(
                      child: Text(
                        sign_up,
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
              Container(
                width: double.infinity,
                child: ClipPath(
                  clipper: TopCurveClipper(),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.90,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF5757),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 30, right: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 90),
                                Container(
                                  height: 60,
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/logo.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  '  $full_name',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                buildTextField(
                                  enter_your_name,
                                  signupName,
                                  Icons.person,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return please_fill_in_all_fields;
                                    }
                                    if (value.trim().length < 2) {
                                      return name_too_short;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '  $email_address',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                buildTextField(
                                  enter_your_email,
                                  signupEmail,
                                  Icons.email,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return please_fill_in_all_fields;
                                    }
                                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
                                      return invalid_email;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '  $password',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                buildTextField(
                                  enter_your_password,
                                  signupPassword,
                                  Icons.lock,
                                  isPassword: true,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return please_fill_in_all_fields;
                                    }
                                    if (value.length < 6) {
                                      return password_too_short;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '  $confirm_password',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                buildTextField(
                                  enter_your_confirm_password,
                                  signupconfirmPassword,
                                  Icons.lock,
                                  isPassword: true,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return please_fill_in_all_fields;
                                    }
                                    if (value.length < 6) {
                                      return password_too_short;
                                    }
                                    if (signupPassword.text != value) {
                                      return password_doesnt_match;
                                    }
                                    return null;
                                  },
                                ),
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: ElevatedButton(
                                            style: buttonPrimary,
                                            onPressed: () {
                                              register(context);
                                            },
                                            child: Text(
                                              sign_up,
                                              style: TextStyle(
                                                color: Color(0xFFFF5757),
                                                fontFamily: 'Poppins',
                                                fontSize: 30,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: double.infinity,
                                          child: Row(
                                            children: [
                                              Text(
                                                "$already_have_an_account?",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pushReplacementNamed(context, 'login');
                                                },
                                                child: Text(
                                                  log_in,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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