import 'package:assesment/features/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Cart Item"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Removed from cart!")));
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              var sp = successState.cartItems;
              var summaryData = successState.summarymodel;

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: successState.cartItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              successState.cartItems[index].lotId.toString()),
                          trailing: IconButton(
                              onPressed: () {
                                cartBloc.add(CartRemoveFromCartEvent(
                                    productDataModel:
                                        successState.cartItems[index]));
                              },
                              icon: Icon(Icons.shopping_bag)),
                        );
                      },
                    ),
                  ),
                  if (sp.length != 0.0)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total carat: ${summaryData.totalCarat}",
                              style: TextStyle(fontSize: 20)),
                          Text("Total price: ${summaryData.totalPrice}",
                              style: TextStyle(fontSize: 20)),
                          Text("Average price: ${summaryData.avgPrice}",
                              style: TextStyle(fontSize: 20)),
                          Text("Average discount: ${summaryData.avgDiscount}",
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  SizedBox(height: 72),
                ],
              );
            default:
          }
          return Container();
        },
      ),
    );
  }
}
