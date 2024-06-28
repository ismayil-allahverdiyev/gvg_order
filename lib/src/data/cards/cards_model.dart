// To parse this JSON data, do
//
//     final cardsModel = cardsModelFromJson(jsonString);

import 'dart:convert';

CardsModel cardsModelFromJson(String str) =>
    CardsModel.fromJson(json.decode(str));

String cardsModelToJson(CardsModel data) => json.encode(data.toJson());

class CardsModel {
  int code;
  bool status;
  String message;
  dynamic rowCount;
  int totalCount;
  List<CardModel> data;

  CardsModel({
    required this.code,
    required this.status,
    required this.message,
    required this.rowCount,
    required this.totalCount,
    required this.data,
  });

  factory CardsModel.fromJson(Map<String, dynamic> json) => CardsModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        rowCount: json["rowCount"],
        totalCount: json["totalCount"],
        data: List<CardModel>.from(
            json["data"].map((x) => CardModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "rowCount": rowCount,
        "totalCount": totalCount,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CardModel {
  String cardId;
  int productAmount;
  double totalPrice;
  bool isPayment;
  String cardCode;
  DateTime createdDate;
  DateTime? plannedDueDate;
  String outletId;
  String outletName;

  CardModel({
    required this.cardId,
    required this.productAmount,
    required this.totalPrice,
    required this.isPayment,
    required this.cardCode,
    required this.createdDate,
    required this.plannedDueDate,
    required this.outletId,
    required this.outletName,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        cardId: json["cardId"],
        productAmount: json["productAmount"],
        totalPrice: json["totalPrice"]?.toDouble(),
        isPayment: json["isPayment"],
        cardCode: json["cardCode"],
        createdDate: DateTime.parse(json["createdDate"]),
        plannedDueDate: json["plannedDueDate"] == null
            ? null
            : DateTime.parse(json["plannedDueDate"]),
        outletId: json["outletId"],
        outletName: json["outletName"],
      );

  Map<String, dynamic> toJson() => {
        "cardId": cardId,
        "productAmount": productAmount,
        "totalPrice": totalPrice,
        "isPayment": isPayment,
        "cardCode": cardCode,
        "createdDate": createdDate.toIso8601String(),
        "plannedDueDate": plannedDueDate?.toIso8601String(),
        "outletId": outletId,
        "outletName": outletName,
      };
}
