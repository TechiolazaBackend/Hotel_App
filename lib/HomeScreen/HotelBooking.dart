import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_app/HomeScreen/BookingConfirmation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../styles/button.dart';

class HotelBooking extends StatefulWidget {
  final String hotelimage;
  final String hotelname;
  final String hotellocation;
  final String hotelavgrating;
  final String hotelemail;
  final String hotelprice;
  final int startDay;
  final int startMonth;
  final int startYear;
  final int endDay;
  final int endMonth;
  final int endYear;

  const HotelBooking({
    Key? key,
    required this.hotelimage,
    required this.hotelname,
    required this.hotellocation,
    required this.hotelavgrating,
    required this.hotelemail,
    required this.hotelprice,
    required this.startDay,
    required this.startMonth,
    required this.startYear,
    required this.endDay,
    required this.endMonth,
    required this.endYear,
  }) : super(key: key);

  @override
  _HotelBookingState createState() => _HotelBookingState();
}

class _HotelBookingState extends State<HotelBooking> {
  String? useremail;
  int? checkinDay;
  int? checkinMonth;
  int? checkinYear;

  int? checkoutDay;
  int? checkoutMonth;
  int? checkoutYear;

  late DateTime startDate;
  late DateTime endDate;
  late Duration difference;
  late int numberOfDays;
  int adults = 1;
  int non_adults = 1;
  int room = 1;
  late double totalprice;
  String selectedPaymentMode = 'Pay at Hotel';

  @override
  void initState() {
    super.initState();
    checkLoggedIn().then((userData) {
      setState(() {
        useremail = userData['useremail'];
      });
    });
  }

  Future<Map<String, String?>> checkLoggedIn() async {
    SharedPreferences user_info = await SharedPreferences.getInstance();
    String? userEmail = user_info.getString('useremail');
    return {'useremail': userEmail};
  }

  Future<void> reserve(BuildContext context) async {
    try {
      var url = Uri.parse('https://hotel-app-1-v54y.onrender.com/make_reservations');

      var response = await http.post(url, body: {
        "hotel_email": widget.hotelemail,
        "customer_email": useremail ?? "",
        "hotel_name": widget.hotelname,
        "check_in_date": startDate.toString(),
        "check_out_date": endDate.toString(),
        "duration": numberOfDays.toString(),
        "adults": adults.toString(),
        "childrens": non_adults.toString(),
        "rooms": room.toString(),
        "totalprice": totalprice.toString(),
        "paymentmode": selectedPaymentMode,
      });

      if (response.statusCode == 200) {
        var responseBody = response.body;
        if (responseBody == "Success") {
          Fluttertoast.showToast(
            msg: "Successfully Booked",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Color(0xFFFF5757),
            fontSize: 16.0,
          );
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => BookingConfirmation(),
            ),
          );
        } else if (responseBody == "Booked") {
          Fluttertoast.showToast(
            msg: "You have already Reserved the hotel",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Color(0xFFFF5757),
            fontSize: 16.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Unexpected response: $responseBody",
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

  @override
  Widget build(BuildContext context) {
    int start_day = checkinDay ?? widget.startDay;
    int start_month = checkinMonth ?? widget.startMonth;
    int start_year = checkinYear ?? widget.startYear;
    int end_day = checkoutDay ?? widget.endDay;
    int end_month = checkoutMonth ?? widget.endMonth;
    int end_year = checkoutYear ?? widget.endYear;
    startDate = DateTime(start_year, start_month, start_day);
    endDate = DateTime(end_year, end_month, end_day);
    difference = endDate.difference(startDate);
    numberOfDays = difference.inDays > 0 ? difference.inDays : 1;
    totalprice = double.parse(widget.hotelprice) * numberOfDays;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFFF5757),
      ),
      body: Container(
        height: double.infinity,
        color: Color(0xFFFF5757),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Container(
                  height: 150,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 180,
                          height: 150,
                          child: Image.network(
                            'https://ditechiolaza.com/helpinn/uploads/${widget.hotelimage.replaceAll(RegExp(r'\[|\]|"'), '')}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  widget.hotelname,
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  softWrap: true,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  widget.hotellocation,
                                  style: TextStyle(fontSize: 12),
                                  softWrap: true,
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
                  width: double.infinity,
                  height: 2,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 20),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Your trip', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Dates', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Check-in', style: TextStyle(fontSize: 20)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 70),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10,
                    color: const Color(0xFFFFFFFF),
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                width: 70,
                                height: 25,
                                color: Color(0xFFFF5757),
                                child: Center(
                                  child: DropdownButton<int>(
                                    hint: Text(
                                      '$start_day',
                                      style: TextStyle(color: Colors.white, fontSize: 14),
                                    ),
                                    iconEnabledColor: Colors.white,
                                    dropdownColor: Color(0xFFFF5757),
                                    onChanged: (value) {
                                      setState(() {
                                        checkinDay = value;
                                      });
                                    },
                                    items: List.generate(
                                      31,
                                          (index) => DropdownMenuItem(
                                        value: index + 1,
                                        child: Text('${index + 1}', style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                width: 70,
                                height: 25,
                                color: Color(0xFFFF5757),
                                child: Center(
                                  child: DropdownButton<int>(
                                    hint: Text(
                                      '$start_month',
                                      style: TextStyle(color: Colors.white, fontSize: 14),
                                    ),
                                    iconEnabledColor: Colors.white,
                                    dropdownColor: Color(0xFFFF5757),
                                    onChanged: (value) {
                                      setState(() {
                                        checkinMonth = value;
                                      });
                                    },
                                    items: List.generate(
                                      12,
                                          (index) => DropdownMenuItem(
                                        value: index + 1,
                                        child: Text('${index + 1}', style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                padding: EdgeInsets.only(left: 5),
                                width: 70,
                                height: 25,
                                color: Color(0xFFFF5757),
                                child: Center(
                                  child: DropdownButton<int>(
                                    hint: Text(
                                      '$start_year',
                                      style: TextStyle(color: Colors.white, fontSize: 14),
                                    ),
                                    iconEnabledColor: Colors.white,
                                    dropdownColor: Color(0xFFFF5757),
                                    onChanged: (value) {
                                      setState(() {
                                        checkinYear = value;
                                      });
                                    },
                                    items: List.generate(
                                      5,
                                          (index) => DropdownMenuItem(
                                        value: index + DateTime.now().year,
                                        child: Text('${index + DateTime.now().year}', style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Check-out', style: TextStyle(fontSize: 20)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 70),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10,
                    color: const Color(0xFFFFFFFF),
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                width: 70,
                                height: 25,
                                color: Color(0xFFFF5757),
                                child: Center(
                                  child: DropdownButton<int>(
                                    hint: Text(
                                      '$end_day',
                                      style: TextStyle(color: Colors.white, fontSize: 14),
                                    ),
                                    iconEnabledColor: Colors.white,
                                    dropdownColor: Color(0xFFFF5757),
                                    onChanged: (value) {
                                      setState(() {
                                        checkoutDay = value;
                                      });
                                    },
                                    items: List.generate(
                                      31,
                                          (index) => DropdownMenuItem(
                                        value: index + 1,
                                        child: Text('${index + 1}', style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                width: 70,
                                height: 25,
                                color: Color(0xFFFF5757),
                                child: Center(
                                  child: DropdownButton<int>(
                                    hint: Text(
                                      '$end_month',
                                      style: TextStyle(color: Colors.white, fontSize: 14),
                                    ),
                                    iconEnabledColor: Colors.white,
                                    dropdownColor: Color(0xFFFF5757),
                                    onChanged: (value) {
                                      setState(() {
                                        checkoutMonth = value;
                                      });
                                    },
                                    items: List.generate(
                                      12,
                                          (index) => DropdownMenuItem(
                                        value: index + 1,
                                        child: Text('${index + 1}', style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                padding: EdgeInsets.only(left: 5),
                                width: 70,
                                height: 25,
                                color: Color(0xFFFF5757),
                                child: Center(
                                  child: DropdownButton<int>(
                                    hint: Text(
                                      '$end_year',
                                      style: TextStyle(color: Colors.white, fontSize: 14),
                                    ),
                                    iconEnabledColor: Colors.white,
                                    dropdownColor: Color(0xFFFF5757),
                                    onChanged: (value) {
                                      setState(() {
                                        checkoutYear = value;
                                      });
                                    },
                                    items: List.generate(
                                      5,
                                          (index) => DropdownMenuItem(
                                        value: index + DateTime.now().year,
                                        child: Text('${index + DateTime.now().year}', style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Guests', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Adults', style: TextStyle(fontSize: 16)),
                            Container(
                              margin: EdgeInsets.only(right: 30),
                              child: Container(
                                height: 40,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (adults > 1) {
                                          setState(() {
                                            adults--;
                                          });
                                        }
                                      },
                                      child: Material(
                                        elevation: 2,
                                        borderRadius: BorderRadius.circular(3),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(3),
                                          child: Container(
                                            width: 30,
                                            height: 25,
                                            color: Colors.white,
                                            child: Center(child: Text('-', style: TextStyle(fontSize: 20))),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Material(
                                      elevation: 2,
                                      borderRadius: BorderRadius.circular(3),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: Container(
                                          width: 40,
                                          height: 25,
                                          color: Colors.white,
                                          child: Center(child: Text('$adults', style: TextStyle(fontSize: 20))),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          adults++;
                                        });
                                      },
                                      child: Material(
                                        elevation: 2,
                                        borderRadius: BorderRadius.circular(3),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(3),
                                          child: Container(
                                            width: 30,
                                            height: 25,
                                            color: Colors.white,
                                            child: Center(child: Text('+', style: TextStyle(fontSize: 20))),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Children', style: TextStyle(fontSize: 16)),
                            Container(
                              margin: EdgeInsets.only(right: 30),
                              child: Container(
                                height: 40,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (non_adults > 0) {
                                          setState(() {
                                            non_adults--;
                                          });
                                        }
                                      },
                                      child: Material(
                                        elevation: 2,
                                        borderRadius: BorderRadius.circular(3),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(3),
                                          child: Container(
                                            width: 30,
                                            height: 25,
                                            color: Colors.white,
                                            child: Center(child: Text('-', style: TextStyle(fontSize: 20))),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Material(
                                      elevation: 2,
                                      borderRadius: BorderRadius.circular(3),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: Container(
                                          width: 40,
                                          height: 25,
                                          color: Colors.white,
                                          child: Center(child: Text('$non_adults', style: TextStyle(fontSize: 20))),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          non_adults++;
                                        });
                                      },
                                      child: Material(
                                        elevation: 2,
                                        borderRadius: BorderRadius.circular(3),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(3),
                                          child: Container(
                                            width: 30,
                                            height: 25,
                                            color: Colors.white,
                                            child: Center(child: Text('+', style: TextStyle(fontSize: 20))),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Your Needs', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Room ', style: TextStyle(fontSize: 16)),
                            Container(
                              margin: EdgeInsets.only(right: 30),
                              child: Container(
                                height: 40,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (room > 1) {
                                          setState(() {
                                            room--;
                                          });
                                        }
                                      },
                                      child: Material(
                                        elevation: 2,
                                        borderRadius: BorderRadius.circular(3),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(3),
                                          child: Container(
                                            width: 30,
                                            height: 25,
                                            color: Colors.white,
                                            child: Center(child: Text('-', style: TextStyle(fontSize: 20))),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Material(
                                      elevation: 2,
                                      borderRadius: BorderRadius.circular(3),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: Container(
                                          width: 40,
                                          height: 25,
                                          color: Colors.white,
                                          child: Center(child: Text('$room', style: TextStyle(fontSize: 20))),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          room++;
                                        });
                                      },
                                      child: Material(
                                        elevation: 2,
                                        borderRadius: BorderRadius.circular(3),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(3),
                                          child: Container(
                                            width: 30,
                                            height: 25,
                                            color: Colors.white,
                                            child: Center(child: Text('+', style: TextStyle(fontSize: 20))),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 20),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Price details', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('\$${widget.hotelprice} * ${numberOfDays} days', style: TextStyle(fontSize: 16))),
                    Spacer(),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('\$${totalprice}', style: TextStyle(fontSize: 16))),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Taxes', style: TextStyle(fontSize: 16))),
                    Spacer(),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('\$5', style: TextStyle(fontSize: 16))),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 20),
                ),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Total(USD)', style: TextStyle(fontSize: 16))),
                    Spacer(),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('\$${(totalprice + 5).toStringAsFixed(2)}', style: TextStyle(fontSize: 16))),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 20),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Your Details', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Mobile no', style: TextStyle(fontSize: 16))),
                TextField(
                  style: TextStyle(color: Colors.white, fontFamily: 'Poppins', height: 1.5),
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      hintText: 'Enter your Mobile no',
                      hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      filled: true,
                      fillColor: Color(0xFFF89B9B),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 3
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 3
                          )
                      ),
                      prefixIcon: Icon(Icons.phone_android, color: Colors.white,)
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 10),
                    child: Text('Email ID', style: TextStyle(fontSize: 16))),
                TextField(
                  style: TextStyle(color: Colors.white, fontFamily: 'Poppins', height: 1.5),
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      hintText: 'Enter your Email ID',
                      hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      filled: true,
                      fillColor: Color(0xFFF89B9B),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 3
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 3
                          )
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.white,)
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 20),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Payment Mode', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 250,
                        height: 30,
                        color: Colors.white,
                        child: Center(
                          child: DropdownButton<String>(
                            value: selectedPaymentMode,
                            onChanged: (value) {
                              setState(() {
                                selectedPaymentMode = value!;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                value: 'Online',
                                child: Container(
                                  width: 170,
                                  child: Text('Online'),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'Pay at Hotel',
                                child: Container(
                                  width: 170,
                                  child: Text('Pay at Hotel'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 20),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Cancellation policy', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('This reservation is non - refundable', style: TextStyle(fontSize: 16))),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20, top: 20),
                    child: Column(
                      children: [
                        Center(
                          child: ElevatedButton(
                              style: buttonPrimary,
                              onPressed: () {
                                reserve(context);
                              },
                              child: Text('Confirm', style: TextStyle(color: Color(0xFFFF5757), fontSize: 30))),
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
    );
  }
}