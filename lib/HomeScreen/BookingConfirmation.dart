import 'package:flutter/material.dart';

import '../styles/button.dart';

class BookingConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF5757),
        automaticallyImplyLeading: false, // hides the back button
      ),
      body: Container(
        color: Color(0xFFFF5757),
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your payment is confirmed!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Thanks for choosing Helpinn. We're excited to host you.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30, bottom: 20),
                      child: Center(
                        child: Text(
                          'Get Ready to Unpack the Fun!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: buttonPrimary,
                  onPressed: () {
                    Navigator.pushNamed(context, 'main');
                  },
                  child: Text(
                    'Explore more',
                    style: TextStyle(color: Color(0xFFFF5757), fontSize: 30),
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