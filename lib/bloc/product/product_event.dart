part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProuct extends ProductEvent {
  const LoadProuct();

  @override
  List<Object> get props => [];
}
