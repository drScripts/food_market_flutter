part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Food> products;
  const ProductLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductFailed extends ProductState {
  final String message;

  const ProductFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class ProductLoading extends ProductState {
  const ProductLoading();

  @override
  List<Object> get props => [];
}
