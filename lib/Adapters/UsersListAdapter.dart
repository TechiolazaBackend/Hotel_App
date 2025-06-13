import 'dart:convert';

List<UsersList> userslistFromJson(String str) =>
    List<UsersList>.from(json.decode(str).map((x) => UsersList.fromJson(x)));

String userslistToJson(List<UsersList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersList {
  String user_id;
  String user_name;
  String user_email;
  String profile_picture;

  UsersList({
    required this.user_id,
    required this.user_name,
    required this.user_email,
    required this.profile_picture,
  });

  factory UsersList.fromJson(Map<String, dynamic> json) => UsersList(
    user_id: json["id"].toString(), // Convert integer to string
    user_name: json["name"],
    user_email: json["email"],
    profile_picture: json["profile_picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": user_id,
    "name": user_name,
    "email": user_email,
    "profile_picture": profile_picture,
  };
}