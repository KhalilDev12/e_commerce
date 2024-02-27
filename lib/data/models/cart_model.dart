import 'package:e_commerce/data/models/models.dart';
import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  final List<ProductModel> cartProducts;

  const CartModel({this.cartProducts = const <ProductModel>[]});

  // Functions to get Sub Total
  double get subTotal =>
      cartProducts.fold(0, (total, currentItem) => total + currentItem.price);

  String get subTotalString => subTotal.toStringAsFixed(2);

  // Functions to get Delivery Fee
  double deliveryFee(subTotal) {
    if (subTotal >= 20) {
      return 0;
    } else {
      return 10;
    }
  }

  String get deliveryFeeString => deliveryFee(subTotal).toStringAsFixed(2);

  // Function to get free Delivery Message
  String freeDeliveryMessage() {
    if (subTotal >= 20) {
      return "You have free Delivery";
    } else {
      String missing = (20 - subTotal).toStringAsFixed(2);
      return "Add \$$missing for Free Delivery";
    }
  }

  // Function to change quantity of each item
  Map productQuantity(List<ProductModel> products) {
    var quantity = {};
    products.forEach(
      (product) {
        if (!quantity.containsKey(product)) {
          quantity[product] = 1;
        } else {
          quantity[product] += 1;
        }
      },
    );
    return quantity;
  }

  // Functions to get Total Fee
  double get total => subTotal + deliveryFee(subTotal);

  String get totalString => total.toStringAsFixed(2);

  @override
  List<Object?> get props => [cartProducts];
}
