import 'dart:convert';

ListsModel listsModelFromJson(String str) =>
    ListsModel.fromJson(json.decode(str));

String listsModelToJson(ListsModel data) => json.encode(data.toJson());

class ListsModel {
  int code;
  bool status;
  String statusText;
  String message;
  dynamic rowCount;
  dynamic totalCount;
  List<ListModel> data;

  ListsModel({
    required this.code,
    required this.status,
    required this.statusText,
    required this.message,
    required this.rowCount,
    required this.totalCount,
    required this.data,
  });

  factory ListsModel.fromJson(Map<String, dynamic> json) => ListsModel(
        code: json["code"],
        status: json["status"],
        statusText: json["statusText"],
        message: json["message"],
        rowCount: json["rowCount"],
        totalCount: json["totalCount"],
        data: List<ListModel>.from(
            json["data"].map((x) => ListModel.fromJson(x))),
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

class ListModel {
  String currencyId;
  String name;
  DateTime beginDate;
  DateTime endDate;
  String id;
  String userId;
  String customerId;
  DateTime createdDate;
  DateTime modifiedDate;
  bool isDeleted;

  ListModel({
    required this.currencyId,
    required this.name,
    required this.beginDate,
    required this.endDate,
    required this.id,
    required this.userId,
    required this.customerId,
    required this.createdDate,
    required this.modifiedDate,
    required this.isDeleted,
  });

  factory ListModel.fromJson(Map<String, dynamic> json) => ListModel(
        currencyId: json["currencyId"],
        name: json["name"],
        beginDate: DateTime.parse(json["beginDate"]),
        endDate: DateTime.parse(json["endDate"]),
        id: json["id"],
        userId: json["userId"],
        customerId: json["customerId"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "currencyId": currencyId,
        "name": name,
        "beginDate": beginDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "id": id,
        "userId": userId,
        "customerId": customerId,
        "createdDate": createdDate.toIso8601String(),
        "modifiedDate": modifiedDate.toIso8601String(),
        "isDeleted": isDeleted,
      };
}
