import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_app/AuthenticationScreen/LoginScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name;
  String? useremail;
  String? profile_picture;
  final picker = ImagePicker();
  File? _image;

  Future<Map<String, String?>> checkLoggedIn() async {
    SharedPreferences user_info = await SharedPreferences.getInstance();
    String? Name = user_info.getString('name');
    String? userEmail = user_info.getString('useremail');
    String? profilePicture = user_info.getString('profile_picture');
    return {'name': Name, 'useremail': userEmail, 'profile_picture': profilePicture};
  }

  @override
  void initState() {
    super.initState();
    checkLoggedIn().then((userData) {
      setState(() {
        useremail = userData['useremail'];
        name = userData['name'];
        profile_picture = userData['profile_picture'];
      });
    });
  }

  Future choiceImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      try {
        var request = http.MultipartRequest(
            'POST', Uri.parse('https://hotel-app-1-v54y.onrender.com/update_profilepic'));
        request.fields.addAll({
          "email": useremail ?? "",
        });

        var pic = await http.MultipartFile.fromPath("profile_picture", _image!.path);
        request.files.add(pic);

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        var response_data = json.decode(response.body);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data['status'] == "Success") {
            SharedPreferences user_info = await SharedPreferences.getInstance();
            user_info.setString('profile_picture', response_data['profile_picture'].toString());

            Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Color(0xFFFF5757),
              fontSize: 16.0,
            );

            setState(() {
              profile_picture = data['profile_picture'].toString();
              _image = null; // clear local image after upload
            });
          } else if (data['status'] == "Exist") {
            Fluttertoast.showToast(
              msg: "Listing Already Exists !!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Color(0xFFFF5757),
              fontSize: 16.0,
            );
          } else {
            Fluttertoast.showToast(
              msg: "Failed: ${data['message']}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Color(0xFFFF5757),
              fontSize: 16.0,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: "Failed to connect to the server",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Color(0xFFFF5757),
            fontSize: 16.0,
          );
        }
      } catch (error) {
        print("Error: $error");
        Fluttertoast.showToast(
          msg: "Error: $error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Color(0xFFFF5757),
          fontSize: 16.0,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 65),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.37,
                    color: Color(0xFFFF5757),
                  ),
                  Container(
                    color: Colors.white,
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 50),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Text('Profile', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            choiceImage();
                          },
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.black,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(90),
                                        child: Container(
                                          height: 90,
                                          width: 90,
                                          child: _image != null
                                              ? Image.file(
                                            _image!,
                                            fit: BoxFit.cover,
                                          )
                                              : Image.network(
                                            'https://hotel-app-1-v54y.onrender.com/uploads/${profile_picture ?? "default.jpg"}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 95,
                                alignment: Alignment.bottomRight,
                                child: Icon(
                                  Icons.add_circle_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name ?? '', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              Text(useremail ?? '', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text('Loyalty Check', style: TextStyle(fontSize: 16))),
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.center,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < 5; i++)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          color: i == 0 ? Color(0xFFFF5757) : Colors.white,
                                          child: Container(
                                            padding: EdgeInsets.all(2),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(90),
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                color: i == 0 ? Color(0xFFFF5757) : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    // You can update logic for loyalty levels here
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 10),
                          child: Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFF5757))),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 8, bottom: 5, left: 10, right: 10),
                          child: Row(
                            children: [
                              Text('Stay History'),
                              Spacer(),
                              Image.asset('assets/right_arrow.png',
                                fit: BoxFit.cover, height: 15,)
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 2, bottom: 2),
                          color: Colors.black,
                          height: 1,
                          width: double.infinity,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 8, bottom: 5, left: 10, right: 10),
                          child: Row(
                            children: [
                              Text('Personal information'),
                              Spacer(),
                              Image.asset('assets/right_arrow.png',
                                fit: BoxFit.cover, height: 15,)
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 2, bottom: 2),
                          color: Colors.black,
                          height: 1,
                          width: double.infinity,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 8, bottom: 5, left: 10, right: 10),
                          child: Row(
                            children: [
                              Text('Login & Security'),
                              Spacer(),
                              Image.asset('assets/right_arrow.png',
                                fit: BoxFit.cover, height: 15,)
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 2, bottom: 2),
                          color: Colors.black,
                          height: 1,
                          width: double.infinity,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 8, bottom: 5, left: 10, right: 10),
                          child: Row(
                            children: [
                              Text('Payments & Payouts'),
                              Spacer(),
                              Image.asset('assets/right_arrow.png',
                                fit: BoxFit.cover, height: 15,)
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 2, bottom: 2),
                          color: Colors.black,
                          height: 1,
                          width: double.infinity,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 8, bottom: 5, left: 10, right: 10),
                          child: Row(
                            children: [
                              Text('Notifications'),
                              Spacer(),
                              Image.asset('assets/right_arrow.png',
                                fit: BoxFit.cover, height: 15,)
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 2, bottom: 2),
                          color: Colors.black,
                          height: 1,
                          width: double.infinity,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 10),
                          child: Text('Support', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFF5757))),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 8, bottom: 5, left: 10, right: 10),
                          child: Row(
                            children: [
                              Text('Help Center'),
                              Spacer(),
                              Image.asset('assets/right_arrow.png',
                                fit: BoxFit.cover, height: 15,)
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 2, bottom: 2),
                          color: Colors.black,
                          height: 1,
                          width: double.infinity,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 8, bottom: 5, left: 10, right: 10),
                          child: Row(
                            children: [
                              Text('Feedback to helpinn'),
                              Spacer(),
                              Image.asset('assets/right_arrow.png',
                                fit: BoxFit.cover, height: 15,)
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 2, bottom: 2),
                          color: Colors.black,
                          height: 1,
                          width: double.infinity,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 10),
                          child: Text('Legal', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFF5757))),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 8, bottom: 5, left: 10, right: 10),
                          child: Row(
                            children: [
                              Text('Terms of Services'),
                              Spacer(),
                              Image.asset('assets/right_arrow.png',
                                fit: BoxFit.cover, height: 15,)
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 2, bottom: 2),
                          color: Colors.black,
                          height: 1,
                          width: double.infinity,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 8, bottom: 5, left: 10, right: 10),
                          child: Row(
                            children: [
                              Text('Privacy Policy'),
                              Spacer(),
                              Image.asset('assets/right_arrow.png',
                                fit: BoxFit.cover, height: 15,)
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 2, bottom: 2),
                          color: Colors.black,
                          height: 1,
                          width: double.infinity,
                        ),
                        GestureDetector(
                          onTap: () async {
                            SharedPreferences user_info = await SharedPreferences.getInstance();
                            user_info.setInt('isLoggedIn', 0);

                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => LoginScreen(),
                              ),
                                  (Route<dynamic> route) => false,
                            );

                            Fluttertoast.showToast(
                              msg: "Logged Out",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Color(0xFFFF5757),
                              fontSize: 16.0,
                            );
                          },
                          child: Container(
                              margin: EdgeInsets.only(top: 15, bottom: 10),
                              child: Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Icon(Icons.logout_rounded, color: Colors.red,)),
                                  Text('Logout', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFF5757))),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}