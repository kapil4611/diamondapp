part of 'home_bloc.dart';

@immutable
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

class FilterEvent extends HomeEvent {
  final String property;
  FilterEvent({required this.property});
}

// navigation event

class HomeCartButtonNavigateEvent extends HomeEvent {}
