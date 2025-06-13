import 'package:flutter/material.dart';

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
    foregroundColor: Colors.black,
    minimumSize: Size(double.infinity, 40),
    backgroundColor: Color(0xFFFFFFFF),
    elevation: 1,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
);

final ButtonStyle buttonSearch = ElevatedButton.styleFrom(
    foregroundColor: Colors.black,
    minimumSize: Size(double.infinity, 40),
    backgroundColor: Color(0xFFFF5757),
    elevation: 1,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
);

final ButtonStyle buttonAddtocart = ElevatedButton.styleFrom(
    foregroundColor: Colors.black,
    minimumSize: Size(200, 40),
    backgroundColor: Color(0xFF6E3EC0),
    elevation: 1,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
);

final ButtonStyle buttonBuynow = ElevatedButton.styleFrom(
    foregroundColor: Colors.black,
    minimumSize: Size(200, 40),
    backgroundColor: Color(0xFF750894),
    elevation: 1,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
);