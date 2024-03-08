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

  String get subTotalString => subTotal.toStringAsFixed(2);

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

  List<ProductCartModel> selectedCartProducts() {
    return cartProducts.where((product) => product.isSelected).toList();
  }

  @override
  List<Object?> get props => [cartProducts];
}
