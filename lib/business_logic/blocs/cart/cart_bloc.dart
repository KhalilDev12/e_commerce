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
    on<CheckProduct>(_onCheckProduct);
    on<CheckAllProduct>(_onCheckAllProduct);
  }

  Future<void> _onLoadCart(StartCart event, Emitter<CartState> emit) async {
    // Implement cart loading logic and emit CartLoaded state
    emit(const CartLoaded()); // Replace with actual cart data
  }

  void _onAddProduct(AddCartProduct event, Emitter<CartState> emit) async {
    final state = this.state as CartLoaded;
    final existingIndex = state.cart.cartProducts
        .indexWhere((p) => p.product == event.cartProduct.product);
    if (existingIndex != -1) {
      // Product already exists, increase quantity
      emit(
        CartLoaded(
          cart: CartModel(
            cartProducts: List.of(state.cart.cartProducts)
              ..[existingIndex] =
                  state.cart.cartProducts[existingIndex].copyWith(
                quantity: state.cart.cartProducts[existingIndex].quantity + 1,
              ),
          ),
        ),
      );
    } else {
      // Add new product to cart
      emit(
        CartLoaded(
          cart: CartModel(
              cartProducts: List.of(state.cart.cartProducts)
                ..add(event.cartProduct)),
        ),
      );
    }
  }

  void _onRemoveProduct(
      RemoveCartProduct event, Emitter<CartState> emit) async {
    final state = this.state as CartLoaded;
    final index = state.cart.cartProducts.indexOf(event.cartProduct);

    if (index != -1 && state.cart.cartProducts[index].quantity > 1) {
      emit(
        CartLoaded(
            cart: CartModel(
          cartProducts: List.of(state.cart.cartProducts)
            ..[index] = state.cart.cartProducts[index].copyWith(
              quantity: state.cart.cartProducts[index].quantity - 1,
            ),
        )),
      );
    } else if (state.cart.cartProducts[index].quantity == 1) {
      emit(
        CartLoaded(
          cart: CartModel(
              cartProducts: List.of(state.cart.cartProducts)..removeAt(index)),
        ),
      );
    }
  }

  void _onCheckProduct(CheckProduct event, Emitter<CartState> emit) async {
    final state = this.state as CartLoaded;
    final index = state.cart.cartProducts.indexOf(event.cartProduct);
    if (index != -1) {
      emit(
        CartLoaded(
            cart: CartModel(
          cartProducts: List.of(state.cart.cartProducts)
            ..[index] = state.cart.cartProducts[index].copyWith(
              isSelected: !state.cart.cartProducts[index].isSelected,
            ),
        )),
      );
    }
  }

  void _onCheckAllProduct(
      CheckAllProduct event, Emitter<CartState> emit) async {
    final state = this.state as CartLoaded;
    emit(
      CartLoaded(
        cart: CartModel(
            cartProducts: state.cart.cartProducts
                .map((product) =>
                    product.copyWith(isSelected: event.selectedAll))
                .toList()),
      ),
    );
  }
}
