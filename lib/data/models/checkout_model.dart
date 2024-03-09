import 'package:e_commerce/data/models/models.dart';
import 'package:equatable/equatable.dart';

class CheckoutModel extends Equatable {
  final String? address;
  final String? city;
  final String? country;
  final String? customerName;
  final String? customerEmail;
  final String? deliveryFee;
  final String? subTotal;
  final String? total;
  final List<ProductCartModel>? products;

  CheckoutModel({
    required this.address,
    required this.city,
    required this.country,
    required this.customerName,
    required this.customerEmail,
    required this.deliveryFee,
    required this.subTotal,
    required this.total,
    required this.products,
  });

  @override
  List<Object?> get props => [
        address,
        city,
        country,
        customerEmail,
        customerName,
        deliveryFee,
        subTotal,
        total,
        products
      ];

  Map<String, Object> toDocument() {
    Map<String, String> customerAddress = {};
    customerAddress["address"] = address!;
    customerAddress["city"] = city!;
    customerAddress["country"] = country!;

    Map<String, int> items = {};

    products!.forEach((cartProduct) {
      items.addEntries(
          {MapEntry(cartProduct.product.productId, cartProduct.quantity)});
    });

    return {
      "customerAddress": customerAddress,
      "customerName": customerName!,
      "customerEmail": customerEmail!,
      "items": items,
      "deliveryFee": deliveryFee!,
      "subTotal": subTotal!,
      "total": total!,
    };
  }
}
