part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

// below three build state (Builder)
class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeState {}

//  Actionable state (Listener)
class HomeNavigateToCartPageActionState extends HomeActionState {}

class HomeProductCartedActionState extends HomeActionState {}
