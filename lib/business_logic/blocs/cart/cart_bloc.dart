import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/models.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<StartCart>(_onLoadCart);
    on<AddCartProduct>(_onAddProduct);
    on<RemoveCartProduct>(_onRemoveProduct);
  }

  Future<void> _onLoadCart(StartCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(const CartLoaded());
    } catch (_) {}
  }

  void _onAddProduct(AddCartProduct event, Emitter<CartState> emit) async {
    final state = this.state as CartLoaded;
    try {
      emit(
        CartLoaded(
            cart: CartModel(
                cartProducts: List.from(state.cart.cartProducts)
                  ..add(event.product))),
      );
    } catch (_) {}
  }

  void _onRemoveProduct(
      RemoveCartProduct event, Emitter<CartState> emit) async {
    final state = this.state as CartLoaded;
    try {
      emit(
        CartLoaded(
          cart: CartModel(
            cartProducts: List.from(state.cart.cartProducts)
              ..remove(event.product),
          ),
        ),
      );
    } catch (_) {}
  }
}
