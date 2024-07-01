import 'dart:convert';

import 'package:gvg_order/src/data/models/image_file/image_file_model.dart';

CardDetailModel cardDetailModelFromJson(String str) =>
    CardDetailModel.fromJson(json.decode(str));

String cardDetailModelToJson(CardDetailModel data) =>
    json.encode(data.toJson());

class CardDetailModel {
  int code;
  bool status;
  String message;
  dynamic rowCount;
  dynamic totalCount;
  List<CardDetail> data;

  CardDetailModel({
    required this.code,
    required this.status,
    required this.message,
    required this.rowCount,
    required this.totalCount,
    required this.data,
  });

  factory CardDetailModel.fromJson(Map<String, dynamic> json) =>
      CardDetailModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        rowCount: json["rowCount"],
        totalCount: json["totalCount"],
        data: List<CardDetail>.from(
            json["data"].map((x) => CardDetail.fromJson(x))),
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

class CardDetail {
  String? produuctId;
  String? campaignId;
  String campaignName;
  List<String> name;
  bool isCampaign;
  int quantity;
  double price;
  double kdv;
  String? userId;
  String? customerId;
  ImageFile? imageFile;

  CardDetail({
    required this.produuctId,
    required this.campaignId,
    required this.campaignName,
    required this.name,
    required this.isCampaign,
    required this.quantity,
    required this.price,
    required this.kdv,
    required this.userId,
    required this.customerId,
    this.imageFile,
  });

  factory CardDetail.fromJson(Map<String, dynamic> json) {
    var res = json;
    return CardDetail(
      produuctId: json["produuctId"],
      campaignId: json["campaignId"],
      campaignName: json["campaignName"],
      name: List<String>.from(json["name"].map((x) => x)),
      isCampaign: json["isCampaign"],
      quantity: json["quantity"],
      price: json["price"],
      kdv: json["kdv"]?.toDouble(),
      userId: json["userId"],
      customerId: json["customerId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "produuctId": produuctId,
        "campaignId": campaignId,
        "campaignName": campaignName,
        "name": List<dynamic>.from(name.map((x) => x)),
        "isCampaign": isCampaign,
        "quantity": quantity,
        "price": price,
        "kdv": kdv,
        "userId": userId,
        "customerId": customerId,
      };
}
