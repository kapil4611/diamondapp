import 'package:assesment/features/home/models/product_data_model.dart';
import 'package:flutter/material.dart';

class DetailInfo extends StatelessWidget {
  final ProductDataModel productModel;
  const DetailInfo({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(productModel.lotId.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("PerCaratRate: ${productModel.perCaratRate.toString()}"),
            Text("LabComment: ${productModel.labComment}"),
            Text("Clarity: ${productModel.clarity}"),
            Text("Color: ${productModel.color}"),
            Text("Cut: ${productModel.cut}"),
            Text("fluorescence: ${productModel.fluorescence}"),
            Text("keyToSymbol: ${productModel.keyToSymbol}"),
            Text("lab: ${productModel.lab}"),
            Text("polish: ${productModel.polish}"),
            Text("shape: ${productModel.shape}"),
            Text("size: ${productModel.size}"),
            Text("symmetry: ${productModel.symmetry}"),
            Text("discount: ${productModel.discount.toString()}"),
            Text("carat: ${productModel.carat.toString()}"),
            Text("finalAmount: ${productModel.finalAmount.toString()}"),
            Text("lotId: ${productModel.lotId.toString()}"),
            Text("perCaratRate: ${productModel.perCaratRate.toString()}"),
            Text("qty: ${productModel.qty.toString()}"),
          ],
        ),
      ),
    );
  }
}
