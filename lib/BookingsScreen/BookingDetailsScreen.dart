import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'AddFeedbackScreen.dart';

class BookingDetails extends StatefulWidget {

  final String bookingId;
  final String hotelEmail;
  final String customerEmail;
  final String hotelName;
  final String checkinDate;
  final String checkoutDate;
  final String duration;
  final String adults;
  final String childrens;
  final String rooms;
  final String totalPrice;
  final String paymentMode;
  final String roomNo;
  final String description;
  final String price;
  final String bedrooms;
  final String beds;
  final String bathrooms;
  final String type;
  final String amenities;
  final String roomPhoto;
  final String hotelLocation;
  final String avgRating;



  const BookingDetails({
    Key? key,
    required this.bookingId,
    required this.hotelEmail,
    required this.customerEmail,
    required this.hotelName,
    required this.checkinDate,
    required this.checkoutDate,
    required this.duration,
    required this.adults,
    required this.childrens,
    required this.rooms,
    required this.totalPrice,
    required this.paymentMode,
    required this.roomNo,
    required this.description,
    required this.price,
    required this.bedrooms,
    required this.beds,
    required this.bathrooms,
    required this.type,
    required this.amenities,
    required this.roomPhoto,
    required this.hotelLocation,
    required this.avgRating,
  }) : super(key: key);

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  late double mainRating;


  Future<void> addFeedback(BuildContext context) async {
    try {
      var url = Uri.parse('https://ditechiolaza.com/helpinn/add_feedback.php');

      var response = await http.post(url, body: {
        "booking_id": widget.bookingId.toString(),
        "rating": mainRating.toString(),
      });

      if (response.statusCode == 200) {
        var responseBody = response.body;
        if (responseBody == "Success") {
          Fluttertoast.showToast(
            msg: 'Rating has been submitted',
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
              builder: (BuildContext context) => AddFeedbackScreen(),
            ),
          );
        } else if (responseBody == "Updated") {
          Fluttertoast.showToast(
            msg: 'Updated rating has been submitted',
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
              builder: (BuildContext context) => AddFeedbackScreen(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: 'Error: $responseBody',
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
          msg: 'Failed to connect to the server',
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
        msg: 'Error: $error',
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
    double avgRating = double.parse(widget.avgRating);

    DateTime checkinDateTime = DateTime.parse(widget.checkinDate);
    String formattedcheckinDateTime = DateFormat('dd-MM-yyyy').format(checkinDateTime);

    DateTime checkoutDateTime = DateTime.parse(widget.checkoutDate);
    String formattedcheckoutDateTime = DateFormat('dd-MM-yyyy').format(checkoutDateTime);

    return Scaffold(
      body: Container(
          color: const Color(0xFFFF5757),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 65),
                      color: const Color(0xFFFF5757),
                      child: Column(
                        children: [
                          Material(
                            elevation: 10,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                              child: Container(
                                height: 400,
                                width: double.infinity,
                                child: Image.network(
                                  'https://ditechiolaza.com/helpinn/uploads/${widget.roomPhoto.replaceAll(RegExp(r'\[|\]|"'), '')}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${widget.hotelName}',
                                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                                  child: Text('${widget.hotelLocation}', style: const TextStyle(fontSize: 15)),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: const Color(0xFFFFFFFF).withOpacity(0.30),
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: const Text('Entire home ', style: TextStyle(fontSize: 20)),
                                            ),
                                            Container(
                                              transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                                              child: const Text('Hosted by isabella ', style: TextStyle(fontSize: 15)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(90),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            child: const Image(
                                              image: AssetImage('assets/profilepic.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                  child: Text('How was the stay?', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
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
                                      mainRating = rating;
                                      addFeedback(context);
                                  }),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: const Color(0xFFFFFFFF).withOpacity(0.30),
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: Text('${widget.description}',style: TextStyle(fontSize: 14),),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: const Color(0xFFFFFFFF).withOpacity(0.30),
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text('What this place offers'),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    children: [
                                      Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                          child: Text(
                                            'Wi-fi',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                          child: Text(
                                            'Mountain view',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                          child: Text(
                                            'Valley view',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                          child: Text(
                                            'Dedicated workspace',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                          child: Text(
                                            'Free parking on premises',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: const Color(0xFFFFFFFF).withOpacity(0.30),
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_month_rounded, color: Colors.black,),
                                      Text('Check-in date    ', style: TextStyle(fontSize: 20),),
                                      Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                          child: Text(
                                            formattedcheckinDateTime,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_month_rounded, color: Colors.black,),
                                      Text('Check-out date  ', style: TextStyle(fontSize: 20),),
                                      Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                          child: Text(
                                            formattedcheckoutDateTime,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                  child: Text('Where you’ll be', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white70, // Background color
                                    border: Border.all(
                                      color: Color(0xFFFFFFFF), // Border color
                                      width: 1.0, // Border width
                                    ),
                                    borderRadius: BorderRadius.circular(8), // Border radius
                                  ),
                                  child: Center(
                                    child: Text(
                                      'MAP',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: const Color(0xFFFFFFFF).withOpacity(0.30),
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Cancellation policy', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      Text('This Reservation is non - refundable. Review the host’s full cancellation policy which applies even if you cancel for illness or disruptions caused by COVID - 19.', style: TextStyle(fontSize: 14),),
                                    ],
                                  ),
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('House rules', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      Text('Check-in after 12.00 PM Checkout before 10.00 AM 4guests maximum', style: TextStyle(fontSize: 14),),
                                    ],
                                  ),
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Safety & property', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      Text('No smoke alarm Carbon Monoxide alarm not reported', style: TextStyle(fontSize: 14),),
                                    ],
                                  ),
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
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(child: Icon(Icons.report, color: Colors.black, size: 18,)),
                                      SizedBox(width: 2,),
                                      Text('Report this listing', style: TextStyle(fontSize: 14, decoration: TextDecoration.underline),),
                                    ],
                                  ),
                                ),
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
        )
      ),
    );
  }
}
