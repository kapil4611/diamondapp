part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartSuccessState extends CartState {
  final List<ProductDataModel> cartItems;
  final Summarymodel summarymodel;

  CartSuccessState({required this.cartItems, required this.summarymodel});
}

class CartedItemRemove extends CartActionState {}
