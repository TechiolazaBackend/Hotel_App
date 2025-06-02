import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotel_app/Adapters/WishlistAdapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Apis/Apis.dart';
import '../HomeScreen/HotelDetails.dart';

class WishlistScreen extends StatefulWidget {

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
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
              Text('Wishlist', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
              Spacer(),
              Icon(Icons.add, color: Colors.white,),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 65),
        child: FutureBuilder(
          future: fetchWishlist(),
          builder: (context, AsyncSnapshot<List<Wishlist>> snapshot) {
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
              List<Wishlist> wishlists = snapshot.data!
                  .toList();

              if (wishlists.isEmpty) {
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
                                margin: EdgeInsets.all(20),
                                child: Icon(
                                  Icons.dataset_linked,
                                  color: Color(0xFFFF5757),
                                  size: 300,
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                child: Text(
                                  'Save what you like for later',
                                  style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Create lists of your favourite properties to help you share, compare, and book.',
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                  textAlign: TextAlign.center, // Align text center
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              child: Text(
                                'Start your first list',
                                style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10, top: 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: double.infinity,
                                  height: 80,
                                  color: Color(0xFFFF5757),
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
                itemCount: wishlists.length,
                itemBuilder: (BuildContext context, int index) {
                  Wishlist wishlist = wishlists[index];
                  double hotelAvgrating = wishlist.avgRating.toDouble();
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
                                builder: (BuildContext context) => HotelDetails(
                                  hotelimage: '${wishlist.roomPhoto}',
                                  hotelname: '${wishlist.hotelName}',
                                  room_no: '${wishlist.room_no}',
                                  hotellocation: '${wishlist.hotelLocation}',
                                  hotelavgrating: '${wishlist.avgRating}',
                                  hotelemail: '${wishlist.email}',
                                  hotelprice: '${wishlist.price}',
                                  startDate: DateTime.now(),
                                  endDate: DateTime.now().add(Duration(days: 1)),
                                  description: '${wishlist.description}',
                                  possible_no_of_guests: '${wishlist.possible_no_of_guests}',
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
                                        'https://ditechiolaza.com/helpinn/uploads/${wishlist.roomPhoto.replaceAll(RegExp(r'\[|\]|"'), '')}',
                                        // 'assets/profilepic.png',
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
                                                    '${wishlist.hotelName}',
                                                    // 'XYZ',
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
                                                      '${wishlist.hotelLocation}',
                                                      // 'mumbai',
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
                                                // rating: 2,
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
                                                      // '3',
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
                                                      '\$${wishlist.price}',
                                                      // '65',
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
    );
  }
}
