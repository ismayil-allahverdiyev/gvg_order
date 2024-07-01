import 'dart:convert';

FavouritesModel favouritesModelFromJson(String str) =>
    FavouritesModel.fromJson(json.decode(str));

String favouritesModelToJson(FavouritesModel data) =>
    json.encode(data.toJson());

class FavouritesModel {
  int code;
  bool status;
  String statusText;
  String message;
  dynamic rowCount;
  dynamic totalCount;
  List<FavouriteModel> data;

  FavouritesModel({
    required this.code,
    required this.status,
    required this.statusText,
    required this.message,
    required this.rowCount,
    required this.totalCount,
    required this.data,
  });

  factory FavouritesModel.fromJson(Map<String, dynamic> json) =>
      FavouritesModel(
        code: json["code"],
        status: json["status"],
        statusText: json["statusText"],
        message: json["message"],
        rowCount: json["rowCount"],
        totalCount: json["totalCount"],
        data: List<FavouriteModel>.from(
            json["data"].map((x) => FavouriteModel.fromJson(x))),
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

class FavouriteModel {
  String productId;
  dynamic product;
  String id;
  String userId;
  String customerId;
  DateTime createdDate;
  DateTime modifiedDate;
  bool isDeleted;

  FavouriteModel({
    required this.productId,
    required this.product,
    required this.id,
    required this.userId,
    required this.customerId,
    required this.createdDate,
    required this.modifiedDate,
    required this.isDeleted,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
        productId: json["productId"],
        product: json["product"],
        id: json["id"],
        userId: json["userId"],
        customerId: json["customerId"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "product": product,
        "id": id,
        "userId": userId,
        "customerId": customerId,
        "createdDate": createdDate.toIso8601String(),
        "modifiedDate": modifiedDate.toIso8601String(),
        "isDeleted": isDeleted,
      };
}
