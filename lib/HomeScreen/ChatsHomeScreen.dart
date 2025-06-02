import 'package:flutter/material.dart';
import 'package:hotel_app/Adapters/UsersListAdapter.dart';
import 'package:hotel_app/Adapters/InboxListAdapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/Apis.dart';
import 'ChatsScreen.dart';

class ChatsHomeScreen extends StatefulWidget {
  @override
  State<ChatsHomeScreen> createState() => _ChatsHomeScreenState();
}

class _ChatsHomeScreenState extends State<ChatsHomeScreen> {
  late String? useremail;
  late String? userid;
  final TextEditingController _searchController = TextEditingController();
  List<UsersList>? _allUsersLists;
  List<UsersList>? _filteredUsersLists;
  List<InboxList>? _inboxListItems;

  @override
  void initState() {
    super.initState();
    checkLoggedIn().then((userData) {
      setState(() {
        useremail = userData['useremail'];
        userid = userData['user_id'];
        _fetchAllUsers();
        _fetchInboxListItems();
      });
    });
  }

  Future<Map<String, String?>> checkLoggedIn() async {
    SharedPreferences user_info = await SharedPreferences.getInstance();
    String? userEmail = user_info.getString('useremail');
    String? userPassword = user_info.getString('password');
    String? userId = user_info.getString('user_id');

    return {'useremail': userEmail, 'password': userPassword, 'user_id': userId};
  }

  Future<void> _fetchAllUsers() async {
    List<UsersList> allUsersLists = await fetchUsersLists();
    setState(() {
      _allUsersLists = allUsersLists;
    });
  }

  Future<void> _fetchInboxListItems() async {
    List<InboxList> inboxListItems = await fetchInboxList();
    setState(() {
      _inboxListItems = inboxListItems;
    });
  }

  void _searchUsers() {
    String query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _filteredUsersLists = null;
      } else {
        _filteredUsersLists = _allUsersLists
            ?.where((userslist) => userslist.user_email.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFFF5757), // Theme color used here
        title: Text(
          'Inbox',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              controller: _searchController,
              onChanged: (value) {
                _searchUsers();
              },
              style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
              keyboardType: TextInputType.text,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                filled: true,
                fillColor: Colors.grey[200],
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            child: _filteredUsersLists != null
                ? _filteredUsersLists!.isEmpty
                ? Center(child: Text('No results found'))
                : ListView.builder(
              itemCount: _filteredUsersLists!.length,
              itemBuilder: (BuildContext context, int index) {
                UsersList userslist = _filteredUsersLists![index];
                return _buildUserListItem(userslist);
              },
            )
                : _inboxListItems == null
                ? Center(child: CircularProgressIndicator(color: Color(0xFFFF5757))) // Theme color used here
                : ListView.builder(
              itemCount: _inboxListItems!.length,
              itemBuilder: (BuildContext context, int index) {
                InboxList mainListItem = _inboxListItems![index];
                return _buildMainListItem(mainListItem);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserListItem(UsersList userslist) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => ChatsScreen(
              user_id: userslist.user_id,
              user_name: userslist.user_name,
              user_profile_pic: userslist.profile_picture,
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              final tween = Tween(begin: begin, end: end);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: curve,
              );

              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  height: 65,
                  width: 65,
                  color: Colors.black,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Container(
                        height: 60,
                        width: 60,
                        child: Image.network(
                          'https://ditechiolaza.com/helpinn/${userslist.profile_picture}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${userslist.user_name}', style: TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
                    Text(userslist.user_email, style: TextStyle(fontSize: 14, fontFamily: 'Poppins', color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainListItem(InboxList mainListItem) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: 65,
                width: 65,
                color: Colors.black,
                child: Container(
                  padding: EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: Container(
                      height: 60,
                      width: 60,
                      child: Image.network(
                        'https://ditechiolaza.com/helpinn/${mainListItem.profile_picture}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${mainListItem.user_name}', style: TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
                  Text("Recent message", style: TextStyle(fontSize: 14, fontFamily: 'Poppins', color: Colors.grey)),
                ],
              ),
            ),
          ),
          Text("11:22", style: TextStyle(fontSize: 12, fontFamily: 'Poppins', color: Colors.grey)),
        ],
      ),
    );
  }
}
