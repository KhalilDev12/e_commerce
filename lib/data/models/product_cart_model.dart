import 'package:equatable/equatable.dart';

import 'models.dart';

class ProductCartModel extends Equatable {
  final ProductModel product;
  bool isSelected;

  ProductCartModel({
    required this.product,
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [product, isSelected];
}
