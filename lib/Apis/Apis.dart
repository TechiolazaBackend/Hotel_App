import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Adapters/HotelsAdapter.dart';
import '../Adapters/InboxListAdapter.dart';
import '../Adapters/ReservationsAdapter.dart';
import '../Adapters/UsersListAdapter.dart';
import '../Adapters/WishlistAdapter.dart';

// Base URL for your deployed backend
const String baseUrl = 'https://hotel-app-1-v54y.onrender.com';

Future<List<Hotel>> fetchHotels() async {
  String url = '$baseUrl/get_hotels_list'; // Adjust endpoint as per your Node.js backend
  final response = await http.get(Uri.parse(url));
  return hotelFromJson(response.body);
}

Future<List<Reservation>> fetchReservations() async {
  String url = '$baseUrl/get_reservations'; // Adjust endpoint as per your Node.js backend
  final response = await http.get(Uri.parse(url));
  return reservationFromJson(response.body);
}

Future<List<Wishlist>> fetchWishlist() async {
  SharedPreferences user_info = await SharedPreferences.getInstance();
  String? userEmail = user_info.getString('useremail');

  String url = '$baseUrl/get_wishlist?email=$userEmail'; // Adjust endpoint as per your Node.js backend
  final response = await http.get(Uri.parse(url));
  return wishlistFromJson(response.body);
}

Future<List<UsersList>> fetchUsersLists() async {
  SharedPreferences user_info = await SharedPreferences.getInstance();
  String? email = user_info.getString('useremail');

  String url = '$baseUrl/get_users?email=$email'; // Adjust endpoint as per your Node.js backend
  final response = await http.get(Uri.parse(url));

  print('Response body: ${response.body}'); // For debugging

  return userslistFromJson(response.body);
}

Future<List<InboxList>> fetchInboxList() async {
  SharedPreferences user_info = await SharedPreferences.getInstance();
  String? email = user_info.getString('useremail');

  String url = '$baseUrl/get_users?email=$email'; // Adjust endpoint as per your Node.js backend
  final response = await http.get(Uri.parse(url));

  print('Response body: ${response.body}'); // For debugging

  return inboxlistFromJson(response.body);
}