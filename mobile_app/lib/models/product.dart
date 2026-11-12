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

/// One pack size of a product, for example "500 g" at ₹80.
class Variant {
  final String label;
  final int price;
  final int mrp;

  const Variant(this.label, this.price, this.mrp);

  int get discount => mrp > price ? (((mrp - price) * 100) / mrp).round() : 0;

  @override
  bool operator ==(Object other) =>
      other is Variant &&
      other.label == label &&
      other.price == price &&
      other.mrp == mrp;

  @override
  int get hashCode => Object.hash(label, price, mrp);
}

class Product {
  final String id;
  final String name;
  final String unit;
  final String image;
  final String category;
  final int price;
  final int mrp;

  // Extra details (all optional)
  final String brand;
  final double rating;
  final int ratingCount;
  final String description;
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
    this.rating = 4.4,
    this.ratingCount = 100,
    this.description = '',
    this.images = const [],
    this.variants = const [],
    this.details = const {},
  });

  int get discount => mrp > price ? (((mrp - price) * 100) / mrp).round() : 0;

  /// Text for the "About this product" section.
  String get about => description.isEmpty
      ? 'Fresh $name, picked and packed with care for your kitchen.'
      : description;

  /// Photos for the detail page gallery.
  List<String> get gallery => images.isEmpty ? [image] : images;

  /// Pack sizes. The first one is the standard pack.
  List<Variant> get options =>
      variants.isEmpty ? [Variant(unit, price, mrp)] : variants;
}