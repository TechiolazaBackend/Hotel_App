import 'dart:convert';

List<Wishlist> wishlistFromJson(String str) =>
    List<Wishlist>.from(json.decode(str).map((x) => Wishlist.fromJson(x)));

String wishlistToJson(List<Wishlist> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Wishlist {
  int listing_id;
  String email;
  String hotelName;
  int room_no;
  double price;
  int bedrooms;
  int beds;
  int bathrooms;
  String type;
  String amenities;
  String hotelLocation;
  double avgRating;
  String description;
  int possible_no_of_guests;
  String roomPhoto;

  Wishlist({
    required this.listing_id,
    required this.email,
    required this.hotelName,
    required this.room_no,
    required this.price,
    required this.bedrooms,
    required this.beds,
    required this.bathrooms,
    required this.type,
    required this.amenities,
    required this.hotelLocation,
    required this.avgRating,
    required this.description,
    required this.possible_no_of_guests,
    required this.roomPhoto,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
    listing_id: json["listing_id"],
    email: json["email"],
    hotelName: json["name"],
    room_no: json["room_no"],
    price: (json["price"] as num).toDouble(), // Ensure price is double
    bedrooms: json["bedrooms"],
    beds: json["beds"],
    bathrooms: json["bathrooms"],
    type: json["type"],
    amenities: json["amenities"],
    hotelLocation: json["hotel_location"],
    avgRating: (json["avg_rating"] as num).toDouble(), // Ensure avgRating is double
    description: json["description"],
    possible_no_of_guests: json["possible_no_of_guests"],
    roomPhoto: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "listing_id": listing_id,
    "email": email,
    "name": hotelName,
    "room_no": room_no,
    "price": price,
    "bedrooms": bedrooms,
    "beds": beds,
    "bathrooms": bathrooms,
    "type": type,
    "amenities": amenities,
    "hotel_location": hotelLocation,
    "avg_rating": avgRating,
    "description": description,
    "possible_no_of_guests": possible_no_of_guests,
    "image": roomPhoto,
  };
}