import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  final Color color;
  final String image;

  const Category(this.name, this.icon, this.color, {this.image = ''});
}

class Promo {
  final String title;
  final String subtitle;
  final Color color;
  final String image;

  const Promo(this.title, this.subtitle, this.color, {this.image = ''});
}

/// One purchasable size/pack of a product.
class Variant {
  final String label; // "500 g", "1 kg", "Pack of 2"
  final int price;
  final int mrp;

  const Variant(this.label, this.price, this.mrp);

  int get discount => mrp > price ? (((mrp - price) * 100) / mrp).round() : 0;
}

class Product {
  final String id;
  final String name;
  final String unit;
  final String image;
  final String category;
  final int price;
  final int mrp;

  // Detail page fields (all optional)
  final String brand;
  final String description;
  final double rating;
  final int ratingCount;
  final List<String> images;
  final List<Variant> variants;
  final Map<String, String> details;

  const Product({
    required this.id,
    required this.name,
    required this.unit,
    required this.image,
    required this.category,
    required this.price,
    required this.mrp,
    this.brand = 'Just Click',
    this.description = '',
    this.rating = 4.4,
    this.ratingCount = 120,
    this.images = const [],
    this.variants = const [],
    this.details = const {},
  });

  int get discount => mrp > price ? (((mrp - price) * 100) / mrp).round() : 0;

  /// If no variants are given, the product's own unit/price is the only option.
  List<Variant> get options =>
      variants.isEmpty ? [Variant(unit, price, mrp)] : variants;

  Variant get defaultVariant => options.first;

  List<String> get gallery => images.isEmpty ? [image] : images;

  String get about => description.isEmpty
      ? 'Fresh $name, carefully picked, quality checked and packed so it '
          'reaches your door in about 10 minutes.'
      : description;
}