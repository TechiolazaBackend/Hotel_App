import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Adapters/HotelsAdapter.dart';
import '../Adapters/InboxListAdapter.dart';
import '../Adapters/ReservationsAdapter.dart';
import '../Adapters/UsersListAdapter.dart';
import '../Adapters/WishlistAdapter.dart';

// Base URL for your deployed backend
const String baseUrl = 'https://hotel-app-1-v54y.onrender.com';

// Helper to check if the response is valid JSON and status code is OK
void _checkResponse(http.Response response, {String? endpoint}) {
  if (response.statusCode != 200 ||
      !(response.headers['content-type']?.contains('application/json') ?? false)) {
    throw Exception(
        'API error at ${endpoint ?? ""} - Status: ${response.statusCode}\nBody: ${response.body}');
  }
}

// Fetch hotels by location
Future<List<Hotel>> fetchHotels({required String location}) async {
  String url = '$baseUrl/get_hotels_list?location=$location';
  print("Requesting: $url");
  final response = await http.get(Uri.parse(url));
  print("Response: ${response.body}");
  _checkResponse(response, endpoint: url);
  return hotelFromJson(response.body);
}

// Fetch all reservations (bookings)
Future<List<Reservation>> fetchReservations() async {
  // Always get the user email from SharedPreferences!
  SharedPreferences user_info = await SharedPreferences.getInstance();
  String? userEmail = user_info.getString('useremail');
  if (userEmail == null || userEmail.isEmpty) return [];

  String url = '$baseUrl/get_reservations?customer_email=$userEmail';
  final response = await http.get(Uri.parse(url));
  _checkResponse(response, endpoint: url);
  return reservationFromJson(response.body);
}

// Wishlist
Future<List<Wishlist>> fetchWishlist() async {
  SharedPreferences user_info = await SharedPreferences.getInstance();
  String? userEmail = user_info.getString('useremail');
  if (userEmail == null) return [];
  String url = '$baseUrl/get_wishlist?email=$userEmail';
  final response = await http.get(Uri.parse(url));
  _checkResponse(response, endpoint: url);
  return wishlistFromJson(response.body);
}

// Users List
Future<List<UsersList>> fetchUsersLists() async {
  SharedPreferences user_info = await SharedPreferences.getInstance();
  String? email = user_info.getString('useremail');
  if (email == null) return [];
  String url = '$baseUrl/get_users?email=$email';
  final response = await http.get(Uri.parse(url));
  _checkResponse(response, endpoint: url);
  return userslistFromJson(response.body);
}

// Inbox List
Future<List<InboxList>> fetchInboxList() async {
  SharedPreferences user_info = await SharedPreferences.getInstance();
  String? email = user_info.getString('useremail');
  if (email == null) return [];
  String url = '$baseUrl/get_inboxlist?email=$email';
  final response = await http.get(Uri.parse(url));
  _checkResponse(response, endpoint: url);
  return inboxlistFromJson(response.body);
}