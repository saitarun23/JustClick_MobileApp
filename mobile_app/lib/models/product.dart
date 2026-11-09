import 'package:flutter/material.dart';

class Category {
  final String name;
  final String emoji;
  final Color color;
  const Category(this.name, this.emoji, this.color);
}

class Product {
  final String id;
  final String name;
  final String unit;
  final String emoji;
  final String category;
  final int price;
  final int mrp;

  const Product({
    required this.id,
    required this.name,
    required this.unit,
    required this.emoji,
    required this.category,
    required this.price,
    required this.mrp,
  });

  int get discount => mrp > price ? (((mrp - price) * 100) / mrp).round() : 0;
}