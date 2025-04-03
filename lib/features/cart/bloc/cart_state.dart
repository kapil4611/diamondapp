// part of 'cart_bloc.dart';

// @immutable
// sealed class CartState {}

// final class CartInitial extends CartState {}

part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartSuccessState extends CartState {
  final List<ProductDataModel> cartItems;

  CartSuccessState({required this.cartItems});
}

class CartedItemRemove extends CartActionState {}
