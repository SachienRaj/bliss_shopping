part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final Cart cart;

  const CartLoaded({required this.cart});

  @override
  List<Object> get props => [cart];
}
