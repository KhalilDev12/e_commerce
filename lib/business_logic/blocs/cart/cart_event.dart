part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class StartCart extends CartEvent {} // Trigger loading of cart items

class AddCartProduct extends CartEvent {
  final ProductCartModel cartProduct;

  const AddCartProduct(this.cartProduct);

  @override
  List<Object> get props => [cartProduct];
}

class RemoveCartProduct extends CartEvent {
  final ProductCartModel cartProduct;

  const RemoveCartProduct(this.cartProduct);

  @override
  List<Object> get props => [cartProduct];
}

class CheckProduct extends CartEvent {
  final ProductCartModel cartProduct;

  const CheckProduct(this.cartProduct);

  @override
  List<Object> get props => [cartProduct];
}

class CheckAllProduct extends CartEvent {
  final bool selectedAll;

  const CheckAllProduct(this.selectedAll);

  @override
  List<Object> get props => [selectedAll];
}
