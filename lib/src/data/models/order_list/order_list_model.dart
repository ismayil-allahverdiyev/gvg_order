import 'dart:convert';

OrderListModel orderListModelFromJson(String str) =>
    OrderListModel.fromJson(json.decode(str));

String orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
  int code;
  bool status;
  String statusText;
  String message;
  dynamic rowCount;
  int totalCount;
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

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
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
  String productId;
  String productListId;
  String productName;
  int stockQuantity;
  int piecesInBox;
  int listPrice;
  int discountedListPrice;
  int selectedCount = 0;

  OrderList({
    required this.productId,
    required this.productListId,
    required this.productName,
    required this.stockQuantity,
    required this.piecesInBox,
    required this.listPrice,
    required this.discountedListPrice,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) {
    var res = json;
    return OrderList(
      productId: json["productId"],
      productListId: json["productListId"],
      productName: json["productName"],
      stockQuantity: json["stockQuantity"],
      piecesInBox: json["piecesInBox"],
      listPrice: json["listPrice"],
      discountedListPrice: json["discountedListPrice"] ?? json["listPrice"],
    );
  }

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productListId": productListId,
        "productName": productName,
        "stockQuantity": stockQuantity,
        "piecesInBox": piecesInBox,
        "listPrice": listPrice,
        "discountedListPrice": discountedListPrice,
        "selectedCount": selectedCount,
      };
}
