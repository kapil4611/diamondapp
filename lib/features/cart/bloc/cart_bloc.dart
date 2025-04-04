import 'dart:async';
import 'dart:convert';
import 'package:assesment/data/cart_item.dart';
import 'package:assesment/features/cart/models/summary_model.dart';
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

  Summarymodel getSummary(List<ProductDataModel> cartItem) {
    var totalPrice = 0.0;
    var totalCarat = 0.0;
    var totalDiscount = 0.0;
    var totalDiamond = 0;
    var avgPrice = 0.0;
    var avgDiscount = 0.0;
    totalDiamond = cartItem.length;

    for (ProductDataModel productDataModel in cartItem) {
      totalPrice += productDataModel.finalAmount;
      totalCarat += productDataModel.carat;
      totalDiscount += productDataModel.discount;
    }
    avgPrice = totalPrice / totalDiamond;
    avgDiscount = totalDiscount / totalDiamond;
    Summarymodel summarymodel = Summarymodel(
      totalPrice: totalPrice,
      totalCarat: totalCarat,
      avgPrice: avgPrice,
      avgDiscount: avgDiscount,
      totalDiamond: totalDiamond,
    );
    return summarymodel;
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) async {
    var prefs = await SharedPreferences.getInstance();
    var localData = prefs.getString("cart");
    if (localData == null) {
      Summarymodel summarymodel = getSummary(cartItem);
      emit(CartSuccessState(cartItems: cartItem, summarymodel: summarymodel));
    } else {
      var p = jsonDecode(localData);
      List<ProductDataModel> loc = [];
      for (Map<String, dynamic> i in p) {
        loc.add(ProductDataModel.fromJson(i));
      }
      cartItem = loc;
      Summarymodel summarymodel = getSummary(cartItem);
      emit(CartSuccessState(cartItems: cartItem, summarymodel: summarymodel));
    }
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) async {
    cartItem.remove(event.productDataModel);

    Summarymodel summarymodel = getSummary(cartItem);

    emit(CartSuccessState(cartItems: cartItem, summarymodel: summarymodel));
    emit(CartedItemRemove());

    var prefs = await SharedPreferences.getInstance();
    var productMaps = cartItem.map((e) => e.toJson()).toList();
    var data = jsonEncode(productMaps);
    prefs.setString("cart", data);
  }
}
