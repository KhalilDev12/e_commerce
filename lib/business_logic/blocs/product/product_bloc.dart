import 'dart:async';

import 'package:e_commerce/data/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/models.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _streamSubscription;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading()) {
    on<ProductEvent>((event, emit) {
      if (event is LoadProducts) {
        _onLoadProducts(event, emit);
      } else if (event is UpdateProducts) {
        _onUpdateProducts(event, emit);
      }
    });
  }

  Future<void> _onLoadProducts(
      LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    await Future.delayed(const Duration(seconds: 1));
    _streamSubscription?.cancel();
    _streamSubscription = _productRepository.getAllProducts().listen(
          (products) => add(
            UpdateProducts(products),
          ),
        );
  }

  Future<void> _onUpdateProducts(
      UpdateProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoaded(products: event.products));
  }
}
