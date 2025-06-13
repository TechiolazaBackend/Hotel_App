import 'dart:convert';

List<Hotel> hotelFromJson(String str) =>
    List<Hotel>.from(json.decode(str).map((x) => Hotel.fromJson(x)));

String hotelToJson(List<Hotel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hotel {
  String listing_id;
  String hotelEmail;
  String hotelName;
  String room_no;
  String price;
  String bedrooms;
  String beds;
  String bathrooms;
  String type;
  String amenities;
  String roomPhoto;
  String hotelLocation;
  String avgRating;
  String description;
  String possible_no_of_guests;

  Hotel({
    required this.listing_id,
    required this.hotelEmail,
    required this.hotelName,
    required this.room_no,
    required this.price,
    required this.bedrooms,
    required this.beds,
    required this.bathrooms,
    required this.type,
    required this.amenities,
    required this.roomPhoto,
    required this.hotelLocation,
    required this.avgRating,
    required this.description,
    required this.possible_no_of_guests,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
    listing_id: json["listing_id"],
    hotelEmail: json["email"],
    hotelName: json["name"],
    room_no: json["room_no"],
    price: json["price"].toString(),
    bedrooms: json["bedrooms"],
    beds: json["beds"],
    bathrooms: json["bathrooms"],
    type: json["type"],
    amenities: json["amenities"],
    roomPhoto: json["image"],
    hotelLocation: json["hotel_location"],
    avgRating: json["avg_rating"],
    description: json["description"],
    possible_no_of_guests: json["possible_no_of_guests"],
  );

  Map<String, dynamic> toJson() => {
    "listing_id": listing_id,
    "email": hotelEmail,
    "name": hotelName,
    "room_no": room_no,
    "price": double.tryParse(price) ?? price,
    "bedrooms": bedrooms,
    "beds": beds,
    "bathrooms": bathrooms,
    "type": type,
    "amenities": amenities,
    "image": roomPhoto,
    "hotel_location": hotelLocation,
    "avg_rating": avgRating,
    "description": description,
    "possible_no_of_guests": possible_no_of_guests,
  };
}