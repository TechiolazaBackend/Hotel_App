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
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/guestfavourite.png',
                        width: 47,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          Text(
                            '4.5',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            transform: Matrix4.translationValues(0, -10, 0),
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
                      SizedBox(width: 20),
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
                  'One of the most loved homes on Helpinn based on rating, reviews, and reliability',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 1,
                color: const Color(0xFFFFFFFF).withOpacity(0.30),
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              // Example Review Cards (add more as needed)
              ...List.generate(4, (index) => _buildReviewCard(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Color(0xFFFF5757), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile picture
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: 40,
              width: 40,
              color: Colors.black,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: Image.asset(
                    'assets/profilepic_bg.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          // Reviewer name, location, date, review text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Srija Patil',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFFFF5757)),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Maharashtra, India',
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                  ],
                ),
                Text(
                  '12 Apr 2025',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(height: 6),
                RatingBarIndicator(
                  rating: 4.5,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 18,
                  itemPadding: EdgeInsets.zero,
                ),
                SizedBox(height: 6),
                Text(
                  'A beautiful house with a lot of character and with a beautiful mountain view. The house was very clean and well organised.',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}