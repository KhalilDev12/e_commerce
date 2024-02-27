part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class StartCart extends CartEvent {
  @override
  List<Object> get props => [];
}

class AddCartProduct extends CartEvent {
  final ProductModel product;

  const AddCartProduct(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveCartProduct extends CartEvent {
  final ProductModel product;

  const RemoveCartProduct(this.product);

  @override
  List<Object> get props => [product];
}
