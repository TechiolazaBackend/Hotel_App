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

Future<List<Hotel>> fetchHotels() async {
  String url = '$baseUrl/get_hotels_list';
  final response = await http.get(Uri.parse(url));
  _checkResponse(response, endpoint: url);
  return hotelFromJson(response.body);
}

Future<List<Reservation>> fetchReservations() async {
  String url = '$baseUrl/get_reservations';
  final response = await http.get(Uri.parse(url));
  _checkResponse(response, endpoint: url);
  return reservationFromJson(response.body);
}

Future<List<Wishlist>> fetchWishlist() async {
  SharedPreferences user_info = await SharedPreferences.getInstance();
  String? userEmail = user_info.getString('useremail');
  if (userEmail == null) return [];
  String url = '$baseUrl/get_wishlist?email=$userEmail';
  final response = await http.get(Uri.parse(url));
  _checkResponse(response, endpoint: url);
  return wishlistFromJson(response.body);
}
//sama
Future<List<UsersList>> fetchUsersLists() async {
  SharedPreferences user_info = await SharedPreferences.getInstance();
  String? email = user_info.getString('useremail');
  if (email == null) return [];
  String url = '$baseUrl/get_users?email=$email';
  final response = await http.get(Uri.parse(url));
  _checkResponse(response, endpoint: url);
  return userslistFromJson(response.body);
}

Future<List<InboxList>> fetchInboxList() async {
  SharedPreferences user_info = await SharedPreferences.getInstance();
  String? email = user_info.getString('useremail');
  if (email == null) return [];
  String url = '$baseUrl/get_inboxlist?email=$email';
  final response = await http.get(Uri.parse(url));
  _checkResponse(response, endpoint: url);
  return inboxlistFromJson(response.body);
}