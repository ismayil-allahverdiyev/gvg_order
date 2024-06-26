import 'dart:convert';

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
  String? id;
  String? productId;
  String productListId;
  String productName;
  int stockQuantity;
  int piecesInBox;
  int listPrice;
  int discountedListPrice;
  int selectedCount = 0;
  String? typeId;
  int discountedPrice;

  OrderList({
    required this.id,
    required this.productId,
    required this.productListId,
    required this.productName,
    required this.stockQuantity,
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
      productId: json["productId"],
      productListId: json["productListId"],
      productName: json["productName"] ?? json["name"],
      stockQuantity: json["stockQuantity"] ?? json["stock"],
      piecesInBox: json["piecesInBox"],
      listPrice: json["listPrice"],
      discountedListPrice: json["discountedListPrice"] ?? json["listPrice"],
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
        "stockQuantity": stockQuantity,
        "piecesInBox": piecesInBox,
        "listPrice": listPrice,
        "discountedListPrice": discountedListPrice,
        "selectedCount": selectedCount,
        "typeId": typeId,
        "discountedPrice": discountedPrice,
      };
}
