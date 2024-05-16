import 'package:cloud_firestore/cloud_firestore.dart';

class ProductPromosModel {
  final int id;
  final String imageUrl;
  final String name;
  final double price;
  final double review;
  final double star;
  int value;

  ProductPromosModel(
      {required this.id,
      required this.imageUrl,
      required this.name,
      required this.price,
      required this.review,
      required this.star,
      required this.value});
}

class Promo {
  final String id;
  final String product_name;
  final String product_description;
  final String image_url;
  final double price;

  Promo({
    required this.id,
    required this.product_name,
    required this.product_description,
    required this.image_url,
    required this.price,
  });

  factory Promo.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    return Promo(
      id: map['id'],
      product_name: map['product_name'],
      product_description: map['product_description'],
      image_url: map['image_url'],
      price: map['price'].toDouble(),
    );
  }

  // Convert a Promo object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_name': product_name,
      'product_description': product_description,
      'image_url': image_url,
      'price': price,
    };
  }

  // Create a Promo object from a Map
  static Promo fromMap(Map<String, dynamic> map) {
    return Promo(
      id: map['id'],
      product_name: map['product_name'],
      product_description: map['product_description'],
      image_url: map['image_url'],
      price: map['price'].toDouble(),
    );
  }
}
