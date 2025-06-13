import 'package:flutter/material.dart';
import 'WishlistScreen/WishlistScreen.dart';
import 'HomeScreen/HomeScreen.dart';
import 'BookingsScreen/BookingsScreen.dart';
import 'ProfileScreen/ProfileScreen.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late int currentIndex;
  late PageController _pageController;
  late List<AnimationController> _animationControllers;

  final List<Widget> _pages = [
    HomeScreen(),
    WishlistScreen(),
    BookingsScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
    _animationControllers = List.generate(
      _pages.length,
          (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: _pages,
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
                color: const Color(0xFFFF5757),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                selectedFontSize: 12, // increased for accessibility
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
                      duration: const Duration(milliseconds: 300),
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