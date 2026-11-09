import 'package:flutter/material.dart';
import '../models/product.dart';

const List<Category> categories = [
  Category('Fruits', '🍎', Color(0xFFFDE8E8)),
  Category('Vegetables', '🥦', Color(0xFFE6F4EA)),
  Category('Dairy', '🥛', Color(0xFFE8F0FD)),
  Category('Snacks', '🍿', Color(0xFFFFF3D6)),
  Category('Drinks', '🥤', Color(0xFFEDE7F6)),
  Category('Bakery', '🍞', Color(0xFFFBE9DD)),
];

const List<Product> products = [
  Product(id: 'p1', name: 'Fresh Apples', unit: '1 kg', emoji: '🍎', category: 'Fruits', price: 149, mrp: 180),
  Product(id: 'p2', name: 'Bananas', unit: '6 pcs', emoji: '🍌', category: 'Fruits', price: 45, mrp: 55),
  Product(id: 'p3', name: 'Grapes', unit: '500 g', emoji: '🍇', category: 'Fruits', price: 80, mrp: 95),
  Product(id: 'p4', name: 'Tomatoes', unit: '1 kg', emoji: '🍅', category: 'Vegetables', price: 40, mrp: 48),
  Product(id: 'p5', name: 'Broccoli', unit: '1 pc', emoji: '🥦', category: 'Vegetables', price: 60, mrp: 60),
  Product(id: 'p6', name: 'Carrots', unit: '500 g', emoji: '🥕', category: 'Vegetables', price: 35, mrp: 42),
  Product(id: 'p7', name: 'Toned Milk', unit: '500 ml', emoji: '🥛', category: 'Dairy', price: 35, mrp: 35),
  Product(id: 'p8', name: 'Farm Eggs', unit: '12 pcs', emoji: '🥚', category: 'Dairy', price: 84, mrp: 96),
  Product(id: 'p9', name: 'Cheese Slices', unit: '200 g', emoji: '🧀', category: 'Dairy', price: 120, mrp: 140),
  Product(id: 'p10', name: 'Salted Chips', unit: '100 g', emoji: '🍟', category: 'Snacks', price: 30, mrp: 35),
  Product(id: 'p11', name: 'Popcorn', unit: '120 g', emoji: '🍿', category: 'Snacks', price: 50, mrp: 60),
  Product(id: 'p12', name: 'Cola', unit: '750 ml', emoji: '🥤', category: 'Drinks', price: 40, mrp: 45),
  Product(id: 'p13', name: 'Orange Juice', unit: '1 L', emoji: '🧃', category: 'Drinks', price: 99, mrp: 120),
  Product(id: 'p14', name: 'Brown Bread', unit: '400 g', emoji: '🍞', category: 'Bakery', price: 45, mrp: 50),
  Product(id: 'p15', name: 'Croissant', unit: '2 pcs', emoji: '🥐', category: 'Bakery', price: 70, mrp: 85),
];