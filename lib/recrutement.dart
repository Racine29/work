import 'package:flutter/material.dart';

class Recrutement {
  String name;
  String location;
  String job;
  int price;
  String rating;
  String profilImage;
  String? city;
  Recrutement({
    required this.name,
    required this.location,
    required this.job,
    required this.price,
    required this.rating,
    this.city,
    required this.profilImage,
  });
}

List<IconData> icons = [
  Icons.home_rounded,
  Icons.navigation_rounded,
  Icons.person_2_rounded,
  Icons.notifications,
  Icons.chat_bubble_rounded,
];
