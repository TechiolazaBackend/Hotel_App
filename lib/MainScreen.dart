import 'package:flutter/material.dart';
import 'WishlistScreen/WishlistScreen.dart';
import 'HomeScreen/HomeScreen.dart';
import 'BookingsScreen/BookingsScreen.dart';
import 'ProfileScreen/ProfileScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int currentIndex = 0;

  PageController _pageController = PageController();
  late List<AnimationController> _animationControllers;

  @override
  void initState() {
    super.initState();
    _animationControllers = List.generate(
      4,
          (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              HomeScreen(),
              WishlistScreen(),
              BookingsScreen(),
              ProfileScreen(),
            ],
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: Color(0xFFFF5757),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                selectedFontSize: 10,
                unselectedFontSize: 10,
                iconSize: 30,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.white,
                elevation: 0,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                    _pageController.animateToPage(
                      index,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOutCirc,
                    );
                    _startZoomAnimation(index);
                  });
                },
                items: [
                  _buildBottomNavigationBarItem(Icons.search, "Search", 0),
                  _buildBottomNavigationBarItem(Icons.favorite, "Wishlist", 1),
                  _buildBottomNavigationBarItem(Icons.book_rounded, "Bookings", 2),
                  _buildBottomNavigationBarItem(Icons.person, "Profile", 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
          parent: _animationControllers[index],
          curve: Curves.easeInOut,
        )),
        child: Icon(icon),
      ),
      label: label,
    );
  }

  void _startZoomAnimation(int index) {
    _animationControllers[index].reset();
    _animationControllers[index].forward();

  }
}
