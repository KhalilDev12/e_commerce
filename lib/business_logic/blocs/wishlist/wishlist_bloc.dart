import 'package:e_commerce/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<StartWishlist>(_onLoadWishlist);
    on<AddWishlistProduct>(_onAddProduct);
    on<RemoveWishlistProduct>(_onRemoveProduct);
  }

  Future<void> _onLoadWishlist(
      StartWishlist event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(const WishlistLoaded([]));
    } catch (_) {}
  }

  void _onAddProduct(
      AddWishlistProduct event, Emitter<WishlistState> emit) async {
    final state = this.state as WishlistLoaded;
    if (!state.wishlist.contains(event.product)) {
      try {
        emit(
          WishlistLoaded(
            List.from(state.wishlist)..add(event.product),
          ),
        );
      } catch (_) {}
    }
  }

  void _onRemoveProduct(
      RemoveWishlistProduct event, Emitter<WishlistState> emit) async {
    final state = this.state as WishlistLoaded;
    try {
      emit(
        WishlistLoaded(
          List.from(state.wishlist)..remove(event.product),
        ),
      );
    } catch (_) {}
  }
}
