import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_similarity/string_similarity.dart';
import '../Adapters/ReservationsAdapter.dart';
import '../Apis/Apis.dart';
import 'BookingDetailsScreen.dart';

class BookingsScreen extends StatefulWidget {

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  late String? useremail;

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
    String? userPassword = user_info.getString('password');

    return {'useremail': userEmail, 'password': userPassword};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFFF5757),
        title: Container(
          child: Row(
            children: [
              Text('Trips', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
              Spacer(),
              Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Icon(Icons.question_mark_rounded, color: Colors.white,)),
              Icon(Icons.add, color: Colors.white,),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 65),
              child: FutureBuilder(
                future: fetchReservations(),
                builder: (context, AsyncSnapshot<List<Reservation>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF5757),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    List<Reservation> reservations = snapshot.data!
                        .where((reservation) => StringSimilarity.compareTwoStrings(reservation.customerEmail.toLowerCase(), useremail) == 1)
                        .toList();

                    if (reservations.isEmpty) {
                      return Container(
                        child: Stack(
                          children: [
                            Container(
                              color: Colors.white,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(20),
                                      margin: EdgeInsets.all(20),
                                      child: Image.asset(
                                        'assets/globe.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      child: Text(
                                        'Where to next?',
                                        style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        "You haven't starter any trips yet. Once you make a booking, it'll appear here.",
                                        style: TextStyle(color: Colors.black, fontSize: 16),
                                        textAlign: TextAlign.center, // Align text center
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: reservations.length,
                      itemBuilder: (BuildContext context, int index) {
                        Reservation reservation = reservations[index];
                        double hotelAvgrating = double.parse(reservation.avgRating);
                        String formattedRating = hotelAvgrating.toStringAsFixed(1);
                        return Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top:5 ,bottom: 5),
                          child: Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  print("$index""th Index Clicked");
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => BookingDetails(
                                        bookingId: '${reservation.booking_id}',
                                        hotelEmail: '${reservation.hotelEmail}',
                                        customerEmail: '${reservation.customerEmail}',
                                        hotelName: '${reservation.hotelName}',
                                        checkinDate: '${reservation.checkinDate}',
                                        checkoutDate: '${reservation.checkoutDate}',
                                        duration: '${reservation.duration}',
                                        adults: '${reservation.adults}',
                                        childrens: '${reservation.childrens}',
                                        rooms: '${reservation.rooms}',
                                        totalPrice: '${reservation.totalPrice}',
                                        paymentMode: '${reservation.paymentMode}',
                                        roomNo: '${reservation.roomNo}',
                                        description: '${reservation.description}',
                                        price: '${reservation.price}',
                                        bedrooms: '${reservation.bedrooms}',
                                        beds: '${reservation.beds}',
                                        bathrooms: '${reservation.bathrooms}',
                                        type: '${reservation.type}',
                                        amenities: '${reservation.amenities}',
                                        roomPhoto: '${reservation.roomPhoto}',
                                        hotelLocation: '${reservation.hotelLocation}',
                                        avgRating: '${reservation.avgRating}',
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        child: Container(
                                          width: double.infinity,
                                          height: 250.0,
                                          padding: EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Image.network(
                                              'https://ditechiolaza.com/helpinn/uploads/${reservation.roomPhoto.replaceAll(RegExp(r'\[|\]|"'), '')}',
                                              width: double.infinity,
                                              height: 250.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          '${reservation.hotelName}',
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        Container(
                                                          transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                                                          child: Text(
                                                            '${reservation.hotelLocation}',
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        ),
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(5),
                                                          child: Container(
                                                            color: Colors.green.withOpacity(0.3),
                                                            padding: EdgeInsets.all(5),
                                                            child: Text(
                                                              '\$ Pay at Hotel',
                                                              style: TextStyle(
                                                                color: Color(0xFF005E03),
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    RatingBarIndicator(
                                                      rating: hotelAvgrating,
                                                      itemBuilder: (context, index) => Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 20,
                                                      itemPadding: EdgeInsets.zero,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          transform: Matrix4.translationValues(0.0, -4.0, 0.0),
                                                          margin: EdgeInsets.only(right: 7),
                                                          child: Text(
                                                            '32 reviews',
                                                            style: TextStyle(fontSize: 12, color: Colors.black),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.all(3),
                                                          child: Text(
                                                            '${formattedRating}',
                                                            style: TextStyle(fontSize: 12, color: Colors.white),
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: Colors.green,
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 5),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Text('Price for 1 day', style: TextStyle(fontSize: 12),),
                                                          Text(
                                                            '\$${reservation.price}',
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFFFF5757), width: 2),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text('No data available'),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
