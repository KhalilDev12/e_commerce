import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String productId;
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final bool isRecommended;
  final bool isPopular;

  ProductModel({
    required this.productId,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.isRecommended,
    required this.isPopular,
  });

  @override
  List<Object?> get props =>
      [productId, name, category, imageUrl, price, isRecommended, isPopular];

  static ProductModel fromSnapshot(DocumentSnapshot snap) {
    return ProductModel(
        productId: snap.id,
        name: snap["name"],
        category: snap["category"],
        imageUrl: snap["imageUrl"],
        price: snap["price"],
        isRecommended: snap["isRecommended"],
        isPopular: snap["isPopular"]);
  }
}
