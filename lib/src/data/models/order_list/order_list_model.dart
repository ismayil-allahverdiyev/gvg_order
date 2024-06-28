import 'dart:convert';

import 'package:gvg_order/src/data/models/image_file/image_file_model.dart';

OrderListModel orderListModelFromJson(String str) =>
    OrderListModel.fromJson(json.decode(str));

String orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
  int code;
  bool status;
  String statusText;
  String message;
  int? rowCount;
  int? totalCount;
  List<OrderList>? data;

  OrderListModel({
    required this.code,
    required this.status,
    required this.statusText,
    required this.message,
    required this.rowCount,
    required this.totalCount,
    required this.data,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    var res = json;
    return OrderListModel(
      code: json["code"],
      status: json["status"],
      statusText: json["statusText"],
      message: json["message"],
      rowCount: json["rowCount"] ?? 0,
      totalCount: json["totalCount"] ?? 0,
      data: json["data"] == null
          ? []
          : List<OrderList>.from(
              json["data"].map((x) => OrderList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "statusText": statusText,
        "message": message,
        "rowCount": rowCount,
        "totalCount": totalCount,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class OrderList {
  String? id;
  String? productId;
  String productListId;
  String productName;
  int? piecesInBox;
  double listPrice;
  double discountedListPrice;
  int selectedCount = 0;
  String? typeId;
  double discountedPrice;
  bool isCampaign = false;
  ImageFile? imageFile;

  OrderList({
    required this.id,
    required this.productId,
    required this.productListId,
    required this.productName,
    required this.piecesInBox,
    required this.listPrice,
    required this.discountedListPrice,
    this.selectedCount = 0,
    this.typeId,
    this.discountedPrice = 0,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) {
    var res = json;
    return OrderList(
      id: json["id"],
      productId: json["productId"] ?? json["id"],
      productListId: json["productListId"],
      productName: json["productName"] ?? json["name"],
      piecesInBox: json["piecesInBox"],
      listPrice: json["listPrice"] ??
          json["discountedListPrice"] ??
          json["discountedPrice"] ??
          0,
      discountedListPrice: json["discountedListPrice"] ??
          json["listPrice"] ??
          json["discountedPrice"] ??
          0,
      selectedCount: json["selectedCount"] ?? 0,
      typeId: json["typeId"],
      discountedPrice: json["discountedPrice"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "productListId": productListId,
        "productName": productName,
        "piecesInBox": piecesInBox,
        "listPrice": listPrice,
        "discountedListPrice": discountedListPrice,
        "selectedCount": selectedCount,
        "typeId": typeId,
        "discountedPrice": discountedPrice,
        "imageFile": imageFile?.toJson() ?? "",
      };
}
