import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../styles/button.dart';

class AddFeedbackScreen extends StatefulWidget {
  @override
  State<AddFeedbackScreen> createState() => _AddFeedbackScreenState();
}

class _AddFeedbackScreenState extends State<AddFeedbackScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF5757),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFFF5757),
        title: Text(
          'Add Feedback',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.centerLeft,
                child: Text('Rating', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              Container(
                alignment: Alignment.centerLeft,
                transform: Matrix4.translationValues(0, -10, 0),
                child: RatingBar.builder(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2),
                    itemBuilder: (context, _)=>Icon(Icons.star),
                    onRatingUpdate: (rating){
                      // mainRating = rating;
                      // addFeedback(context);
                    }),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: const Color(0xFFFFFFFF).withOpacity(0.30),
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.centerLeft,
                child: Text('Review', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: TextField(
                  style: TextStyle(color: Colors.white, fontFamily: 'Poppins', height: 1.5),
                  keyboardType: TextInputType.multiline,
                  // controller: description,
                  cursorColor: Colors.white,
                  maxLines: 3,
                  minLines: 1,
                  maxLength: 100,
                  decoration: InputDecoration(
                    hintText: 'Add Review',
                    hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xFFFFFFFF),
                        width: 4,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xFFFFFFFF),
                        width: 3,
                      ),
                    ),
                    prefixIcon: Icon(Icons.rate_review, color: Colors.white,),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20, top: 20),
                  child: Center(
                        child: ElevatedButton(
                            style: buttonPrimary,
                            onPressed: () {
                              // reserve(context);
                            },
                            child: Text('Submit', style: TextStyle(color: Color(0xFFFF5757), fontSize: 30),)),
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
