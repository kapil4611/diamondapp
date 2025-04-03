// To parse this JSON data, do
//
//     final productDataModel = productDataModelFromJson(jsonString);

import 'dart:convert';

List<ProductDataModel> productDataModelFromJson(String str) =>
    List<ProductDataModel>.from(
        json.decode(str).map((x) => ProductDataModel.fromJson(x)));

String productDataModelToJson(List<ProductDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductDataModel {
  int qty;
  int lotId;
  String size;
  double carat;
  String lab;
  String shape;
  String color;
  String clarity;
  String cut;
  String polish;
  String symmetry;
  String fluorescence;
  double discount;
  double perCaratRate;
  double finalAmount;
  String keyToSymbol;
  String labComment;

  ProductDataModel({
    required this.qty,
    required this.lotId,
    required this.size,
    required this.carat,
    required this.lab,
    required this.shape,
    required this.color,
    required this.clarity,
    required this.cut,
    required this.polish,
    required this.symmetry,
    required this.fluorescence,
    required this.discount,
    required this.perCaratRate,
    required this.finalAmount,
    required this.keyToSymbol,
    required this.labComment,
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) =>
      ProductDataModel(
        qty: json["Qty"] ?? 0,
        lotId: json["Lot ID"] ?? 0,
        size: json["Size"] ?? "",
        carat: json["Carat"]?.toDouble() ?? 0.0,
        lab: json["Lab"] ?? "",
        shape: json["Shape"] ?? "",
        color: json["Color"] ?? "",
        clarity: json["Clarity"] ?? "",
        cut: json["Cut"] ?? "",
        polish: json["Polish"] ?? "",
        symmetry: json["Symmetry"] ?? "",
        fluorescence: json["Fluorescence"] ?? "",
        discount: json["Discount"]?.toDouble() ?? 0.0,
        perCaratRate: json["Per Carat Rate"]?.toDouble() ?? 0.0,
        finalAmount: json["Final Amount"]?.toDouble() ?? 0.0,
        keyToSymbol: json["Key To Symbol"] ?? "",
        labComment: json["Lab Comment"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Qty": qty,
        "Lot ID": lotId,
        "Size": size,
        "Carat": carat,
        "Lab": lab,
        "Shape": shape,
        "Color": color,
        "Clarity": clarity,
        "Cut": cut,
        "Polish": polish,
        "Symmetry": symmetry,
        "Fluorescence": fluorescence,
        "Discount": discount,
        "Per Carat Rate": perCaratRate,
        "Final Amount": finalAmount,
        "Key To Symbol": keyToSymbol,
        "Lab Comment": labComment,
      };
}
