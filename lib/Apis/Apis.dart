import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Adapters/HotelsAdapter.dart';
import '../Adapters/InboxListAdapter.dart';
import '../Adapters/ReservationsAdapter.dart';
import '../Adapters/UsersListAdapter.dart';
import '../Adapters/WishlistAdapter.dart';

Future<List<Hotel>> fetchHotels() async {
  String url = 'https://ditechiolaza.com/helpinn/get_hotels_list.php';
  final response = await http.get(Uri.parse(url));
  return hotelFromJson(response.body);
}

Future<List<Reservation>> fetchReservations() async {
  String url = 'https://ditechiolaza.com/helpinn/get_reservations.php';
  final response = await http.get(Uri.parse(url));
  return reservationFromJson(response.body);
}

Future<List<Wishlist>> fetchWishlist() async {
    SharedPreferences user_info = await SharedPreferences.getInstance();
    String? userEmail = user_info.getString('useremail');

    String url = 'https://ditechiolaza.com/helpinn/get_wishlist.php?email=$userEmail';
    final response = await http.get(Uri.parse(url));
    return wishlistFromJson(response.body);
}

Future<List<UsersList>> fetchUsersLists() async {
  SharedPreferences user_info = await SharedPreferences.getInstance();
  String? email = user_info.getString('useremail');

  String url = 'https://ditechiolaza.com/helpinn/get_users.php?email=$email';
  final response = await http.get(Uri.parse(url));

  print('Response body: ${response.body}'); // Add this line for debugging

  return userslistFromJson(response.body);
}

Future<List<InboxList>> fetchInboxList() async {
  SharedPreferences user_info = await SharedPreferences.getInstance();
  String? email = user_info.getString('useremail');

  String url = 'https://ditechiolaza.com/helpinn/get_users.php?email=$email';
  final response = await http.get(Uri.parse(url));

  print('Response body: ${response.body}'); // Add this line for debugging

  return inboxlistFromJson(response.body);
}

