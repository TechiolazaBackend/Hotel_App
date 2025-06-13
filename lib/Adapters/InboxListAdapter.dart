import 'dart:convert';

List<InboxList> inboxlistFromJson(String str) =>
    List<InboxList>.from(json.decode(str).map((x) => InboxList.fromJson(x)));

String inboxlistToJson(List<InboxList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InboxList {
  String user_id;
  String user_name;
  String user_email;
  String profile_picture;

  InboxList({
    required this.user_id,
    required this.user_name,
    required this.user_email,
    required this.profile_picture,
  });

  factory InboxList.fromJson(Map<String, dynamic> json) => InboxList(
    user_id: json["id"].toString(),
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