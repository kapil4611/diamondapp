import 'package:assesment/features/cart/ui/cart.dart';
import 'package:assesment/features/detail/ui/detail_info.dart';
import 'package:assesment/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> items = ['EX', 'G', 'VG', 'All'];
  String? selectedItem;

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  void filterSearch(String query) {
    homeBloc.add(SearchEvent(query: query));
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeProductCartedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Added to cart!")));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.teal,
                  title: Text("Diamon product App"),
                  actions: [
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeCartButtonNavigateEvent());
                        },
                        icon: Icon(Icons.shopping_bag_outlined))
                  ],
                ),
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: filterSearch,
                              decoration: InputDecoration(
                                hintText: 'Type Fluorescence to filter',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          DropdownButton<String>(
                            hint: const Text('Symmetry'),
                            value: selectedItem,
                            items: items.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (value) {
                              homeBloc.add(FilterEvent(property: value!));
                              selectedItem = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: successState.products.length,
                        itemBuilder: (context, index) {
                          var item = successState.products[index];
                          return ListTile(
                            // leading: Text((index + 1).toString()),
                            leading: Text(item.symmetry),
                            title: Text("Lot ID: ${item.lotId}"),
                            subtitle:
                                Text("Fluorescence: ${item.fluorescence}"),
                            trailing: IconButton(
                              onPressed: () {
                                homeBloc.add(HomeProductCartButtonClickedEvent(
                                    clickedProduct:
                                        successState.products[index]));
                              },
                              icon: Icon(Icons.shopping_bag_outlined),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          DetailInfo(productModel: item)));
                            },
                          );
                        },
                      ),
                    )
                  ],
                ));
          default:
            return SizedBox();
        }
      },
    );
  }
}
