import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_app/HomeScreen/CustomizationsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_similarity/string_similarity.dart';
import '../Adapters/HotelsAdapter.dart';
import '../Apis/Apis.dart';
import 'HotelDetails.dart';
import 'package:http/http.dart' as http;

class HotelsList extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final String searchdestination;

  const HotelsList({super.key,
    required this.startDate,
    required this.endDate,
    required this.searchdestination});

  @override
  State<HotelsList> createState() => _HotelsListState();
}

class _HotelsListState extends State<HotelsList> {
  late String? useremail;
  late String? wishlist_listing_idString;
  late String wishlist_listing_id;
  late String image = 'assets/heart.png';

  @override
  void initState() {
    super.initState();
    checkLoggedIn().then((userData) {
      setState(() {
        useremail = userData['useremail'];
        wishlist_listing_idString = userData['wishlist_listing_id'];
      });
    });
  }

  Future<void> wishlistcheck(BuildContext context) async {

    var url = Uri.parse('https://hotel-app-1-v54y.onrender.com/wish_list_check');

    var response = await http.post(url, body: {
      "email": useremail!,
    });

    var response_data = json.decode(response.body);

    if (response_data.containsKey("wishlist_listing_id")) {
      String wishlist_listing_idString = response_data["wishlist_listing_id"];

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("wishlist_listing_id", wishlist_listing_idString);
        }
  }

  Future<Map<String, String?>> checkLoggedIn() async {
    SharedPreferences user_info = await SharedPreferences.getInstance();
    String? userEmail = user_info.getString('useremail');
    String? wishlist_listing_id_String = user_info.getString('wishlist_listing_id');

    return {'useremail': userEmail, 'wishlist_listing_id': wishlist_listing_id_String};
  }

  Future<void> save(BuildContext context) async {
    try {
      var url = Uri.parse('https://hotel-app-1-v54y.onrender.com/addto_wishlist');

      var response = await http.post(url, body: {
        "email": useremail!,
        "wishlist_listing_id": wishlist_listing_id,
      });

      var response_data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (response_data['status'] == "Saved") {
          Fluttertoast.showToast(
            msg: "Saved to Wishlist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xFFFF5757),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Unexpected response: $response_data",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xFFFF5757),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Failed to connect to the server",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xFFFF5757),
          textColor: Colors.white,
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
        backgroundColor: Color(0xFFFF5757),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> remove(BuildContext context) async {
    try {
      var url = Uri.parse('https://hotel-app-1-v54y.onrender.com/removefrom_wishlist');

      var response = await http.post(url, body: {
        "email": useremail!,
        "wishlist_listing_id": wishlist_listing_id,
      });

      var response_data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (response_data['status'] == "Removed") {
          Fluttertoast.showToast(
            msg: "Removed from Wishlist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xFFFF5757),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Unexpected response: $response_data",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xFFFF5757),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Failed to connect to the server",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xFFFF5757),
          textColor: Colors.white,
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
        backgroundColor: Color(0xFFFF5757),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    wishlistcheck(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFFF5757),
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            color: Colors.transparent,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle card 1 click
                    },
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF5757),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xFFFFFFFF),
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text('Map', style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      // Handle card 1 click
                    },
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF5757),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xFFFFFFFF),
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sort,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text('Sort', style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => CustomizationsScreen(

                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF5757),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xFFFFFFFF),
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/filter.png',
                            width: 18,
                            height: 18,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 5),
                          Text('Customizations', style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: fetchHotels(),
                builder: (context, AsyncSnapshot<List<Hotel>> snapshot) {
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
                    // Filter hotels based on location
                    List<Hotel> filteredHotels = snapshot.data!
                        .where((hotel) => StringSimilarity.compareTwoStrings(hotel.hotelLocation.toLowerCase(), widget.searchdestination.toLowerCase()) > 0.1)
                        .toList();


                    if (filteredHotels.isEmpty) {
                      return Center(
                        child: Text('No hotels found at this location'),
                      );
                    }

                    return ListView.builder(
                      itemCount: filteredHotels.length,
                      itemBuilder: (BuildContext context, int index) {
                        Hotel hotel = filteredHotels[index];
                        double hotelAvgrating = double.parse(hotel.avgRating);
                        String formattedRating = hotelAvgrating.toStringAsFixed(1);

                        if(wishlist_listing_idString!.contains(hotel.listing_id)){
                          image = 'assets/heart_filled.png';
                        }else{
                          image = 'assets/heart.png';
                        }

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
                                  try {
                                    double price = double.parse(hotel.price.trim()); // Parse the price string
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) => HotelDetails(
                                          hotelimage: '${hotel.roomPhoto}',
                                          hotelname: '${hotel.hotelName}',
                                          room_no: '${hotel.room_no}',
                                          hotellocation: '${hotel.hotelLocation}',
                                          hotelavgrating: '${hotel.avgRating}',
                                          hotelemail: '${hotel.hotelEmail}',
                                          hotelprice: price.toString(),
                                          startDate: widget.startDate,
                                          endDate: widget.endDate,
                                          description: '${hotel.description}',
                                          possible_no_of_guests: '${hotel.possible_no_of_guests}',
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    print("Error parsing hotel price: $e");
                                    // Handle the parsing error gracefully, such as showing a message to the user
                                  }
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
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child: Image.network(
                                                  'https://ditechiolaza.com/helpinn/uploads/${hotel.roomPhoto.replaceAll(RegExp(r'\[|\]|"'), '')}',
                                                  width: double.infinity,
                                                  height: 250.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                  height: 30,
                                                  margin: EdgeInsets.all(15),
                                                  alignment: Alignment.centerRight,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (wishlist_listing_idString!
                                                          .contains(hotel.listing_id)) {
                                                        wishlist_listing_id = '${hotel.listing_id}';
                                                        remove(context);
                                                        image = 'assets/heart.png';
                                                      } else {
                                                        wishlist_listing_id = '${hotel.listing_id}';
                                                        save(context);
                                                        image = 'assets/heart_filled.png';
                                                      }
                                                    },
                                                    child: Image.asset(image),
                                                  ),
                                              ),
                                            ],
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
                                                          '${hotel.hotelName}',
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
                                                            '${hotel.hotelLocation}',
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
                                                            '\$${hotel.price}',
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
