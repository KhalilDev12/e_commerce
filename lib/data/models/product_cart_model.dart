import 'package:equatable/equatable.dart';
import 'dart:math' as Math;

import 'models.dart';

class ProductCartModel extends Equatable {
  final ProductModel product;
  final int quantity;
  final bool isSelected;

  const ProductCartModel({
    required this.product,
    required this.quantity,
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [product, quantity, isSelected];

  /// Creates a copy of the current object with updated values.
  ProductCartModel copyWith({
    ProductModel? product,
    int? quantity,
    bool? isSelected,
  }) {
    return ProductCartModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  /// Calculates the total price for this product in the cart.
  double totalPrice() => product.price * quantity;

  /// Increments the quantity of this product by 1.
  ProductCartModel increaseQuantity() {
    return copyWith(quantity: quantity + 1);
  }

  /// Decrements the quantity of this product by 1 (ensures non-negative quantity).
  ProductCartModel decreaseQuantity() {
    return copyWith(quantity: Math.max(quantity - 1, 0));
  }
}