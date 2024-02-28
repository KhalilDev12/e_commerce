import 'package:e_commerce/data/models/models.dart';
import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  final List<ProductCartModel> cartProducts;

  const CartModel({this.cartProducts = const <ProductCartModel>[]});

  // Functions to get Sub Total
  double get subTotal {
    double subTotal = 0;
    cartProducts.forEach((cartProduct) {
      if (cartProduct.isSelected) {
        subTotal = subTotal + cartProduct.quantity * cartProduct.product.price;
      }
    });
    return subTotal;
  }

  // Functions to get Delivery Fee
  double deliveryFee() {
    if (subTotal >= 20) {
      return 0;
    } else {
      return 10;
    }
  }

  String get deliveryFeeString => deliveryFee().toStringAsFixed(2);

  // Function to get free Delivery Message
  String freeDeliveryMessage() {
    if (subTotal >= 20) {
      return "You have free Delivery";
    } else {
      String missing = (20 - subTotal).toStringAsFixed(2);
      return "Add \$$missing for Free Delivery";
    }
  }

  // Functions to get Total Fee
  double get total => subTotal + deliveryFee();

  String get totalString => total.toStringAsFixed(2);

  // Function to check if all items selected
  bool get isSelectedAll {
    bool test = false;
    cartProducts.forEach((product) {
      if (product.isSelected) {
        test = true;
      } else {
        test = false;
      }
    });
    return test;
  }

  @override
  List<Object?> get props => [cartProducts];
}
