import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsScreen extends StatefulWidget {
  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF5757),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFFF5757),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Center( // Added Center widget here
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Centering the row horizontally
                    children: [
                      Image.asset(
                        'assets/guestfavourite.png',
                        width: 47,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 20,),
                      Column(
                        children: [
                          Text('4.5',
                              style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 48, fontWeight: FontWeight.bold)
                          ),
                          Container(transform: Matrix4.translationValues(0, -10, 0),
                            child: RatingBarIndicator(
                              rating: 4.5,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.black,
                              ),
                              itemCount: 5,
                              itemSize: 20,
                              itemPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Image.asset(
                        'assets/guestfavourite.png',
                        width: 47,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Text(
                    'One of the most loved homes on Helpinn based on rating ,reviews, and reliability',
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Poppins'), textAlign: TextAlign.center, ),
              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height: 1,
                color: const Color(0xFFFFFFFF).withOpacity(0.30),
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
