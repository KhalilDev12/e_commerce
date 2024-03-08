part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();
}

class CheckoutLoading extends CheckoutState {
  @override
  List<Object> get props => [];
}

class CheckoutLoaded extends CheckoutState {
  final String? address;
  final String? city;
  final String? country;
  final String? fullName;
  final String? email;
  final String? deliveryFee;
  final String? subTotal;
  final String? total;
  final List<ProductCartModel>? products;
  final CheckoutModel checkoutModel;

  CheckoutLoaded(
      {this.address,
      this.city,
      this.country,
      this.fullName,
      this.email,
      this.deliveryFee,
      this.subTotal,
      this.total,
      this.products})
      : checkoutModel = CheckoutModel(
            address: address,
            city: city,
            country: country,
            customerName: fullName,
            customerEmail: email,
            deliveryFee: deliveryFee,
            subTotal: subTotal,
            total: total,
            products: products);

  @override
  List<Object?> get props => [
        address,
        city,
        country,
        email,
        fullName,
        deliveryFee,
        subTotal,
        total,
        products,
        checkoutModel,
      ];
}

class CheckoutSuccess extends CheckoutState {
  @override
  List<Object> get props => [];
}

class CheckoutError extends CheckoutState {
  @override
  List<Object> get props => [];
}
