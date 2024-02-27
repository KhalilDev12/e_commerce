import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final bool isRecommended;
  final bool isPopular;

  ProductModel({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.isRecommended,
    required this.isPopular,
  });

  @override
  List<Object?> get props =>
      [name, category, imageUrl, price, isRecommended, isPopular];

  static ProductModel fromSnapshot(DocumentSnapshot snap) {
    return ProductModel(
        name: snap["name"],
        category: snap["category"],
        imageUrl: snap["imageUrl"],
        price: snap["price"],
        isRecommended: snap["isRecommended"],
        isPopular: snap["isPopular"]);
  }
}
