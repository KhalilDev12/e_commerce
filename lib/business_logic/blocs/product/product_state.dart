part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;

  const ProductLoaded({this.products = const <ProductModel>[]});

  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState {
  @override
  List<Object> get props => [];
}
