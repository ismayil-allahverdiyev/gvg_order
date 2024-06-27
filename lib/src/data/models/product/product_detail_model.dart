import 'dart:convert';

import 'package:gvg_order/src/data/models/campaign/campaign_detail.dart';

ProductDetailModel productDetailModelFromJson(String str) =>
    ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) =>
    json.encode(data.toJson());

class ProductDetailModel {
  int code;
  bool status;
  String statusText;
  String message;
  dynamic rowCount;
  dynamic totalCount;
  ProductData data;

  ProductDetailModel({
    required this.code,
    required this.status,
    required this.statusText,
    required this.message,
    required this.rowCount,
    required this.totalCount,
    required this.data,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
        code: json["code"],
        status: json["status"],
        statusText: json["statusText"],
        message: json["message"],
        rowCount: json["rowCount"],
        totalCount: json["totalCount"],
        data: ProductData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "statusText": statusText,
        "message": message,
        "rowCount": rowCount,
        "totalCount": totalCount,
        "data": data.toJson(),
      };
}

class ProductData {
  String id;
  String productListId;
  String productName;
  int stockQuantity;
  int listPrice;
  int discountedListPrice;
  String? description1;
  String? description2;
  String? description3;
  String? description4;
  String brandName;
  bool isFavorite;
  List<Product>? products;

  ProductData({
    required this.id,
    required this.productListId,
    required this.productName,
    required this.stockQuantity,
    required this.listPrice,
    required this.discountedListPrice,
    required this.description1,
    required this.description2,
    required this.description3,
    required this.description4,
    required this.brandName,
    required this.isFavorite,
    this.products,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    var res = json;
    return ProductData(
      id: json["id"],
      productListId: json["productListId"],
      productName: json["productName"],
      stockQuantity: json["stockQuantity"],
      listPrice: json["listPrice"],
      discountedListPrice: json["discountedListPrice"] ?? json["listPrice"],
      description1: json["description1"],
      description2: json["description2"],
      description3: json["description3"],
      description4: json["description4"],
      brandName: json["brandName"],
      isFavorite: json["isFavorite"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "productListId": productListId,
        "productName": productName,
        "stockQuantity": stockQuantity,
        "listPrice": listPrice,
        "discountedListPrice": discountedListPrice,
        "description1": description1,
        "description2": description2,
        "description3": description3,
        "description4": description4,
        "brandName": brandName,
        "isFavorite": isFavorite,
      };
}
