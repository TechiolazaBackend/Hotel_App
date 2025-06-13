import 'dart:convert';

List<Reservation> reservationFromJson(String str) =>
    List<Reservation>.from(json.decode(str).map((x) => Reservation.fromJson(x)));

String reservationToJson(List<Reservation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reservation {
  String booking_id;
  String hotelEmail;
  String customerEmail;
  String hotelName;
  String checkinDate;
  String checkoutDate;
  String duration;
  String adults;
  String childrens;
  String rooms;
  String totalPrice;
  String paymentMode;
  String roomNo;
  String description;
  String price;
  String bedrooms;
  String beds;
  String bathrooms;
  String type;
  String amenities;
  String roomPhoto;
  String hotelLocation;
  String avgRating;

  Reservation({
    required this.booking_id,
    required this.hotelEmail,
    required this.customerEmail,
    required this.hotelName,
    required this.checkinDate,
    required this.checkoutDate,
    required this.duration,
    required this.adults,
    required this.childrens,
    required this.rooms,
    required this.totalPrice,
    required this.paymentMode,
    required this.roomNo,
    required this.description,
    required this.price,
    required this.bedrooms,
    required this.beds,
    required this.bathrooms,
    required this.type,
    required this.amenities,
    required this.roomPhoto,
    required this.hotelLocation,
    required this.avgRating,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
    booking_id: (json["booking_id"] ?? json["id"] ?? '').toString(),
    hotelEmail: json["hotel_email"] ?? '',
    customerEmail: json["customer_email"] ?? '',
    hotelName: json["hotel_name"] ?? '',
    checkinDate: json["check_in_date"] ?? '',
    checkoutDate: json["check_out_date"] ?? '',
    duration: json["duration"] ?? '',
    adults: json["adults"] ?? '',
    childrens: json["childrens"] ?? '',
    rooms: json["rooms"] ?? '',
    totalPrice: json["totalprice"] ?? '',
    paymentMode: json["paymentmode"] ?? '',
    roomNo: json["room_no"] ?? '',
    description: json["description"] ?? '',
    price: json["price"] ?? '',
    bedrooms: json["bedrooms"] ?? '',
    beds: json["beds"] ?? '',
    bathrooms: json["bathrooms"] ?? '',
    type: json["type"] ?? '',
    amenities: json["amenities"] ?? '',
    roomPhoto: json["roomPhoto"] ?? json["image"] ?? '',
    hotelLocation: json["hotel_location"] ?? '',
    avgRating: json["avg_rating"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "booking_id": booking_id,
    "hotel_email": hotelEmail,
    "customer_email": customerEmail,
    "hotel_name": hotelName,
    "check_in_date": checkinDate,
    "check_out_date": checkoutDate,
    "duration": duration,
    "adults": adults,
    "childrens": childrens,
    "rooms": rooms,
    "totalprice": totalPrice,
    "paymentmode": paymentMode,
    "room_no": roomNo,
    "description": description,
    "price": price,
    "bedrooms": bedrooms,
    "beds": beds,
    "bathrooms": bathrooms,
    "type": type,
    "amenities": amenities,
    "image": roomPhoto,
    "hotel_location": hotelLocation,
    "avg_rating": avgRating,
  };
}