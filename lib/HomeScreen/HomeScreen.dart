import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_app/HomeScreen/ChatsHomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import '../styles/button.dart';
import 'HotelsList.dart';

import 'StoryMain.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchDestination = TextEditingController();
  late String cleanedString;
  late String? useremail;
  String selectedLanguage = "en";  // Initialize with default value

  DateTimeRange dateTimeRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(Duration(days: 1)),  // Adjusted end date
  );

  GoogleTranslator translator = GoogleTranslator();

  String find_a_place_to_stay = "Find a place to stay";
  String enter_you_Destination = "Enter you Destination";
  String please_enter_your_destination = "Please enter your destination";
  String room_adults_children = "1 room - 2 adults - 0 children";
  String search_text = "SEARCH";
  String discover_the_world_embrace_frugality = "Discover the World, Embrace Frugality";
  String loyalty_text = "Loyalty";
  String you_are_at_loyalty_level_in_our_loyalty_program = "You are at Loyalty Level 1 in our Loyalty Program";
  String discounts = "15% discounts";
  String enjoy_discounts_at_participating_properties_worldwide = "Enjoy Discounts at participating properties worldwide";
  String stories_by_travellers = "Stories By Travellers";
  String select_date_range = "Select Date Range";
  String save_text = "Save";

  Future<Map<String, String?>> checkLoggedIn() async {
    SharedPreferences user_info = await SharedPreferences.getInstance();
    String? language = user_info.getString('language');
    return {'language': language};
  }

  @override
  void initState() {
    super.initState();
    checkLoggedIn().then((userData) {
      setState(() {
        selectedLanguage = userData['language'] ?? "en";  // Use default language if null
      });
      translate();  // Call translate after setting the language
    });
  }

  Future<void> translate() async {
    SharedPreferences user_info = await SharedPreferences.getInstance();
    if (selectedLanguage == "es") {
      user_info.setString('language', selectedLanguage);

      try {
        var translations = await Future.wait([
          translator.translate(find_a_place_to_stay, to: "es"),
          translator.translate(enter_you_Destination, to: "es"),
          translator.translate(please_enter_your_destination, to: "es"),
          translator.translate(room_adults_children, to: "es"),
          translator.translate(search_text, to: "es"),
          translator.translate(discover_the_world_embrace_frugality, to: "es"),
          translator.translate(loyalty_text, to: "es"),
          translator.translate(you_are_at_loyalty_level_in_our_loyalty_program, to: "es"),
          translator.translate(discounts, to: "es"),
          translator.translate(enjoy_discounts_at_participating_properties_worldwide, to: "es"),
          translator.translate(stories_by_travellers, to: "es"),
          translator.translate(select_date_range, to: "es"),
          translator.translate(save_text, to: "es"),
        ]);

        setState(() {
          find_a_place_to_stay = translations[0].text;
          enter_you_Destination = translations[1].text;
          please_enter_your_destination = translations[2].text;
          room_adults_children = translations[3].text;
          search_text = translations[4].text;
          discover_the_world_embrace_frugality = translations[5].text;
          loyalty_text = translations[6].text;
          you_are_at_loyalty_level_in_our_loyalty_program = translations[7].text;
          discounts = translations[8].text;
          enjoy_discounts_at_participating_properties_worldwide = translations[9].text;
          stories_by_travellers = translations[10].text;
          select_date_range = translations[11].text;
          save_text = translations[12].text;

        });
      } catch (error) {
        print("Translation Error: $error");
        // Optionally handle the error, e.g., show a message to the user
      }
    } else {
      user_info.setString('language', "en");

      setState(() {
        find_a_place_to_stay = "Find a place to stay";
        enter_you_Destination = "Enter you Destination";
        please_enter_your_destination = "Please enter your destination";
        room_adults_children = "1 room - 2 adults - 0 children";
        search_text = "SEARCH";
        discover_the_world_embrace_frugality = "Discover the World, Embrace Frugality";
        loyalty_text = "Loyalty";
        you_are_at_loyalty_level_in_our_loyalty_program = "You are at Loyalty Level 1 in our Loyalty Program";
        discounts = "15% discounts";
        enjoy_discounts_at_participating_properties_worldwide = "Enjoy Discounts at participating properties worldwide";
        stories_by_travellers = "Stories By Travellers";
        select_date_range = "Select Date Range";
        save_text = "Save";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    final difference = dateTimeRange.duration;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF5757),
        title: Container(
          child: Row(
            children: [
              Container(
                height: 40,
                child: Image.asset('assets/logo.png',
                  fit: BoxFit.cover,),
              ),              Spacer(),
              Text(
                'Helpinn',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(Icons.notifications, color: Colors.white,),
              SizedBox(width: 15),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, _createRoute());
                  },
                  child: Container(
                    height: 25,
                    child: Image.asset('assets/chat_icon.png',
                      fit: BoxFit.cover,),
                  ), ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(bottom: 65),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFF5757),
                            Color(0xFFFF9292),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: List.generate(
                                  10,
                                      (index) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        // Navigate to StoryMain page
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => StoryMain(index: index),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white, // specify border color here
                                            width: 3, // specify border width here
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          radius: 35,
                                          backgroundImage: AssetImage('assets/loyaltybg.jpg'),
                                        ),
                                      ),
                                    ),
                                  ), 
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              find_a_place_to_stay,
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Material(
                                elevation: 15,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.black, fontFamily: 'Poppins',), // Set text color to white
                                          keyboardType: TextInputType.text,
                                          controller: searchDestination,
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            hintText: enter_you_Destination,
                                            hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),  // Set the hint text color
                                            contentPadding: EdgeInsets.symmetric(vertical: 15), // Set vertical padding
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 3,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 3
                                              ),
                                            ),
                                            prefixIcon: Icon(Icons.search, color: Colors.black,),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return please_enter_your_destination;
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 3),
                                          borderRadius: BorderRadius.circular(8),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Icon(Icons.calendar_month),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: GestureDetector(
                                                onTap: pickDateRange,
                                                child: Row(
                                                  children: [
                                                    Text('${start.day}/${start.month}/${start.year}', style: TextStyle(color: Colors.black,fontSize: 15),),
                                                    Text(' - ', style: TextStyle(color: Colors.black,fontSize: 15),),
                                                    Text('${end.day}/${end.month}/${end.year}', style: TextStyle(color: Colors.black, fontSize: 15),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context){
                                                return SizedBox(
                                                  height: 400,
                                                  child: Center(
                                                    child: ElevatedButton(
                                                      child: const Text('Close'),
                                                      onPressed: (){
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                          width: double.infinity,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 3),
                                            borderRadius: BorderRadius.circular(8),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left: 10),
                                                child: Icon(Icons.person),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(left: 10),
                                                child: Text(room_adults_children),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: ElevatedButton(
                                                  style: buttonSearch,
                                                  onPressed: () {
                                                    if (searchDestination.text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                        msg: please_enter_your_destination,
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: Colors.white,
                                                        textColor: Color(0xFFFF5757),
                                                        fontSize: 16.0,
                                                      );
                                                    } else {
                                                      String searchDestinationText = searchDestination.text.toString();
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (BuildContext context) => HotelsList(
                                                            startDate: start,
                                                            endDate: end,
                                                            searchdestination: searchDestinationText,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Text(search_text, style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 20),),
                                                ),
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.white.withOpacity(0.7),
                              //     spreadRadius: 3,
                              //     blurRadius: 7,
                              //     offset: Offset(0, 3),
                              //   ),
                              // ],
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 15),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        discover_the_world_embrace_frugality,
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: AssetImage("assets/loyaltybg.jpg"),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.darken,
                                  ),
                                ),
                              ),
                              height: 180,
                              width: 250,
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      loyalty_text,
                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      you_are_at_loyalty_level_in_our_loyalty_program,
                                      style: TextStyle(fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: AssetImage("assets/discountbg.jpg"),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.darken,
                                  ),
                                ),
                              ),
                              height: 180,
                              width: 250,
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      discounts,
                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      enjoy_discounts_at_participating_properties_worldwide,
                                      style: TextStyle(fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Color(0xFFFF5757), width: 2),
                                ),
                                height: 130,
                                width: 200,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(loyalty_text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(you_are_at_loyalty_level_in_our_loyalty_program, style: TextStyle(fontSize: 15),),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 15),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        stories_by_travellers,
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      height: 500,
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.7),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: AssetImage('assets/stories_by_travellers1.jpg'),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.2),
                                        BlendMode.darken,
                                      ),
                                    ),
                                  ),
                                  height: 230,
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                          child: Text(
                                            "Journey of a lifetime, experienced in Japan",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.7),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: AssetImage('assets/stories_by_travellers2.jpg'),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.2),
                                        BlendMode.darken,
                                      ),
                                    ),
                                  ),
                                  height: 230,
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                          child: Text(
                                            "Journey of a lifetime, experienced in Japan",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.7),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: AssetImage('assets/stories_by_travellers3.jpg'),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.2),
                                      BlendMode.darken,
                                    ),
                                  ),
                                ),
                                height: 230,
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                        child: Text(
                                          "Captivated by beauty, discovered in Bali.",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.7),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: AssetImage('assets/stories_by_travellers4.jpg'),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.2),
                                      BlendMode.darken,
                                    ),
                                  ),
                                ),
                                height: 230,
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                        child: Text(
                                          "Intricate tales, lost in the fabric of India.",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
    );
  }

  void pickDateRange() async {
    DateTime now = DateTime.now();

    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateTimeRange,
      firstDate: now,
      lastDate: DateTime(2030),
      helpText: select_date_range, // Customize the help text
      confirmText: 'Confirm', // Customize the confirm button text
      cancelText: 'Cancel', // Customize the cancel button text
      saveText: save_text,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          // Customize the colors and other theme elements
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: Color(0xFFFF5757), // Customize primary color
              onPrimary: Colors.white, // Customize text color on primary color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFFFF5757), // Customize text color of buttons
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (newDateRange == null) return;

    setState(() => dateTimeRange = newDateRange);
  }
}
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ChatsHomeScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
