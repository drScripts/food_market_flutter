import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_market/models/food.dart';
import 'package:food_market/services/product/product_provider.dart';
import 'package:http/http.dart' as http;

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<LoadProuct>(getProduct);
  }

  Future<void> getProduct(LoadProuct event, Emitter emit) async {
    emit(const ProductLoading());

    ProductProvider productProvider = ProductProvider();

    http.Response res = await productProvider.getProducts();

    dynamic responseBody = jsonDecode(res.body);

    if (res.statusCode == 200) {
      List<Food> products = [];

      for (var element in (responseBody['data'] as Iterable)) {
        Food food = Food.fromJson(element);
        products.add(food);
      }

      emit(ProductLoaded(products: products));
    } else {
      emit(ProductFailed(message: responseBody['meta']['message']));
    }
  }
}
