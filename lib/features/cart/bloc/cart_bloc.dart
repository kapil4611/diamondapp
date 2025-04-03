import 'dart:async';
import 'dart:convert';
import 'package:assesment/data/cart_item.dart';
import 'package:assesment/features/home/models/product_data_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  // With sharedPref
  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) async {
    var prefs = await SharedPreferences.getInstance();
    var localData = prefs.getString("cart");
    if (localData == null) {
      emit(CartSuccessState(cartItems: cartItem));
    } else {
      var p = jsonDecode(localData);
      List<ProductDataModel> loc = [];
      for (Map<String, dynamic> i in p) {
        loc.add(ProductDataModel.fromJson(i));
      }
      cartItem = loc;
      emit(CartSuccessState(cartItems: cartItem));
    }
  }

  // With sharedPref
  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) async {
    cartItem.remove(event.productDataModel);
    emit(CartSuccessState(cartItems: cartItem));
    emit(CartedItemRemove());

    var prefs = await SharedPreferences.getInstance();
    var productMaps = cartItem.map((e) => e.toJson()).toList();
    var data = jsonEncode(productMaps);
    prefs.setString("cart", data);
  }
}
