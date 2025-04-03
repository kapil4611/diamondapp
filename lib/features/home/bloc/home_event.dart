part of 'home_bloc.dart';

@immutable
// sealed class HomeEvent {}
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

// button clicked event
class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeProductCartButtonClickedEvent({required this.clickedProduct});
}

class SearchEvent extends HomeEvent {
  final String query;
  SearchEvent({required this.query});
}

// navigation event

class HomeCartButtonNavigateEvent extends HomeEvent {}
