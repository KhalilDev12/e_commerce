import 'dart:async';

import 'package:e_commerce/data/repositories/checkout_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/models.dart';
import '../cart/cart_bloc.dart';

part 'checkout_event.dart';

part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc _cartBloc;
  final CheckoutRepository _checkoutRepository;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _checkoutSubscription;

  CheckoutBloc(
      {required CartBloc cartBloc,
      required CheckoutRepository checkoutRepository})
      : _cartBloc = cartBloc,
        _checkoutRepository = checkoutRepository,
        super(cartBloc.state is CartLoaded
            ? CheckoutLoaded(
                products:
                    (cartBloc.state as CartLoaded).cart.selectedCartProducts(),
                deliveryFee:
                    (cartBloc.state as CartLoaded).cart.deliveryFeeString,
                subTotal: (cartBloc.state as CartLoaded).cart.subTotalString,
                total: (cartBloc.state as CartLoaded).cart.totalString,
              )
            : CheckoutLoading()) {
    _cartSubscription = cartBloc.stream.listen((event) {
      if (event is CartLoaded) {
        add(UpdateCheckout(cart: event.cart));
      }
    });
    on<CheckoutEvent>((event, emit) {
      if (event is UpdateCheckout) {
        _onUpdateCheckout(event, emit);
      } else if (event is ConfirmCheckout) {
        _onConfirmProducts(event, emit);
      }
    });
  }

  void _onUpdateCheckout(UpdateCheckout event, Emitter<CheckoutState> emit) {
    final state = this.state;
    if (state is CheckoutLoaded) {
      emit(CheckoutLoaded(
        email: event.email ?? state.email,
        fullName: event.fullName ?? state.fullName,
        address: event.address ?? state.address,
        city: event.city ?? state.city,
        country: event.country ?? state.country,
        deliveryFee: event.cart?.deliveryFeeString ?? state.deliveryFee,
        subTotal: event.cart?.subTotalString ?? state.subTotal,
        total: event.cart?.totalString ?? state.total,
        products: event.cart?.selectedCartProducts() ?? state.products,
      ));
    }
  }

  Future<void> _onConfirmProducts(
      ConfirmCheckout event, Emitter<CheckoutState> emit) async {
    final state = this.state;
    if (state is CheckoutLoaded) {
      try {
        _checkoutRepository.addCheckout(state.checkoutModel);
        print("Purchase is Done");
        emit(CheckoutSuccess());
        emit(CheckoutLoaded());
      } catch (e) {
        print(e);
      }
    }
  }
}
