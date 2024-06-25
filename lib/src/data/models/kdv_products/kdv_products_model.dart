import 'dart:convert';

KdvProductsModel kdvProductsModelFromJson(String str) =>
    KdvProductsModel.fromJson(json.decode(str));

String kdvProductsModelToJson(KdvProductsModel data) =>
    json.encode(data.toJson());

class KdvProductsModel {
  int code;
  bool status;
  String statusText;
  dynamic message;
  dynamic rowCount;
  dynamic totalCount;
  List<KdvProduct> data;

  KdvProductsModel({
    required this.code,
    required this.status,
    required this.statusText,
    required this.message,
    required this.rowCount,
    required this.totalCount,
    required this.data,
  });

  factory KdvProductsModel.fromJson(Map<String, dynamic> json) =>
      KdvProductsModel(
        code: json["code"],
        status: json["status"],
        statusText: json["statusText"],
        message: json["message"],
        rowCount: json["rowCount"],
        totalCount: json["totalCount"],
        data: List<KdvProduct>.from(
            json["data"].map((x) => KdvProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "statusText": statusText,
        "message": message,
        "rowCount": rowCount,
        "totalCount": totalCount,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class KdvProduct {
  String id;
  String listId;
  bool isCampaign;
  int amount;
  double kdv;
  double price;
  int stock;
  String name;

  KdvProduct({
    required this.id,
    required this.listId,
    required this.isCampaign,
    required this.amount,
    required this.kdv,
    required this.price,
    required this.stock,
    required this.name,
  });

  factory KdvProduct.fromJson(Map<String, dynamic> json) => KdvProduct(
        id: json["id"],
        listId: json["listId"],
        isCampaign: json["isCampaign"],
        amount: json["amount"],
        kdv: json["kdv"]?.toDouble(),
        price: json["price"].toDouble(),
        stock: json["stock"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "listId": listId,
        "isCampaign": isCampaign,
        "amount": amount,
        "kdv": kdv,
        "price": price,
        "stock": stock,
        "name": name,
      };
}
