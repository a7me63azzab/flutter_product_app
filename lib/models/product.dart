import 'package:flutter/material.dart';
import 'package:flutter_course/models/location_data.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String imagePath;
  final String userEmail;
  final String userId;
  final bool isFavorite;
  final LocationData location;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.image,
      @required this.imagePath,
      @required this.userEmail,
      @required this.userId,
      @required this.location,
      this.isFavorite = false});
}
