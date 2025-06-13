import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../styles/button.dart';
import 'HotelBooking.dart';
import 'ReviewsScreen.dart';

class HotelDetails extends StatefulWidget {
  final String hotelimage;
  final String hotelname;
  final String hotellocation;
  final String hotelavgrating;
  final String hotelemail;
  final String hotelprice;
  final String room_no;
  final String description;
  final String possible_no_of_guests;
  final DateTime startDate;
  final DateTime endDate;

  const HotelDetails({
    Key? key,
    required this.hotelimage,
    required this.hotelname,
    required this.hotellocation,
    required this.hotelavgrating,
    required this.hotelemail,
    required this.hotelprice,
    required this.room_no,
    required this.description,
    required this.possible_no_of_guests,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  int? checkinDay;
  int? checkinMonth;
  int? checkinYear;

  int? checkoutDay;
  int? checkoutMonth;
  int? checkoutYear;

  String loyalty_text = "Loyalty";
  String you_are_at_loyalty_level_in_our_loyalty_program = "You are at Loyalty Level 1 in our Loyalty Program";
  String discounts = "15% discounts";
  String enjoy_discounts_at_participating_properties_worldwide = "Enjoy Discounts at participating properties worldwide";

  @override
  Widget build(BuildContext context) {
    double avgRating = double.parse(widget.hotelavgrating);

    int start_day = checkinDay ?? widget.startDate.day;
    int start_month = checkinMonth ?? widget.startDate.month;
    int start_year = checkinYear ?? widget.startDate.year;
    int end_day = checkoutDay ?? widget.endDate.day;
    int end_month = checkoutMonth ?? widget.endDate.month;
    int end_year = checkoutYear ?? widget.endDate.year;

    DateTime startDate = DateTime(start_year, start_month, start_day);
    DateTime endDate = DateTime(end_year, end_month, end_day);

    Duration difference = endDate.difference(startDate);
    double totalPrice = double.parse(widget.hotelprice) * (difference.inDays > 0 ? difference.inDays : 1);

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
                                  'https://ditechiolaza.com/helpinn/uploads/${widget.hotelimage.replaceAll(RegExp(r'\[|\]|"'), '')}',
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
                                    widget.hotelname,
                                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                                  child: Text(widget.hotellocation, style: const TextStyle(fontSize: 15)),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 1.0),
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(widget.hotelavgrating,
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
                                          RatingBarIndicator(
                                            rating: avgRating,
                                            itemBuilder: (context, index) => const Icon(
                                              Icons.star,
                                              color: Colors.black,
                                            ),
                                            itemCount: 5,
                                            itemSize: 14,
                                            itemPadding: EdgeInsets.zero,
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 15,),
                                      Container(width: 1, height: 35, color: Colors.white),
                                      SizedBox(width: 15,),
                                      Image.asset(
                                        'assets/guestfavourite.png',
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 5,),
                                      Text('Guest\nfavourite',
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                                          textAlign: TextAlign.center),
                                      SizedBox(width: 5,),
                                      Image.asset(
                                        'assets/guestfavourite.png',
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 15,),
                                      Container(width: 1, height: 35, color: Colors.white),
                                      SizedBox(width: 15,),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) => ReviewsScreen(),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('18', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
                                            Text('Reviews', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Entire home ', style: TextStyle(fontSize: 20)),
                                        Container(
                                          transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                                          child: Text('Hosted by isabella ', style: TextStyle(fontSize: 15)),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    ClipRRect(
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
                                  ],
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
                                  child: Text(widget.description, style: TextStyle(fontSize: 14)),
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
                                          child: Text('Wi-fi', style: TextStyle(fontSize: 12)),
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
                                          child: Text('Mountain view', style: TextStyle(fontSize: 12)),
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
                                          child: Text('Valley view', style: TextStyle(fontSize: 12)),
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
                                          child: Text('Dedicated workspace', style: TextStyle(fontSize: 12)),
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
                                          child: Text('Free parking on premises', style: TextStyle(fontSize: 12)),
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
                                      Icon(Icons.calendar_month_rounded, color: Colors.black),
                                      Text('Select your check-in date', style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
                                                        child: Text(
                                                          '${index + DateTime.now().year}',
                                                          style: TextStyle(color: Colors.white),
                                                        ),
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
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_month_rounded, color: Colors.black),
                                      Text('Select your check-out date', style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
                                                color:  Color(0xFFFF5757),
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
                                                color:  Color(0xFFFF5757),
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
                                                        child: Text(
                                                          '${index + DateTime.now().year}',
                                                          style: TextStyle(color: Colors.white),
                                                        ),
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
                                  width: double.infinity,
                                  height: 1,
                                  color: const Color(0xFFFFFFFF).withOpacity(0.30),
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text('Where you’ll be', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    border: Border.all(
                                      color: Color(0xFFFFFFFF),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
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
                                  width: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Ratings & reviews',
                                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
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
                                            Text('4.5',
                                                style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 48, fontWeight: FontWeight.bold)),
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
                                    'One of the most loved homes on Helpinn based on rating ,reviews, and reliability',
                                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(3, (i) {
                                        return Container(
                                          margin: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(color: Color(0xFFFF5757), width: 2),
                                          ),
                                          height: 140,
                                          width: 200,
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(100),
                                                      child: Container(
                                                        height: 35,
                                                        width: 35,
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
                                                    SizedBox(width: 5),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('Srija Patil', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                                        Text('Maharashtra, India', style: TextStyle(fontSize: 10)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(left: 10, right: 10),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'A beautiful house with a lot of character and with a beautiful mountain view . The house was very clean and well organised.',
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10, right: 10),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: ElevatedButton(
                                            style: buttonPrimary,
                                            onPressed: () {},
                                            child: Text('View all 104 reviews', style: TextStyle(color: Color(0xFFFF5757), fontSize: 18)),
                                          ),
                                        ),
                                      ],
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
                                      Text('Cancellation policy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      Text(
                                        'This Reservation is non - refundable. Review the host’s full cancellation policy which applies even if you cancel for illness or disruptions caused by COVID - 19.',
                                        style: TextStyle(fontSize: 14),
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('House rules', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      Text('Check-in after 12.00 PM\nCheckout before 10.00 AM\n4guests maximum', style: TextStyle(fontSize: 14)),
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
                                      Text('Safety & property', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      Text('No smoke alarm\nCarbon Monoxide alarm not reported', style: TextStyle(fontSize: 14)),
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
                                      Center(child: Icon(Icons.report, color: Colors.black, size: 18)),
                                      SizedBox(width: 2),
                                      Text('Report this listing', style: TextStyle(fontSize: 14, decoration: TextDecoration.underline)),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: const Color(0xFFFFFFFF).withOpacity(0.30),
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(40),
                        elevation: 10,
                        color: const Color(0xFFFFFFFF),
                        child: Container(
                          height: 60,
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 15),
                                padding: const EdgeInsets.all(7),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('$start_day/$start_month - $end_day/$end_month', style: const TextStyle(fontSize: 14, color: Color(0xFFFF5757), fontWeight: FontWeight.bold)),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '\$${totalPrice.toStringAsFixed(2)}',
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
                                          ),
                                          TextSpan(
                                            text: ' for ${difference.inDays > 0 ? difference.inDays : 1} days',
                                            style: TextStyle(fontSize: 14, color: Color(0xFF000000)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                margin: const EdgeInsets.only(right: 15),
                                child: Material(
                                  borderRadius: BorderRadius.circular(40),
                                  elevation: 10,
                                  color: const Color(0xFFFF5757),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        try {
                                          double price = double.parse(widget.hotelprice.trim());
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) => HotelBooking(
                                                hotelimage: widget.hotelimage,
                                                hotelname: widget.hotelname,
                                                hotellocation: widget.hotellocation,
                                                hotelavgrating: widget.hotelavgrating,
                                                hotelemail: widget.hotelemail,
                                                hotelprice: price.toString(),
                                                startDay: start_day,
                                                startMonth: start_month,
                                                startYear: start_year,
                                                endDay: end_day,
                                                endMonth: end_month,
                                                endYear: end_year,
                                              ),
                                            ),
                                          );
                                        } catch (e) {
                                          print("Error parsing hotel price: $e");
                                          // Handle the parsing error gracefully
                                        }
                                      },
                                      child: const Text('Book Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}