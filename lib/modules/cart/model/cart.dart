import 'package:bliss_shopping/modules/product/model/product.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  const Cart({this.products = const <Product>[]});

  final List<Product> products;

  int get totalPrice =>
      products.fold(0, (total, current) => total + current.price!.toInt());

  @override
  List<Object> get props => [products];
}
