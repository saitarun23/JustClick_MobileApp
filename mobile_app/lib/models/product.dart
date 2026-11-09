import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon; // fallback if the image is missing or fails
  final Color color;
  final String image; // image URL (leave '' to show the icon)

  const Category(this.name, this.icon, this.color, {this.image = ''});
}

class Product {
  final String id;
  final String name;
  final String unit;
  final String image; // image URL
  final String category;
  final int price;
  final int mrp;

  const Product({
    required this.id,
    required this.name,
    required this.unit,
    required this.image,
    required this.category,
    required this.price,
    required this.mrp,
  });

  int get discount => mrp > price ? (((mrp - price) * 100) / mrp).round() : 0;
}