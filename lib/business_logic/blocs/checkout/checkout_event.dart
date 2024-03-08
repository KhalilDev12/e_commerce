part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCheckout extends CheckoutEvent {
  final String? address;
  final String? city;
  final String? country;
  final String? fullName;
  final String? email;
  final CartModel? cart;

  UpdateCheckout(
      {this.address,
      this.city,
      this.country,
      this.fullName,
      this.email,
      this.cart});

  @override
  List<Object?> get props => [address, city, country, fullName, email, cart];
}

class ConfirmCheckout extends CheckoutEvent {
  final CheckoutModel checkout;

  ConfirmCheckout({required this.checkout});

  @override
  List<Object?> get props => [checkout];
}
