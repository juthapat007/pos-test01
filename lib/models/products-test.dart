import 'package:flutter/material.dart';

enum Brand {
  suzuki(
    title: "suzuki xl7",
    image: "assets/images/D.jpg",
    color: Colors.amber,
  ),
  ford(
    title: "ford kuga 2025",
    image: "assets/images/OIP.webp",
    color: Colors.deepPurple,
  ),

  honda(title: "honda bb", image: "assets/images/F.jpg", color: Colors.pink);

  const Brand({required this.title, required this.image, required this.color});
  final String title;
  final String image;
  final Color color;
}

class Products {
  Products({required this.brand, required this.price, required this.name});
  Brand brand;
  double price;
  String name;
}

List<Products> data = [
  Products(brand: Brand.suzuki, price: 100.00, name: "Shosess"),
  Products(brand: Brand.ford, price: 150.00, name: "Y"),
  Products(brand: Brand.honda, price: 100.00, name: "cups"),
];
