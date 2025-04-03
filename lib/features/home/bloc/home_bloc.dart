import 'dart:async';
import 'dart:convert';
import 'package:assesment/data/cart_item.dart';
import 'package:assesment/data/diamond_data.dart';
import 'package:assesment/features/home/models/product_data_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<SearchEvent>((event, emit) {
      List<ProductDataModel> productModels = DiamondData.diamondProducts
          .map((e) => ProductDataModel.fromJson(e))
          .toList();
      var filteredProducts = productModels
          .where((item) => item.fluorescence
              .toLowerCase()
              .contains(event.query.toLowerCase()))
          .toList();
      emit(HomeLoadedSuccessState(products: filteredProducts));
    });
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 5));
    emit(HomeLoadedSuccessState(
        products: DiamondData.diamondProducts
            .map((e) => ProductDataModel.fromJson(e))
            .toList()));
  }

  // With sharedPref
  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) async {
    print("HomeProductCartButtonClickedEvent");
    cartItem.add(event.clickedProduct);
    emit(HomeProductCartedActionState());
    var prefs = await SharedPreferences.getInstance();
    var productMaps = cartItem.map((e) => e.toJson()).toList();
    var data = jsonEncode(productMaps);
    prefs.setString("cart", data);
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("HomeCartButtonNavigateEvent");
    emit(HomeNavigateToCartPageActionState());
  }
}
